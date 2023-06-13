import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class SignInTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function(String) onChanged;
  final bool valid;
  const SignInTextField({
    super.key,
    this.obscureText = false,
    required this.valid,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(
          obscureText ? Icons.lock : Icons.email,
        ),
        hintText: hintText, // Placeholder text
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: valid ? constants.Colors.main : Colors.redAccent,
            width: 2,
          ),
        ),
        focusColor: constants.Colors.main,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: valid ? Colors.black : Colors.redAccent,
          ),
        ), // Border style
        filled: true, // Background color
        fillColor: Colors.grey[200], // Background color
      ),
      obscureText: obscureText,
    );
  }
}
