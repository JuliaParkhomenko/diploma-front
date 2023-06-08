import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class ExpiringContractsViewMoreButton extends StatelessWidget {
  final Function() onTap;
  const ExpiringContractsViewMoreButton({
    super.key,
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
        height: 37,
        width: 140,
        child: Text(
          'View more'.tr(context),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
