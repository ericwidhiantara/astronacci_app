import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_detail_usecase.freezed.dart';
part 'get_user_detail_usecase.g.dart';

class GetUserDetailUsecase
    extends UseCase<UserProfileEntity, GetUserDetailParams> {
  final UserRepository _repo;

  GetUserDetailUsecase(this._repo);

  @override
  Future<Either<Failure, UserProfileEntity>> call(GetUserDetailParams params) =>
      _repo.getUserDetail(params);
}

@freezed
abstract class GetUserDetailParams with _$GetUserDetailParams {
  const factory GetUserDetailParams({
    required String id,
  }) = _GetUserDetailParams;

  const GetUserDetailParams._();

  factory GetUserDetailParams.fromJson(Map<String, dynamic> json) =>
      _$GetUserDetailParamsFromJson(json);
}
