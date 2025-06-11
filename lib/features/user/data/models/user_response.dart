import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_response.freezed.dart';
part 'user_response.g.dart';

@freezed
abstract class UserResponse with _$UserResponse {
  const factory UserResponse({
    MetaResponse? meta,
    PaginationResponse? data,
  }) = _UserResponse;

  const UserResponse._();

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  UserEntity toEntity() => UserEntity(
        meta: meta?.toEntity(),
        data: data?.toEntity(),
      );
}

@freezed
abstract class PaginationResponse with _$PaginationResponse {
  const factory PaginationResponse({
    @JsonKey(name: 'current_page') int? currentPage,
    List<UserDataResponse>? data,
    @JsonKey(name: 'first_page_url') String? firstPageUrl,
    int? from,
    @JsonKey(name: 'last_page') int? lastPage,
    @JsonKey(name: 'last_page_url') String? lastPageUrl,
    List<LinkResponse>? links,
    @JsonKey(name: 'next_page_url') String? nextPageUrl,
    String? path,
    @JsonKey(name: 'per_page') int? perPage,
    @JsonKey(name: 'prev_page_url') String? prevPageUrl,
    int? to,
    int? total,
  }) = _PaginationResponse;

  const PaginationResponse._();

  factory PaginationResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginationResponseFromJson(json);

  PaginationEntity toEntity() => PaginationEntity(
        currentPage: currentPage,
        data: data?.map((e) => e.toEntity()).toList(),
        firstPageUrl: firstPageUrl,
        from: from,
        lastPage: lastPage,
        lastPageUrl: lastPageUrl,
        links: links?.map((e) => e.toEntity()).toList(),
        nextPageUrl: nextPageUrl,
        path: path,
        perPage: perPage,
        prevPageUrl: prevPageUrl,
        to: to,
        total: total,
      );
}

@freezed
abstract class LinkResponse with _$LinkResponse {
  const factory LinkResponse({
    String? url,
    String? label,
    bool? active,
  }) = _LinkResponse;

  const LinkResponse._();

  factory LinkResponse.fromJson(Map<String, dynamic> json) =>
      _$LinkResponseFromJson(json);

  LinkEntity toEntity() => LinkEntity(
        url: url,
        label: label,
        active: active,
      );
}

@freezed
abstract class UserDataResponse with _$UserDataResponse {
  const factory UserDataResponse({
    int? id,
    String? name,
    String? email,
    @JsonKey(name: 'email_verified_at') String? emailVerifiedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    String? avatar,
    String? bio,
    @JsonKey(name: 'date_of_birth') String? dateOfBirth,
    String? gender,
    String? location,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _UserDataResponse;

  const UserDataResponse._();

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);

  UserDataEntity toEntity() => UserDataEntity(
        id: id,
        name: name,
        email: email,
        emailVerifiedAt: emailVerifiedAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
        avatar: avatar,
        bio: bio,
        dateOfBirth: dateOfBirth,
        gender: gender,
        location: location,
        avatarUrl: avatarUrl,
      );
}
