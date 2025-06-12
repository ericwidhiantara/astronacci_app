import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(LoginParams params);

  Future<Either<Failure, RegisterEntity>> register(RegisterParams params);

  Future<Either<Failure, GeneralAPIEntity>> logout();
}
