import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:dartz/dartz.dart';

abstract class GeneralRepository {
  Future<Either<Failure, AppVersionEntity>> checkAppVersion();
}
