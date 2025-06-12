import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  /// Data Source
  final UserRemoteDatasource _datasource;

  const UserRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, UserEntity>> getUserList(
    GetUserListParams params,
  ) async {
    final response = await _datasource.getUserList(params);

    return response.fold(
      (failure) => Left(failure),
      (response) => Right(response.toEntity()),
    );
  }

  @override
  Future<Either<Failure, UserProfileEntity>> getUserProfile() async {
    final response = await _datasource.getUserProfile();

    return response.fold(
      (failure) => Left(failure),
      (response) => Right(response.toEntity()),
    );
  }

  @override
  Future<Either<Failure, GeneralAPIEntity>> changeProfilePicture(
    PostChangeProfilePictureParams params,
  ) async {
    final response = await _datasource.changeProfilePicture(params);

    return response.fold(
      (failure) => Left(failure),
      (response) => Right(response.toEntity()),
    );
  }

  @override
  Future<Either<Failure, GeneralAPIEntity>> changePassword(
    PostChangePasswordParams params,
  ) async {
    final response = await _datasource.changePassword(params);

    return response.fold(
      (failure) => Left(failure),
      (response) => Right(response.toEntity()),
    );
  }

  @override
  Future<Either<Failure, UserProfileEntity>> updateProfile(
    PostUpdateProfileParams params,
  ) async {
    final response = await _datasource.updateProfile(params);

    return response.fold(
      (failure) => Left(failure),
      (response) => Right(response.toEntity()),
    );
  }

  @override
  Future<Either<Failure, UserProfileEntity>> getUserDetail(
      GetUserDetailParams params) async {
    final response = await _datasource.getUserDetail(params);

    return response.fold(
      (failure) => Left(failure),
      (response) => Right(response.toEntity()),
    );
  }
}
