part of 'update_profile_cubit.dart';

@freezed
sealed class UpdateProfileState with _$UpdateProfileState {
  const factory UpdateProfileState.loading() = UpdateProfileStateLoading;

  const factory UpdateProfileState.success(UserProfileEntity data) =
      UpdateProfileStateSuccess;

  const factory UpdateProfileState.failure(Failure type, String message) =
      UpdateProfileStateFailure;

  const factory UpdateProfileState.empty() = UpdateProfileStateEmpty;
}
