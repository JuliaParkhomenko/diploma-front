import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class SignInButton extends StatelessWidget {
  final bool tapped;
  final bool valid;
  final Function() onPressed;

  const SignInButton({
    super.key,
    required this.onPressed,
    required this.tapped,
    required this.valid,
  });

  @override
  Widget build(BuildContext context) {
    print(valid);
    return IgnorePointer(
      ignoring: tapped,
      child: TextButton(
        onPressed: onPressed,
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
            tapped
                ? Colors.grey
                : (valid ? constants.Colors.main : Colors.redAccent),
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
