import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'app_version_cubit.freezed.dart';
part 'app_version_state.dart';

class AppVersionCubit extends Cubit<AppVersionState> {
  AppVersionCubit(this._usecase) : super(const AppVersionStateLoading());

  final CheckAppVersionUsecase _usecase;

  PackageInfo? packageInfo;

  Future<void> fetchAppVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
    await _fetchData();
  }

  Future<void> refreshAppVersion() async {
    await _fetchData();
  }

  Future<void> _fetchData() async {
    emit(const AppVersionStateLoading());

    final data = await _usecase.call(null);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(AppVersionStateFailure(l, l.message ?? ""));
        } else if (l is NoDataFailure) {
          emit(const AppVersionStateEmpty());
        } else if (l is UnauthorizedFailure) {
          emit(AppVersionStateFailure(l, l.message ?? ""));
        }
      },
      (r) {
        log.i("ini response $r");
        emit(AppVersionStateSuccess(r));
      },
    );
  }
}
