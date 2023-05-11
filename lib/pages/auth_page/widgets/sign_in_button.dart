import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class SignInButton extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;

  const SignInButton({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final AppStateService service =
            Provider.of<AppStateService>(context, listen: false);
        await service.signIn(context, email.text, password.text);
      },
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        fixedSize: MaterialStateProperty.all(
          const Size(188, 42),
        ),
        backgroundColor: MaterialStateProperty.all(constants.Colors.main),
      ),
      child: Text(
        'Sign in'.tr(context).toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
