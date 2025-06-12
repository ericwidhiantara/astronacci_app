import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_cubit.freezed.dart';
part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this._usecase) : super(const LogoutStateLoading());

  final PostLogoutUsecase _usecase;

  Future<void> logout() async {
    emit(const LogoutStateLoading());
    final data = await _usecase.call(null);

    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(LogoutStateFailure(l, l.message ?? ""));
        } else if (l is NoDataFailure) {
          emit(const LogoutStateEmpty());
        } else if (l is UnauthorizedFailure) {
          emit(LogoutStateFailure(l, l.message ?? ""));
        }
      },
      (r) => emit(LogoutStateSuccess(r)),
    );
  }
}
