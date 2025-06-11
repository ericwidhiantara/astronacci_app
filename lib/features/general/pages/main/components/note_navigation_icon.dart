import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoteNavigationIcon extends StatelessWidget {
  const NoteNavigationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current navigation index from the actual navigation controller
    final currentIndex =
        context.select<MainCubit, int>((cubit) => cubit.currentIndex);
    final isActive = currentIndex == 3;

    return _buildIcon(context, isActive);
  }

  Widget _buildIcon(BuildContext context, bool isActive) {
    return SvgPicture.asset(
      SvgImages.icArrowBackward,
      height: Dimens.size22,
      colorFilter: ColorFilter.mode(
        isActive
            ? Theme.of(context).extension<CustomColor>()!.primary!
            : Theme.of(context).dividerColor,
        BlendMode.srcIn,
      ),
    );
  }
}
