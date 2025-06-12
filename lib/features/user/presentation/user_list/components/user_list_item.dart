import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserListItem extends StatelessWidget {
  final UserDataEntity item;
  final int index;

  const UserListItem({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).extension<CustomColor>()!.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            onTap: () => context.pushNamed(
              Routes.userDetail.name,
              extra: item.id,
            ),
            title: Text(
              item.name ?? "",
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              item.email ?? "",
              style: const TextStyle(color: Colors.white70),
            ),
            leading: CircleAvatar(
              backgroundColor: Palette.white,
              backgroundImage: NetworkImage(item.avatarUrl ?? ""),
            ),
          ),
        ),
      ],
    );
  }
}
