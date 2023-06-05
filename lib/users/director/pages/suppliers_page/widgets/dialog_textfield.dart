import 'package:flutter/material.dart';

class DialogTextfield extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final String initialValue;
  final bool valid;
  const DialogTextfield({
    super.key,
    required this.valid,
    required this.hintText,
    required this.initialValue,
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
      child: TextFormField(
        initialValue: initialValue,
        style: const TextStyle(
          fontSize: 14,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: valid ? Colors.black : Colors.redAccent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: valid ? Colors.black : Colors.redAccent,
            ),
          ),
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
