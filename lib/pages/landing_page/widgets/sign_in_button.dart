import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:routemaster/routemaster.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Routemaster.of(context).push('/sign-in'),
      child: Container(
        alignment: Alignment.center,
        width: 150,
        height: 40,
        decoration: BoxDecoration(
          color: constants.Colors.mainButton,
          border: Border.all(
            width: 2,
            color: constants.Colors.mainButtonBorder,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          'Sign in'.tr().toUpperCase(),
          style: TextStyle(
            color: constants.Colors.mainButtonText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
