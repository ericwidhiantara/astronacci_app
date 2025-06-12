import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

abstract class UserRemoteDatasource {
  Future<Either<Failure, UserResponse>> getUserList(
    GetUserListParams params,
  );

  Future<Either<Failure, UserProfileResponse>> getUserProfile();

  Future<Either<Failure, GeneralAPIResponse>> changeProfilePicture(
    PostChangeProfilePictureParams params,
  );
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final DioClient _client;

  UserRemoteDatasourceImpl(this._client);

  @override
  Future<Either<Failure, UserResponse>> getUserList(
    GetUserListParams params,
  ) async {
    final queryParams = <String, String>{};

    queryParams['page'] = params.page.toString();
    queryParams['limit'] = params.limit.toString();

    if (params.search != null) {
      queryParams['search'] = params.search!;
    }

    final uri =
        Uri.parse(ListAPI.getUserList).replace(queryParameters: queryParams);

    final response = await _client.getRequest(
      uri.toString(),
      converter: (response) {
        if (response is Map<String, dynamic>) {
          return UserResponse.fromJson(response);
        }
        return UserResponse(
          meta: MetaResponse(
            code: 500,
            status: "error",
            message: "Terjadi kesalahan pada server, $response",
          ),
        );
      },
    );

    return response;
  }

  @override
  Future<Either<Failure, UserProfileResponse>> getUserProfile() async {
    final response = await _client.getRequest(
      ListAPI.getUserProfile,
      converter: (response) {
        if (response is Map<String, dynamic>) {
          return UserProfileResponse.fromJson(response);
        }
        return UserProfileResponse(
          meta: MetaResponse(
            code: 500,
            status: "error",
            message: "Terjadi kesalahan pada server, $response",
          ),
        );
      },
    );

    return response;
  }

  @override
  Future<Either<Failure, GeneralAPIResponse>> changeProfilePicture(
    PostChangeProfilePictureParams params,
  ) async {
    final String fileName = params.image.split('/').last; //get the filename
    final MediaType mediaType = MediaType.parse(lookupMimeType(params.image)!);
    final FormData formData = FormData.fromMap({
      "avatar": MultipartFile.fromFileSync(
        params.image,
        filename: fileName,
        contentType: mediaType,
      ),
    });

    final response = await _client.postRequest(
      ListAPI.changeProfilePicture,
      formData: formData,
      converter: (response) {
        if (response is Map<String, dynamic>) {
          return GeneralAPIResponse.fromJson(response);
        }
        return GeneralAPIResponse(
          meta: MetaResponse(
            code: 500,
            status: "error",
            message: "Terjadi kesalahan pada server, $response",
          ),
        );
      },
    );

    return response;
  }
}
