import 'package:flutter/material.dart';

class DatePickerTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(DateTime) onDateTimeChanged;
  const DatePickerTextField({
    super.key,
    required this.controller,
    required this.onDateTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
      width: 200,
      height: 32,
      child: TextField(
        controller: controller,
        onTap: () {
          _selectDate(context);
        },
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontSize: 14,
          ),
          alignLabelWithHint: true,
          //TODO add to lang file
          suffixIcon: const Icon(Icons.calendar_today),
          contentPadding: const EdgeInsets.only(left: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = picked.toString().substring(0, 10);
      onDateTimeChanged(picked);
    }
  }
}
