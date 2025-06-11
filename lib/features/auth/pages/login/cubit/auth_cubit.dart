import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._usecase) : super(const AuthStateLoading());

  final PostLoginUsecase _usecase;

  bool? isPasswordHide = true;

  void showHidePassword() {
    emit(const AuthStateInit());
    isPasswordHide = !(isPasswordHide ?? false);
    emit(const AuthStateShowHide());
  }

  Future<void> login(LoginParams params) async {
    emit(const AuthStateLoading());
    final data = await _usecase.call(params);

    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(AuthStateFailure(l.message ?? ""));
        }
      },
      (r) => emit(AuthStateSuccess(r)),
    );
  }

  Future<void> logout() async {
    emit(const AuthStateLoading());
    isPasswordHide = true;
    await MainBoxMixin().logoutBox();
    emit(const AuthStateSuccess(null));
  }
}
