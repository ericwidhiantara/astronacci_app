import 'package:boilerplate/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meta_response.freezed.dart';
part 'meta_response.g.dart';

@freezed
abstract class MetaResponse with _$MetaResponse {
  const factory MetaResponse({
    String? status,
    int? code,
    String? message,
  }) = _MetaResponse;

  const MetaResponse._();

  factory MetaResponse.fromJson(Map<String, dynamic> json) =>
      _$MetaResponseFromJson(json);

  MetaEntity toEntity() => MetaEntity(
        status: status,
        code: code,
        message: message,
      );
}
