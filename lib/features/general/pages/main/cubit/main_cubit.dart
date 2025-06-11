import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_cubit.freezed.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const _Loading());

  int currentIndex = 0;
  late List<DataHelper> dataMenus;

  void updateIndex(int index, {BuildContext? context}) {
    emit(const _Loading());
    currentIndex = index;
    log.i('navbar currentIndex: $currentIndex');

    emit(const _Success());
  }

  bool onBackPressed(
    BuildContext context,
    GlobalKey<ScaffoldState> scaffoldState,
  ) {
    if (dataMenus[currentIndex].title == Strings.of(context)!.dashboard) {
      return true;
    } else {
      if (scaffoldState.currentState!.isEndDrawerOpen) {
        //hide navigation drawer
        scaffoldState.currentState!.openDrawer();
      } else {
        for (final menu in dataMenus) {
          menu.isSelected = menu.title == Strings.of(context)!.dashboard;
        }
      }

      return false;
    }
  }
}
