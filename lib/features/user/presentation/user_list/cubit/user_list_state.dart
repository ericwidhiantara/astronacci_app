part of 'user_list_cubit.dart';

@freezed
sealed class UserListState with _$UserListState {
  const factory UserListState.loading() = UserListStateLoading;

  const factory UserListState.success(UserEntity? data) = UserListStateSuccess;

  const factory UserListState.failure(
    Failure? type,
    String message,
  ) = UserListStateFailure;

  const factory UserListState.empty() = UserListStateEmpty;
}
