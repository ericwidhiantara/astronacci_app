part of 'app_version_cubit.dart';

@freezed
sealed class AppVersionState with _$AppVersionState {
  const factory AppVersionState.loading() = AppVersionStateLoading;

  const factory AppVersionState.success(AppVersionEntity? data) =
      AppVersionStateSuccess;

  const factory AppVersionState.failure(Failure? type, String message) =
      AppVersionStateFailure;

  const factory AppVersionState.empty() = AppVersionStateEmpty;
}
