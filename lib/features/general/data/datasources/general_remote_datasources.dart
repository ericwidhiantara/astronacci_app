import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:dartz/dartz.dart';

abstract class GeneralRemoteDatasource {
  Future<Either<Failure, AppVersionResponse>> checkAppVersion();
}

class GeneralRemoteDatasourceImpl implements GeneralRemoteDatasource {
  final DioClient _client;

  GeneralRemoteDatasourceImpl(this._client);

  @override
  Future<Either<Failure, AppVersionResponse>> checkAppVersion() async {
    final response = await _client.getRequest(
      ListAPI.checkAppVersion,
      converter: (response) {
        if (response is Map<String, dynamic>) {
          return AppVersionResponse.fromJson(response);
        }
        return AppVersionResponse(
          status: 500,
          message: "Terjadi kesalahan pada server, $response",
        );
      },
    );

    return response;
  }
}
