import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailPage extends StatelessWidget {
  final int userId;

  const UserDetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: AppBar(
        title: Text(Strings.of(context)!.userDetail),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<UserDetailCubit, UserDetailState>(
            builder: (context, state) {
              return switch (state) {
                UserDetailStateLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                UserDetailStateSuccess(:final data) => () {
                    final user = data?.data;
                    if (user != null) {
                      return UserDetailCard(user: user);
                    }

                    return const SizedBox();
                  }(),
                UserDetailStateFailure(:final message) => Center(
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
      ),
    );
  }
}
