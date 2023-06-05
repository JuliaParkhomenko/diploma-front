import 'package:flutter/material.dart';

class MaxAmountTextfield extends StatelessWidget {
  final String hintText;
  final Function(int) onChanged;
  const MaxAmountTextfield({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: TextField(
        onChanged: (value) {
          onChanged(int.tryParse(value) ?? 0);
        },
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'OpenSans',
          ),
          alignLabelWithHint: true,
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
