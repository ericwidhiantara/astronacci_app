import 'dart:io';

import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppVersionPage extends StatefulWidget {
  const AppVersionPage({super.key});

  @override
  State<AppVersionPage> createState() => _AppVersionPageState();
}

class _AppVersionPageState extends State<AppVersionPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppVersionCubit, AppVersionState>(
      builder: (context, state) {
        switch (state) {
          case AppVersionStateLoading():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case AppVersionStateSuccess(:final data):
            return Parent(
              child: ColoredBox(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            Images.icLogo,
                            width: Dimens.size100,
                            height: Dimens.size100,
                          ),
                        ),
                        SpacerV(
                          value: Dimens.size30,
                        ),
                        Text(
                          'Terdapat Versi Baru',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Palette.white,
                                  ),
                        ),
                        SpacerV(
                          value: Dimens.size20,
                        ),
                        Text(
                          'Aplikasi anda saat ini menggunakan versi ${context.read<AppVersionCubit>().packageInfo!.version}, terdapat versi baru yaitu ${data?.data?.appVersion}. Silahkan update aplikasi anda.',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: Dimens.text14,
                                    fontWeight: FontWeight.w400,
                                    color: Palette.white,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        SpacerV(
                          value: Dimens.size20,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimens.size20,
                          ),
                          child: Button(
                            title: "Update",
                            color: Theme.of(context)
                                .extension<CustomColor>()!
                                .card,
                            titleColor: Theme.of(context)
                                .extension<CustomColor>()!
                                .primary,
                            onPressed: () {
                              if (Platform.isAndroid) {
                                Helpers.launch(data?.data?.playStoreUrl ?? '');
                              } else {
                                Helpers.launch(data?.data?.appStoreUrl ?? '');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );

          case AppVersionStateFailure(:final message):
            return Center(
              child: Empty(
                errorMessage: message,
                imageColor: Palette.white,
                textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: Dimens.text14,
                      fontWeight: FontWeight.w400,
                      color: Palette.white,
                    ),
                buttonColor: Theme.of(context).extension<CustomColor>()!.card,
                buttonTitleColor: Theme.of(context).primaryColor,
                onRetry: () {},
              ),
            );

          case AppVersionStateEmpty():
            return const Center(
              child: Empty(
                buttonColor: Palette.white,
                buttonTitleColor: Palette.black,
              ),
            );
        }
      },
    );
  }
}
