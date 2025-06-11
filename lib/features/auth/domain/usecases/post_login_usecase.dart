import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_login_usecase.freezed.dart';
part 'post_login_usecase.g.dart';

class PostLoginUsecase extends UseCase<LoginEntity, LoginParams> {
  final AuthRepository _repo;

  PostLoginUsecase(this._repo);

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) =>
      _repo.login(params);
}

@freezed
abstract class LoginParams with _$LoginParams {
  const factory LoginParams({
    @Default("") String email,
    @Default("") String password,
  }) = _LoginParams;

  factory LoginParams.fromJson(Map<String, dynamic> json) =>
      _$LoginParamsFromJson(json);
}
