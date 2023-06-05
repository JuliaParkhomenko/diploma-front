import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class LandingButton extends StatelessWidget {
  final Color mainColor;
  const LandingButton({super.key, required this.mainColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Routemaster.of(context).push('/sign-in'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(constants.Colors.mainButton),
        foregroundColor: MaterialStateProperty.all(mainColor),
        side: MaterialStateProperty.all(const BorderSide(
          width: 2,
          color: constants.Colors.mainButtonBorder,
        )),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        )),
      ),
      child: Container(
        alignment: Alignment.center,
        width: 150,
        height: 40,
        child: Text(
          'Sign in'.tr(context).toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
