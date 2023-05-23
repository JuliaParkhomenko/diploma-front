import 'package:flutter/material.dart';

class AmountTextfield extends StatelessWidget {
  final String hintText;
  final Function(int) onChanged;
  final TextEditingController controller;
  const AmountTextfield({
    super.key,
    required this.hintText,
    required this.controller,
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
        onChanged: (value) {
          onChanged(int.tryParse(value) ?? 0);
        },
        style: const TextStyle(
          fontSize: 14,
        ),
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(),
          hintStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'OpenSans',
          ),
          alignLabelWithHint: true,
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}
