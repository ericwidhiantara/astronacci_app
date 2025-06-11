import 'package:boilerplate/core/core.dart';
import 'package:flutter/material.dart';

class AddNavButton extends StatelessWidget {
  const AddNavButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimens.size8),
      height: Dimens.size40,
      width: Dimens.size72,
      decoration: BoxDecoration(
        color: Theme.of(context).extension<CustomColor>()!.primary,
        borderRadius: BorderRadius.circular(Dimens.size20),
        gradient: const LinearGradient(
          colors: [Color(0xFF9C0000), Color(0xFFFA0000)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: Dimens.size20,
      ),
    );
  }
}
