import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class DefaultAddButton extends StatelessWidget {
  final Function() onTap;
  final String buttonText;
  const DefaultAddButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.green.withOpacity(0.7)),
        backgroundColor: MaterialStateProperty.all(constants.Colors.main),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(),
          ),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 160,
        child: Text(
          buttonText.tr(context),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
