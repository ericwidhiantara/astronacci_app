import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_cubit.freezed.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final PostRegisterUsecase _usecase;

  /// Handle state visibility password
  bool? isPasswordHide = true;
  bool? isPasswordRepeatHide = true;

  RegisterCubit(this._usecase) : super(const RegisterStateLoading());

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
    final data = await _usecase.call(params);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          final Map<String, dynamic>? errorJson =
              l.error as Map<String, dynamic>?;
          final RegisterErrorEntity? parsedErrors =
              _parseValidationErrors(errorJson);

          emit(RegisterStateFailure(
              l, parsedErrors, l.message ?? "Register failed"));
        }
      },
      (r) => emit(RegisterStateSuccess(r)),
    );
  }
}

RegisterErrorEntity? _parseValidationErrors(Map<String, dynamic>? error) {
  try {
    final fieldErrors = Map<String, List<String>>.from(
      (error?['data']?['error'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, List<String>.from(value as List)),
      ),
    );
    return RegisterErrorEntity(fields: fieldErrors);
  } catch (_) {
    return null;
  }
}
