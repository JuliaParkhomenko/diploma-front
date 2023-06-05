import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:routemaster/routemaster.dart';

class AddContractButton extends StatelessWidget {
  const AddContractButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Routemaster.of(context).push('/contracts/add');
      },
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
          'Add new'.tr(context),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
