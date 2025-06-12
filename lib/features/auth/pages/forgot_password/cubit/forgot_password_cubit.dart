import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_cubit.freezed.dart';
part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._usecase)
      : super(const ForgotPasswordStateLoading());

  final PostForgotPasswordUsecase _usecase;

  Future<void> forgotPassword(ForgotPasswordParams params) async {
    emit(const ForgotPasswordStateLoading());

    final data = await _usecase.call(params);

    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(ForgotPasswordStateFailure(l.message ?? ""));
        }
      },
      (r) => emit(ForgotPasswordStateSuccess(r)),
    );
  }
}
