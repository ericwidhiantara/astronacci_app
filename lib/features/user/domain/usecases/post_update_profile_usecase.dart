import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_update_profile_usecase.freezed.dart';
part 'post_update_profile_usecase.g.dart';

class PostUpdateProfileUsecase
    extends UseCase<UserProfileEntity, PostUpdateProfileParams> {
  final UserRepository _repo;

  PostUpdateProfileUsecase(this._repo);

  @override
  Future<Either<Failure, UserProfileEntity>> call(
    PostUpdateProfileParams params,
  ) =>
      _repo.updateProfile(params);
}

@freezed
abstract class PostUpdateProfileParams with _$PostUpdateProfileParams {
  const factory PostUpdateProfileParams({
    required String name,
    required String email,
    required String bio,
    @JsonKey(name: "date_of_birth") required String dateOfBirth,
    required String gender,
    required String location,
  }) = _PostUpdateProfileParams;

  factory PostUpdateProfileParams.fromJson(Map<String, dynamic> json) =>
      _$PostUpdateProfileParamsFromJson(json);
}
