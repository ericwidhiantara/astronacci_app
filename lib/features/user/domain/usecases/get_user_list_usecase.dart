import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_list_usecase.freezed.dart';
part 'get_user_list_usecase.g.dart';

class GetUserListUsecase extends UseCase<UserEntity, GetUserListParams> {
  final UserRepository _repo;

  GetUserListUsecase(this._repo);

  @override
  Future<Either<Failure, UserEntity>> call(
    GetUserListParams params,
  ) =>
      _repo.getUserList(params);
}

@freezed
abstract class GetUserListParams with _$GetUserListParams {
  const factory GetUserListParams({
    @Default(1) int page,
    @Default(10) int limit,
    @Default("") String? search,
  }) = _GetUserListParams;

  factory GetUserListParams.fromJson(Map<String, dynamic> json) =>
      _$GetUserListParamsFromJson(json);
}
