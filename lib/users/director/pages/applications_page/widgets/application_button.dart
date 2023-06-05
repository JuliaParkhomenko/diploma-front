import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';

class ApplicationButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Color color;
  const ApplicationButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.grey),
          ),
        ),
        fixedSize: const MaterialStatePropertyAll(
          Size(120, 40),
        ),
      ),
      onPressed: onTap,
      child: Text(
        text.tr(context),
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }
}
