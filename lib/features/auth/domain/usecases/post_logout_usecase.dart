import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/helper/entities/entities.dart';
import 'package:dartz/dartz.dart';

class PostLogoutUsecase extends UseCase<GeneralAPIEntity, void> {
  final AuthRepository _repo;

  PostLogoutUsecase(this._repo);

  @override
  Future<Either<Failure, GeneralAPIEntity>> call(void params) => _repo.logout();
}
