import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_cubit.freezed.dart';
part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this._uscase) : super(const UpdateProfileStateLoading());
  final PostUpdateProfileUsecase _uscase;

  Future<void> updateProfile(PostUpdateProfileParams params) async {
    emit(const UpdateProfileStateLoading());
    final data = await _uscase.call(params);

    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(UpdateProfileStateFailure(l, l.message ?? ""));
        } else if (l is NoDataFailure) {
          emit(const UpdateProfileStateEmpty());
        } else if (l is UnauthorizedFailure) {
          emit(UpdateProfileStateFailure(l, l.message ?? ""));
        }
      },
      (r) => emit(UpdateProfileStateSuccess(r)),
    );
  }
}
