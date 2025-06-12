import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_response.freezed.dart';
part 'user_profile_response.g.dart';

@freezed
abstract class UserProfileResponse with _$UserProfileResponse {
  const factory UserProfileResponse({
    MetaResponse? meta,
    UserDataResponse? data,
  }) = _UserProfileResponse;

  const UserProfileResponse._();

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  UserProfileEntity toEntity() => UserProfileEntity(
        meta: meta?.toEntity(),
        data: data?.toEntity(),
      );
}
