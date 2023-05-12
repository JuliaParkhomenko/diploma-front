import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class UseBatchButton extends StatelessWidget {
  final Function(bool) onTap;
  const UseBatchButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        onTap(true);
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 160,
        decoration: BoxDecoration(
          color: constants.Colors.main,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        //TODO add to lang, style
        child: Text(
          'Use'.tr(context),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
