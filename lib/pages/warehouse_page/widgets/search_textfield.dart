import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchTextfield extends StatelessWidget {
  final TextEditingController controller;
  const SearchTextfield({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextField(
        style: const TextStyle(
          fontSize: 14,
        ),
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontSize: 14,
          ),
          alignLabelWithHint: true,
          hintText: 'Search by name'.tr(),
          prefixIcon: const Icon(
            Icons.search,
            size: 22,
          ),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}
