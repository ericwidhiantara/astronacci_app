import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: CustomAppBar(title: Strings.of(context)!.userProfile),
      child: Padding(
        padding: EdgeInsets.all(Dimens.size16),
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            return switch (state) {
              UserProfileStateLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              UserProfileStateSuccess(:final data) => () {
                  final user = data?.data;
                  if (user != null) {
                    return UserProfileCard(user: user);
                  }

                  return const SizedBox();
                }(),
              UserProfileStateFailure(:final message) => Center(
                  child: Empty(
                    errorMessage: message,
                  ),
                ),
              _ => const Center(
                  child: CircularProgressIndicator(),
                ),
            };
          },
        ),
      ),
    );
  }
}
