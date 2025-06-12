import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_cubit.freezed.dart';
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._uscase) : super(const ChangePasswordStateLoading());
  final PostChangePasswordUsecase _uscase;

  Future<void> changePassword(PostChangePasswordParams params) async {
    emit(const ChangePasswordStateLoading());
    final data = await _uscase.call(params);

    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(ChangePasswordStateFailure(l, l.message ?? ""));
        } else if (l is NoDataFailure) {
          emit(const ChangePasswordStateEmpty());
        } else if (l is UnauthorizedFailure) {
          emit(ChangePasswordStateFailure(l, l.message ?? ""));
        }
      },
      (r) => emit(ChangePasswordStateSuccess(r)),
    );
  }
}
