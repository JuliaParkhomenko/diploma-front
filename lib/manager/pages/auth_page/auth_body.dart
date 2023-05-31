import 'package:diploma_frontend/manager/pages/auth_page/widgets/sign_in_button.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class AuthBody extends StatefulWidget {
  const AuthBody({super.key});

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  final TextEditingController email =
      TextEditingController(text: 'parhomylia@gmail.com');
  final TextEditingController password =
      TextEditingController(text: 'Yul!1234567');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * .2,
        ),
        Center(
          child: Text(
            'Sign in to your account'.tr(context),
            style: const TextStyle(
              color: constants.Colors.main,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        SizedBox(
          width: size.width * .3,
          child: TextField(
            controller: email,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email),
              hintText: 'Email', // Placeholder text
              border: const OutlineInputBorder(), // Border style
              filled: true, // Background color
              fillColor: Colors.grey[200], // Background color
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: size.width * .3,
          child: TextField(
            controller: password,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              hintText: 'Password', // Placeholder text
              border: const OutlineInputBorder(), // Border style
              filled: true, // Background color
              fillColor: Colors.grey[200], // Background color
            ),
            obscureText: true,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Forgot your password?'.tr(context),
          style: const TextStyle(
            decoration: TextDecoration.underline,
            fontFamily: 'OpenSans',
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SignInButton(
          email: email,
          password: password,
        ),
      ],
    );
  }
}
