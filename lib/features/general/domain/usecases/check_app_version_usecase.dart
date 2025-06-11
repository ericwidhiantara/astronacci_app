import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:dartz/dartz.dart';

class CheckAppVersionUsecase extends UseCase<AppVersionEntity, void> {
  final GeneralRepository _repo;

  CheckAppVersionUsecase(this._repo);

  @override
  Future<Either<Failure, AppVersionEntity>> call(_) => _repo.checkAppVersion();
}
