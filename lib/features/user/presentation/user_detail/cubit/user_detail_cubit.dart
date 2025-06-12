import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_detail_cubit.freezed.dart';
part 'user_detail_state.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit(this._usecase) : super(const UserDetailStateLoading());
  final GetUserDetailUsecase _usecase;

  Future<void> fetchUserDetail(GetUserDetailParams params) async {
    await _fetchData(params);
  }

  Future<void> refreshUser(GetUserDetailParams params) async {
    await _fetchData(params);
  }

  Future<void> _fetchData(GetUserDetailParams params) async {
    final data = await _usecase.call(params);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(UserDetailStateFailure(l, l.message ?? ""));
        } else if (l is NoDataFailure) {
          emit(const UserDetailStateEmpty());
        } else if (l is UnauthorizedFailure) {
          emit(UserDetailStateFailure(l, l.message ?? ""));
        }
      },
      (r) => emit(UserDetailStateSuccess(r)),
    );
  }
}
