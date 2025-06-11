import 'package:boilerplate/features/features.dart';
import 'package:flutter/material.dart';

class UserListSection extends StatelessWidget {
  final ScrollController scrollController;
  final int currentPage;
  final int lastPage;
  final List<UserDataEntity> items;
  final bool isLastPage;

  const UserListSection({
    super.key,
    required this.scrollController,
    required this.currentPage,
    required this.lastPage,
    required this.items,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      controller: scrollController,
      itemCount: isLastPage ? items.length : items.length + 1,
      itemBuilder: (context, index) {
        if (index < items.length) {
          final item = items[index];
          return UserListItem(item: item, index: index);
        }
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
