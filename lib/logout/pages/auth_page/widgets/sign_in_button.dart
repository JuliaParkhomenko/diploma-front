import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class SignInButton extends StatefulWidget {
  final TextEditingController email;
  final TextEditingController password;

  const SignInButton({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: tapped,
      child: TextButton(
        onPressed: () async {
          setState(() {
            tapped = true;
          });
          final AppStateService service =
              Provider.of<AppStateService>(context, listen: false);
          await service.signIn(
              context, widget.email.text, widget.password.text);
          if (mounted) {
            setState(() {
              tapped = false;
            });
          }
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
          backgroundColor: MaterialStateProperty.all(
            tapped ? Colors.grey : constants.Colors.main,
          ),
        ),
        child: Text(
          'Sign in'.tr(context).toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
