import 'package:boilerplate/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'general_api_response.freezed.dart';
part 'general_api_response.g.dart';

@freezed
abstract class GeneralAPIResponse with _$GeneralAPIResponse {
  const factory GeneralAPIResponse({
    MetaResponse? meta,
    GeneralDataAPIResponse? data,
  }) = _GeneralAPIResponse;

  const GeneralAPIResponse._();

  factory GeneralAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$GeneralAPIResponseFromJson(json);

  GeneralAPIEntity toEntity() => GeneralAPIEntity(
        meta: meta?.toEntity(),
        data: data?.toEntity(),
      );
}

@freezed
abstract class GeneralDataAPIResponse with _$GeneralDataAPIResponse {
  const factory GeneralDataAPIResponse({
    bool? success,
    String? message,
  }) = _GeneralDataAPIResponse;

  const GeneralDataAPIResponse._();

  factory GeneralDataAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$GeneralDataAPIResponseFromJson(json);

  GeneralDataAPIEntity toEntity() => GeneralDataAPIEntity(
        success: success,
        message: message,
      );
}
