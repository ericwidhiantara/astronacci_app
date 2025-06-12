import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_picture_cubit.freezed.dart';
part 'profile_picture_state.dart';

class ProfilePictureCubit extends Cubit<ProfilePictureState> {
  ProfilePictureCubit(this._usecase)
      : super(const ProfilePictureStateLoading());
  final PostChangeProfilePictureUsecase _usecase;

  Future<void> changeProfilePicture(
    PostChangeProfilePictureParams params,
  ) async {
    emit(const ProfilePictureStateLoading());
    final data = await _usecase.call(params);

    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(ProfilePictureStateFailure(l, l.message ?? ""));
        } else if (l is NoDataFailure) {
          emit(const ProfilePictureStateEmpty());
        } else if (l is UnauthorizedFailure) {
          emit(ProfilePictureStateFailure(l, l.message ?? ""));
        }
      },
      (r) => emit(ProfilePictureStateSuccess(r)),
    );
  }
}
