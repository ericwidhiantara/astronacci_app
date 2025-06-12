import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:dartz/dartz.dart';

class GetUserProfileUsecase extends UseCase<UserProfileEntity, void> {
  final UserRepository _repo;

  GetUserProfileUsecase(this._repo);

  @override
  Future<Either<Failure, UserProfileEntity>> call(void params) =>
      _repo.getUserProfile();
}
