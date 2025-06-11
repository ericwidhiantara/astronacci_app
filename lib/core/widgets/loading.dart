import 'package:boilerplate/core/core.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final TextStyle? textStyle;
  final Color? imageColor;
  final bool showMessage;

  const Loading({
    this.showMessage = true,
    this.textStyle,
    this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Dimens.size100 + Dimens.size40,
            child: LinearProgressIndicator(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          ),
          SpacerV(value: Dimens.size20),
          Visibility(
            visible: showMessage,
            child: Text(
              Strings.of(context)!.pleaseWait,
              style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
