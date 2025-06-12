import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRemoteDatasource {
  Future<Either<Failure, RegisterResponse>> register(RegisterParams params);

  Future<Either<Failure, LoginResponse>> login(LoginParams params);

  Future<Either<Failure, GeneralAPIResponse>> logout();

  Future<Either<Failure, GeneralAPIResponse>> forgotPassword(
    ForgotPasswordParams params,
  );
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final DioClient _client;

  AuthRemoteDatasourceImpl(this._client);

  @override
  Future<Either<Failure, RegisterResponse>> register(
    RegisterParams params,
  ) async {
    final response = await _client.postRequest(
      ListAPI.register,
      data: params.toJson(),
      converter: (response) =>
          RegisterResponse.fromJson(response as Map<String, dynamic>),
    );

    return response;
  }

  @override
  Future<Either<Failure, LoginResponse>> login(LoginParams params) async {
    final response = await _client.postRequest(
      ListAPI.login,
      data: params.toJson(),
      converter: (response) =>
          LoginResponse.fromJson(response as Map<String, dynamic>),
    );

    return response;
  }

  @override
  Future<Either<Failure, GeneralAPIResponse>> logout() async {
    final response = await _client.postRequest(
      ListAPI.logout,
      converter: (response) =>
          GeneralAPIResponse.fromJson(response as Map<String, dynamic>),
    );

    return response;
  }

  @override
  Future<Either<Failure, GeneralAPIResponse>> forgotPassword(
    ForgotPasswordParams params,
  ) async {
    final response = await _client.postRequest(
      ListAPI.forgotPassword,
      data: params.toJson(),
      converter: (response) =>
          GeneralAPIResponse.fromJson(response as Map<String, dynamic>),
    );

    return response;
  }
}
