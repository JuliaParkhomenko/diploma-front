import 'package:flutter/material.dart';

class NoteTextfield extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final TextEditingController controller;
  const NoteTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 14,
        ),
        controller: controller,
        minLines: 2,
        maxLines: 5,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'OpenSans',
          ),
          alignLabelWithHint: true,
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
