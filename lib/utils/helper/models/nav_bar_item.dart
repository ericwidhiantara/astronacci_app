import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';

part 'nav_bar_item.freezed.dart';

@freezed
abstract class NavBarItem with _$NavBarItem {
  factory NavBarItem({
    /// Path in the router.
    required String path,

    /// Name in the router.
    required String name,

    /// Widget to show when navigating to this [path].
    required Widget widget,

    /// Icon in the navigation bar.
    required String icon,

    /// The subroutes of the route from this [path].
    @Default(<RouteBase>[]) List<RouteBase> routes,
  }) = _NavBarItem;
}
