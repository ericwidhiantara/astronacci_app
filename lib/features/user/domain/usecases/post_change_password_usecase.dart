import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_change_password_usecase.freezed.dart';
part 'post_change_password_usecase.g.dart';

class PostChangePasswordUsecase
    extends UseCase<GeneralAPIEntity, PostChangePasswordParams> {
  final UserRepository _repo;

  PostChangePasswordUsecase(this._repo);

  @override
  Future<Either<Failure, GeneralAPIEntity>> call(
    PostChangePasswordParams params,
  ) =>
      _repo.changePassword(params);
}

@freezed
abstract class PostChangePasswordParams with _$PostChangePasswordParams {
  const factory PostChangePasswordParams({
    @JsonKey(name: "old_password") required String currentPassword,
    @JsonKey(name: "password") required String newPassword,
    @JsonKey(name: "password_confirmation") required String confirmPassword,
  }) = _PostChangePasswordParams;

  factory PostChangePasswordParams.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PostChangePasswordParamsFromJson(json);
}
