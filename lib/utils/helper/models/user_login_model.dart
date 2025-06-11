import 'package:boilerplate/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_login_model.freezed.dart';
part 'user_login_model.g.dart';

@freezed
abstract class UserLoginModel with _$UserLoginModel {
  const factory UserLoginModel({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'full_name') String? fullname,
    @JsonKey(name: 'username') String? username,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'created_at') int? createdAt,
    @JsonKey(name: 'updated_at') int? updatedAt,
  }) = _UserLoginModel;

  const UserLoginModel._();

  factory UserLoginModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginModelFromJson(json);

  UserLoginEntity toEntity() => UserLoginEntity(
        id: id,
        email: email,
        fullname: fullname,
        username: username,
        isActive: isActive,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
