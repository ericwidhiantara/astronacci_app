import 'package:boilerplate/core/core.dart';
import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  final Function(String)? onSearch;

  const CustomSearch({
    super.key,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: Strings.of(context)!.search,
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: onSearch,
          ),
        ),
      ],
    );
  }
}
