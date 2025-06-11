import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_register_usecase.freezed.dart';
part 'post_register_usecase.g.dart';

class PostRegisterUsecase extends UseCase<RegisterEntity, RegisterParams> {
  final AuthRepository _repo;

  PostRegisterUsecase(this._repo);

  @override
  Future<Either<Failure, RegisterEntity>> call(RegisterParams params) =>
      _repo.register(params);
}

@freezed
abstract class RegisterParams with _$RegisterParams {
  const factory RegisterParams({
    @Default("") String name,
    @Default("") String email,
    @Default("") String password,
    @JsonKey(name: "password_confirmation")
    @Default("")
    String passwordConfirmation,
  }) = _RegisterParams;

  factory RegisterParams.fromJson(Map<String, dynamic> json) =>
      _$RegisterParamsFromJson(json);
}
