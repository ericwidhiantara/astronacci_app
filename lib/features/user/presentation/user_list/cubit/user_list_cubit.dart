import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_list_cubit.freezed.dart';
part 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  UserListCubit(this._usecase) : super(const UserListStateLoading());
  final GetUserListUsecase _usecase;

  Future<void> fetchUserList(GetUserListParams params) async {
    /// Only show loading in 1 page
    await _fetchData(params);
  }

  Future<void> refreshUser(GetUserListParams params) async {
    await _fetchData(params);
  }

  Future<void> _fetchData(GetUserListParams params) async {
    if (params.page == 1) {
      emit(const UserListStateLoading());
    }

    final data = await _usecase.call(params);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(UserListStateFailure(l, l.message ?? ""));
        } else if (l is NoDataFailure) {
          emit(const UserListStateEmpty());
        } else if (l is UnauthorizedFailure) {
          emit(UserListStateFailure(l, l.message ?? ""));
        }
      },
      (r) => emit(UserListStateSuccess(r)),
    );
  }
}
