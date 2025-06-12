part of 'user_profile_cubit.dart';

@freezed
sealed class UserProfileState with _$UserProfileState {
  const factory UserProfileState.loading() = UserProfileStateLoading;

  const factory UserProfileState.success(UserProfileEntity? data) =
      UserProfileStateSuccess;

  const factory UserProfileState.failure(
    Failure? type,
    String message,
  ) = UserProfileStateFailure;

  const factory UserProfileState.empty() = UserProfileStateEmpty;
}
