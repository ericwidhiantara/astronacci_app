import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/dependencies_injection.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient with MainBoxMixin, FirebaseCrashLogger {
  final String baseUrl = const String.fromEnvironment("BASE_URL");
  final bool isUnitTest;
  late Dio _dio;
  String? _auth;

  DioClient({this.isUnitTest = false}) {
    _auth = _loadToken();
    _dio = _createDio();
    if (!isUnitTest) _dio.interceptors.add(DioInterceptor());
  }

  Dio get dio {
    if (isUnitTest) return _dio;
    _auth = _loadToken();
    final dio = _createDio();
    dio.interceptors.add(DioInterceptor());
    dio.addSentry(captureFailedRequests: true);

    return dio;
  }

  String? _loadToken() {
    try {
      final token = getData<String>(MainBoxKeys.token);
      if (token == null) {
        developer.log(
            "Token not found in ObjectBox for key: ${MainBoxKeys.token.name}",
            name: 'DioClient');
        return null;
      }
      if (token.isEmpty) {
        developer.log(
            "Token is empty in ObjectBox for key: ${MainBoxKeys.token.name}",
            name: 'DioClient');
        return null;
      }
      developer.log("Token loaded successfully: $token", name: 'DioClient');
      return token;
    } catch (e, stackTrace) {
      developer.log("Error loading token from ObjectBox: $e",
          name: 'DioClient', error: e, stackTrace: stackTrace);
      nonFatalError(error: e, stackTrace: stackTrace);
      return null;
    }
  }

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            if (_auth != null) 'Authorization': "Bearer $_auth",
          },
          receiveTimeout: const Duration(minutes: 1),
          connectTimeout: const Duration(minutes: 1),
          validateStatus: (status) => status != null && status > 0,
        ),
      );

  Future<Either<Failure, T>> _handleRequest<T>(
    Future<Response> Function() request, {
    required ResponseConverter<T> converter,
    bool isIsolate = true,
  }) async {
    try {
      final response = await request();

      // Check for non-200 status codes
      if (response.statusCode != 200) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      // Parse the response
      return isIsolate
          ? await _processResponseInIsolate(response, converter)
          : Right(converter(response.data));
    } on DioException catch (e, stackTrace) {
      // Handle Dio-specific exceptions
      return await _handleError(e, stackTrace);
    } catch (e, stackTrace) {
      // Catch any other exceptions and log them
      await _logError(e, stackTrace);
      return Left(ServerFailure("Unexpected error: $e"));
    }
  }

  Future<Either<Failure, T>> _processResponseInIsolate<T>(
    Response response,
    ResponseConverter<T> converter,
  ) async {
    if (response.data is! Map<String, dynamic>) {
      await _logError(response);
      final responseData = response.data; // Cache for better readability

      // Handle cases where response.data is not a Map
      final message = responseData is Map<String, dynamic>
          ? responseData["message"]?.toString()
          : "Response is not a map, please check the server: $responseData";

      return Left(ServerFailure(message));
    }

    // If response.data is a Map, proceed
    final isolateParse = IsolateParser<T>(
      response.data as Map<String, dynamic>,
      converter,
    );
    final result = await isolateParse.parseInBackground();
    return Right(result);
  }

  Future<Either<Failure, T>> _handleError<T>(
    DioException e,
    StackTrace stackTrace,
  ) async {
    // Log the error and stack trace
    await _logError(e, stackTrace);

    // Handle specific DioException types
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const Left(
          ServerFailure("Koneksi ke server gagal, silakan coba lagi nanti."),
        );
      case DioExceptionType.receiveTimeout:
        return const Left(
          ServerFailure("Koneksi ke server gagal, silakan coba lagi nanti."),
        );
      case DioExceptionType.connectionError:
        return const Left(
          ServerFailure("Tidak ada koneksi internet, silakan coba lagi nanti."),
        );
      case DioExceptionType.badCertificate:
        return const Left(ServerFailure("Validasi sertifikat SSL gagal."));
      case DioExceptionType.cancel:
        return const Left(ServerFailure("Permintaan telah dibatalkan."));
      case DioExceptionType.badResponse:
        // Handle bad response from server
        final statusCode = e.response?.statusCode;
        final errorMessage = e.response?.data?["message"]?.toString() ??
            "Terjadi kesalahan. Kode: $statusCode - ${e.response?.statusMessage}";

        return Left(ServerFailure(errorMessage));

      case DioExceptionType.unknown:
      default:
        final errorMessage = e.message ??
            e.response?.data["message"] ??
            "Kesalahan tidak diketahui.";
        final statusCode = e.response?.statusCode;
        log.e("Error: ${e.error} ${e.response} $e");
        if (statusCode == 401 ||
            e.response?.data["message"] == "Unauthorized") {
          sl<AuthCubit>().logout();
          return Left(UnauthorizedFailure(errorMessage.toString()));
        }
        if (statusCode == 429) {
          return const Left(
            ServerFailure(
              "Terlalu banyak permintaan, silakan coba lagi nanti.",
            ),
          );
        }
        if (e.error is HandshakeException) {
          return const Left(
            ServerFailure("Koneksi gagal: masalah pada sertifikat SSL."),
          );
        } else if (e.error is SocketException) {
          return const Left(
            ServerFailure("Tidak dapat terhubung ke server."),
          );
        } else if (e.error is TimeoutException) {
          return const Left(
            ServerFailure("Koneksi gagal: waktu permintaan habis."),
          );
        }

        return Left(ServerFailure("Ada kesalahan: $errorMessage"));
    }
  }

  Future<void> _logError(Object error, [StackTrace? stackTrace]) async {
    // Check if the error is DioException to log request and response details
    if (error is DioException) {
      final requestOptions = error.requestOptions;

      // Prepare detailed information about the request
      final requestInfo = {
        "url": requestOptions.uri.toString(),
        "headers": requestOptions.headers,
        "data": requestOptions.data,
      };

      // Prepare detailed information about the response (if available)
      final responseInfo = error.response != null
          ? {
              "status_code": error.response?.statusCode,
              "headers": error.response?.headers.map,
              "data": error.response?.data,
              "error": error,
            }
          : {"error": "No response received"};

      // Add details to Firebase Crashlytics as custom keys
      FirebaseCrashlytics.instance
          .setCustomKey("request_url", requestOptions.uri.toString());
      FirebaseCrashlytics.instance
          .setCustomKey("request_headers", requestOptions.headers.toString());
      FirebaseCrashlytics.instance.setCustomKey(
        "request_data",
        requestOptions.data?.toString() ?? "No data",
      );
      if (error.response != null) {
        FirebaseCrashlytics.instance.setCustomKey(
          "response_status_code",
          error.response?.statusCode ?? 0,
        );
        FirebaseCrashlytics.instance.setCustomKey(
          "response_headers",
          error.response?.headers.map.toString() ?? {}.toString(),
        );
        FirebaseCrashlytics.instance.setCustomKey(
          "response_data",
          error.response?.data?.toString() ?? "No data",
        );
      }

      // Add breadcrumb to Sentry for debugging
      Sentry.addBreadcrumb(
        Breadcrumb(
          category: "http",
          message: "Dio request failed",
          data: {
            "request": requestInfo,
            "response": responseInfo,
          },
          level: SentryLevel.error,
        ),
      );

      // Include request and response details in the error sent to Sentry
      await Sentry.captureException(
        error,
        stackTrace: stackTrace,
        withScope: (scope) {
          scope.setContexts("request", requestInfo);
          scope.setContexts("response", responseInfo);
        },
      );
    } else {
      // Log non-Dio errors to Sentry
      await Sentry.captureException(error, stackTrace: stackTrace);
    }

    // Log the error to Firebase Crashlytics with additional details
    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      printDetails: true,
    );

    // Log non-fatal errors to the internal logging system (if not in unit tests)
    if (!isUnitTest) {
      nonFatalError(error: error, stackTrace: stackTrace ?? StackTrace.current);
    }
  }

  Future<Either<Failure, T>> getRequest<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    required ResponseConverter<T> converter,
    bool isIsolate = true,
  }) =>
      _handleRequest(
        () => dio.get(url, queryParameters: queryParameters),
        converter: converter,
        isIsolate: isIsolate,
      );

  Future<Either<Failure, T>> postRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    FormData? formData,
    required ResponseConverter<T> converter,
    bool isIsolate = true,
  }) =>
      _handleRequest(
        () => dio.post(url, data: formData ?? data),
        converter: converter,
        isIsolate: isIsolate,
      );

  Future<Either<Failure, T>> patchRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
    bool isIsolate = true,
  }) =>
      _handleRequest(
        () => dio.patch(url, data: data),
        converter: converter,
        isIsolate: isIsolate,
      );

  Future<Either<Failure, T>> deleteRequest<T>(
    String url, {
    required ResponseConverter<T> converter,
    bool isIsolate = true,
  }) =>
      _handleRequest(
        () => dio.delete(url),
        converter: converter,
        isIsolate: isIsolate,
      );
}
