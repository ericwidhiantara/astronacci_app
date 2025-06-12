import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_change_profile_picture_usecase.freezed.dart';
part 'post_change_profile_picture_usecase.g.dart';

class PostChangeProfilePictureUsecase
    extends UseCase<GeneralAPIEntity, PostChangeProfilePictureParams> {
  final UserRepository _repo;

  PostChangeProfilePictureUsecase(this._repo);

  @override
  Future<Either<Failure, GeneralAPIEntity>> call(
    PostChangeProfilePictureParams params,
  ) =>
      _repo.changeProfilePicture(params);
}

@freezed
abstract class PostChangeProfilePictureParams
    with _$PostChangeProfilePictureParams {
  const factory PostChangeProfilePictureParams({
    @JsonKey(name: "avatar") required String image,
  }) = _PostChangeProfilePictureParams;

  factory PostChangeProfilePictureParams.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PostChangeProfilePictureParamsFromJson(json);
}
