import 'package:boilerplate/features/features.dart';
import 'package:flutter/material.dart';

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
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            onTap: () {},
            title: Text(
              item.name ?? "",
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              item.email ?? "",
              style: const TextStyle(color: Colors.white70),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(item.avatarUrl ?? ""),
            ),
          ),
        ),
      ],
    );
  }
}
