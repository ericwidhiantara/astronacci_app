import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_cubit.freezed.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final PostRegister _postRegister;

  /// Handle state visibility password
  bool? isPasswordHide = true;
  bool? isPasswordRepeatHide = true;

  RegisterCubit(this._postRegister) : super(const RegisterStateLoading());

  void showHidePassword() {
    emit(const RegisterStateInit());
    isPasswordHide = !(isPasswordHide ?? false);
    emit(const RegisterStateShowHide());
  }

  void showHidePasswordRepeat() {
    emit(const RegisterStateInit());
    isPasswordRepeatHide = !(isPasswordRepeatHide ?? false);
    emit(const RegisterStateShowHide());
  }

  Future<void> register(RegisterParams params) async {
    emit(const RegisterStateLoading());
    final data = await _postRegister.call(params);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(RegisterStateFailure(l.message ?? ""));
        }
      },
      (r) => emit(RegisterStateSuccess(r.token)),
    );
  }
}
