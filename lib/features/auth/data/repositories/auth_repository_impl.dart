import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/auth/auth.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  /// Data Source
  final AuthRemoteDatasource _dataSource;
  final MainBoxMixin mainBoxMixin;

  const AuthRepositoryImpl(this._dataSource, this.mainBoxMixin);

  @override
  Future<Either<Failure, LoginEntity>> login(LoginParams params) async {
    final response = await _dataSource.login(params);

    return response.fold(
      (failure) => Left(failure),
      (response) {
        mainBoxMixin.addData(MainBoxKeys.isLogin, true);
        mainBoxMixin.addData(MainBoxKeys.token, response.data?.token);

        return Right(response.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, Register>> register(
    RegisterParams registerparams,
  ) async {
    final response = await _dataSource.register(registerparams);

    return response.fold(
      (failure) => Left(failure),
      (response) {
        return Right(response.toEntity());
      },
    );
  }
}
