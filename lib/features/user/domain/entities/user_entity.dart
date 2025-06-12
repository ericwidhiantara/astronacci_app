import 'package:boilerplate/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    MetaEntity? meta,
    PaginationEntity? data,
  }) = _UserEntity;

  const UserEntity._();
}

@freezed
abstract class PaginationEntity with _$PaginationEntity {
  const factory PaginationEntity({
    int? currentPage,
    List<UserDataEntity>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<LinkEntity>? links,
    String? nextPageUrl,
    String? path,
    int? perPage,
    String? prevPageUrl,
    int? to,
    int? total,
  }) = _PaginationEntity;

  const PaginationEntity._();
}

@freezed
abstract class LinkEntity with _$LinkEntity {
  const factory LinkEntity({
    String? url,
    String? label,
    bool? active,
  }) = _LinkEntity;

  const LinkEntity._();
}

@freezed
abstract class UserDataEntity with _$UserDataEntity {
  const factory UserDataEntity({
    int? id,
    String? name,
    String? email,
    String? emailVerifiedAt,
    String? createdAt,
    String? updatedAt,
    String? avatar,
    String? bio,
    String? dateOfBirth,
    String? gender,
    String? location,
    String? avatarUrl,
  }) = _UserDataEntity;

  const UserDataEntity._();

  factory UserDataEntity.fromJson(Map<String, dynamic> json) =>
      _$UserDataEntityFromJson(json);
}
