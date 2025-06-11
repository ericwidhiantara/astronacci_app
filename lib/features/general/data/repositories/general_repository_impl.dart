import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:dartz/dartz.dart';

class GeneralRepositoryImpl implements GeneralRepository {
  /// Data Source
  final GeneralRemoteDatasource _dataSource;

  const GeneralRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, AppVersionEntity>> checkAppVersion() async {
    final response = await _dataSource.checkAppVersion();

    return response.fold(
      (failure) => Left(failure),
      (response) {
        return Right(response.toEntity());
      },
    );
  }
}
