import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_forgot_password_usecase.freezed.dart';
part 'post_forgot_password_usecase.g.dart';

class PostForgotPasswordUsecase
    extends UseCase<GeneralAPIEntity, ForgotPasswordParams> {
  final AuthRepository _repo;

  PostForgotPasswordUsecase(this._repo);

  @override
  Future<Either<Failure, GeneralAPIEntity>> call(ForgotPasswordParams params) =>
      _repo.forgotPassword(params);
}

@freezed
abstract class ForgotPasswordParams with _$ForgotPasswordParams {
  const factory ForgotPasswordParams({
    @Default("") String email,
  }) = _ForgotPasswordParams;

  const ForgotPasswordParams._();

  factory ForgotPasswordParams.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordParamsFromJson(json);
}
