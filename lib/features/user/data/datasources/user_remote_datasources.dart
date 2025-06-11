import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:dartz/dartz.dart';

abstract class UserRemoteDatasource {
  Future<Either<Failure, UserResponse>> getUserList(
    GetUserListParams params,
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
}
