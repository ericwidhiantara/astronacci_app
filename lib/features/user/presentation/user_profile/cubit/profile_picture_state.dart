part of 'profile_picture_cubit.dart';

@freezed
sealed class ProfilePictureState with _$ProfilePictureState {
  const factory ProfilePictureState.loading() = ProfilePictureStateLoading;

  const factory ProfilePictureState.success(GeneralAPIEntity data) =
      ProfilePictureStateSuccess;

  const factory ProfilePictureState.failure(Failure type, String message) =
      ProfilePictureStateFailure;

  const factory ProfilePictureState.empty() = ProfilePictureStateEmpty;
}
