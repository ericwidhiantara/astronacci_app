import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.navBarItems,
    required this.navigationShell,
  });

  final List<NavBarItem> navBarItems;
  final StatefulNavigationShell navigationShell;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> _labels = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateLabels();
  }

  @override
  void initState() {
    super.initState();
    // OneSignalHelpers.clickNotification(context);
    // OneSignalHelpers.receiveNotification(context);
  }

  void _updateLabels() {
    _labels = [
      "Home",
      "Data",
      "",
      "Data",
      "Profile",
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.navigationShell.currentIndex;
    final customColors = Theme.of(context).extension<CustomColor>()!;

    return PopScope(
      onPopInvokedWithResult: (didPop, _) =>
          context.read<MainCubit>().onBackPressed(context, _scaffoldKey),
      child: Scaffold(
        key: _scaffoldKey,
        body: widget.navigationShell,
        bottomNavigationBar: _buildNavBar(currentIndex, customColors),
      ),
    );
  }

  Widget? _buildNavBar(int currentIndex, CustomColor customColors) {
    if (currentIndex < 0) return null;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: customColors.primary,
      selectedFontSize: Dimens.size12,
      unselectedFontSize: Dimens.size10,
      iconSize: Dimens.size20,
      items: [
        _buildNavItem(0, widget.navBarItems[0].icon),
        _buildNavItem(1, widget.navBarItems[1].icon),
        const BottomNavigationBarItem(
          icon: AddNavButton(),
          label: '',
        ),
        _buildNavItem(3, widget.navBarItems[3].icon),
        _buildNavItem(4, widget.navBarItems[4].icon),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(int index, String iconPath) {
    return BottomNavigationBarItem(
      icon: NavBarIcon(
        iconPath: iconPath,
        isActive: widget.navigationShell.currentIndex == index,
      ),
      label: _labels[index],
    );
  }

  void _onTap(BuildContext context, int index) {
    context.read<MainCubit>().updateIndex(index, context: context);
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
