import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUserList(
    GetUserListParams params,
  );

  Future<Either<Failure, UserProfileEntity>> getUserProfile();

  Future<Either<Failure, GeneralAPIEntity>> changeProfilePicture(
    PostChangeProfilePictureParams params,
  );

  Future<Either<Failure, GeneralAPIEntity>> changePassword(
    PostChangePasswordParams params,
  );

  Future<Either<Failure, UserProfileEntity>> updateProfile(
    PostUpdateProfileParams params,
  );
}
