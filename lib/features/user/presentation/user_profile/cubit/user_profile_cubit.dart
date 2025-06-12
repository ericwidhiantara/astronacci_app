import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_cubit.freezed.dart';
part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit(this._usecase) : super(const UserProfileStateLoading());
  final GetUserProfileUsecase _usecase;

  Future<void> fetchUserProfile() async {
    await _fetchData();
  }

  Future<void> refreshUser() async {
    await _fetchData();
  }

  Future<void> _fetchData() async {
    final data = await _usecase.call(null);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(UserProfileStateFailure(l, l.message ?? ""));
        } else if (l is NoDataFailure) {
          emit(const UserProfileStateEmpty());
        } else if (l is UnauthorizedFailure) {
          emit(UserProfileStateFailure(l, l.message ?? ""));
        }
      },
      (r) => emit(UserProfileStateSuccess(r)),
    );
  }
}
