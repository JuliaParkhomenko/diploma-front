import 'package:flutter/material.dart';

class SearchTextfield extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  const SearchTextfield({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontSize: 14,
          ),
          alignLabelWithHint: true,
          hintText: hintText,
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
