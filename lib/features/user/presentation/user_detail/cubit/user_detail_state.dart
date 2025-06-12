part of 'user_detail_cubit.dart';

@freezed
sealed class UserDetailState with _$UserDetailState {
  const factory UserDetailState.loading() = UserDetailStateLoading;

  const factory UserDetailState.success(UserProfileEntity? data) =
      UserDetailStateSuccess;

  const factory UserDetailState.failure(
    Failure? type,
    String message,
  ) = UserDetailStateFailure;

  const factory UserDetailState.empty() = UserDetailStateEmpty;
}
