import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_entity.freezed.dart';

@freezed
abstract class UserProfileEntity with _$UserProfileEntity {
  const factory UserProfileEntity({
    MetaEntity? meta,
    UserDataEntity? data,
  }) = _UserProfileEntity;

  const UserProfileEntity._();
}
