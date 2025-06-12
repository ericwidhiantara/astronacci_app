import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdateProfilePage extends StatelessWidget {
  final UserDataEntity profile;

  const UpdateProfilePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: CustomAppBar(title: Strings.of(context)!.updateProfile),
      child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) => switch (state) {
          UpdateProfileStateLoading() => context.show(),
          UpdateProfileStateSuccess(:final data) => (() {
              context.dismiss();
              data.meta?.message.toString().toToastSuccess(context);
              context.back(true);
            })(),
          UpdateProfileStateFailure(:final type, :final message) => (() {
              if (type is UnauthorizedFailure) {
                Strings.of(context)!.expiredToken.toToastError(context);
                context.goNamed(Routes.login.name);
              } else {
                context.dismiss();
                message.toToastError(context);
              }
            })(),
          _ => {},
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: UpdateProfileSection(profile: profile),
        ),
      ),
    );
  }
}
