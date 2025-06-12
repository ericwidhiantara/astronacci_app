import 'package:boilerplate/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<DataHelper> with MainBoxMixin {
  SettingsCubit() : super(DataHelper(type: "en"));

  void updateTheme(ActiveTheme activeTheme) {
    addData<String>(MainBoxKeys.theme, activeTheme.name);
    emit(
      DataHelper(
        activeTheme: activeTheme,
        type: getData<String>(MainBoxKeys.locale) ?? "en",
      ),
    );
  }

  void updateLanguage(String type) {
    /// Update locale code
    addData<String>(MainBoxKeys.locale, type);
    emit(DataHelper(type: type, activeTheme: getActiveTheme()));
  }

  ActiveTheme getActiveTheme() {
    final activeTheme = ActiveTheme.values.singleWhere(
      (element) =>
          element.name ==
          (getData<String>(MainBoxKeys.theme) ?? ActiveTheme.system.name),
    );
    log.d("activeTheme : ${activeTheme.name}");
    emit(
      DataHelper(
        activeTheme: activeTheme,
        type: getData<String>(MainBoxKeys.locale) ?? "en",
      ),
    );
    return activeTheme;
  }
}
