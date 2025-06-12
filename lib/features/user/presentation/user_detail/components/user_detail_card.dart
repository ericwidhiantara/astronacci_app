import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/helper/data_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UserDetailCard extends StatelessWidget {
  final UserDataEntity user;

  const UserDetailCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: CachedNetworkImage(
            imageUrl: user.avatarUrl ??
                "https://images.unsplash.com/photo-1499714608240-22fc6ad53fb2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: Dimens.size80,
              backgroundImage: imageProvider,
              backgroundColor: Palette.primary,
            ),
            errorWidget: (context, url, error) => CircleAvatar(
              radius: Dimens.size80,
              backgroundImage: const NetworkImage("https://fakeimg.pl/150x150"),
              backgroundColor: Palette.primary,
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const Center(child: CircularProgressIndicator()),
          ),
        ),
        SpacerV(value: Dimens.size20),
        Text(
          Strings.of(context)!.name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          user.name ?? "",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Dimens.text18,
              ),
        ),
        SpacerV(value: Dimens.size16),
        Text(
          Strings.of(context)!.email,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          user.email ?? "",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Dimens.text18,
              ),
        ),
        SpacerV(value: Dimens.size16),
        Text(
          Strings.of(context)!.dateOfBirth,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        BlocBuilder<SettingsCubit, DataHelper>(
          builder: (context, state) {
            return Text(
              DateFormat(
                "EEEE, dd MMMM yyyy",
                state.type == "en" ? "en" : "id",
              ).format(
                DateTime.parse(user.dateOfBirth ?? DateTime.now().toString()),
              ),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: Dimens.text18,
                  ),
            );
          },
        ),
        SpacerV(value: Dimens.size16),
        Text(
          Strings.of(context)!.gender,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          user.gender == "male"
              ? Strings.of(context)!.male
              : Strings.of(context)!.female,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Dimens.text18,
              ),
        ),
        SpacerV(value: Dimens.size16),
        Text(
          Strings.of(context)!.address,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          user.location ?? "",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Dimens.text18,
              ),
        ),
        SpacerV(value: Dimens.size16),
        Text(
          Strings.of(context)!.bio,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          user.bio ?? "",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Dimens.text18,
              ),
        ),
      ],
    );
  }
}
