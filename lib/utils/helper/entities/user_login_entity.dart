import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_login_entity.freezed.dart';
part 'user_login_entity.g.dart';

@freezed
abstract class UserLoginEntity with _$UserLoginEntity {
  const factory UserLoginEntity({
    String? id,
    String? email,
    String? fullname,
    String? username,
    bool? isActive,
    int? createdAt,
    int? updatedAt,
  }) = _UserLoginEntity;

  const UserLoginEntity._();

  factory UserLoginEntity.fromJson(Map<String, dynamic> json) =>
      _$UserLoginEntityFromJson(json);
}
