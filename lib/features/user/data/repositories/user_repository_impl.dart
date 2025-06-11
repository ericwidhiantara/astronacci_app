import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
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
}
