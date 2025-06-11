import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRemoteDatasource {
  Future<Either<Failure, RegisterResponse>> register(RegisterParams params);

  Future<Either<Failure, LoginResponse>> login(LoginParams params);
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
}
