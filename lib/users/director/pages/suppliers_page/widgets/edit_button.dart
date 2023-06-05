import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class EditButton extends StatelessWidget {
  final Function() onTap;
  final bool valid;

  const EditButton({
    super.key,
    required this.valid,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          valid ? Colors.green.withOpacity(0.7) : Colors.red.withOpacity(.7),
        ),
        backgroundColor: MaterialStateProperty.all(
            valid ? constants.Colors.main : Colors.redAccent),
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
          'Edit'.tr(context),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
