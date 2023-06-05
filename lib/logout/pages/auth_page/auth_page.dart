import 'package:diploma_frontend/logout/pages/auth_page/widgets/sign_in_button.dart';
import 'package:diploma_frontend/logout/pages/auth_page/widgets/sign_in_text_field.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/validators/sign_in_validator.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:get_it/get_it.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInValidator validator = GetIt.instance<SignInValidator>();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
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
          StreamBuilder(
            stream: validator.email,
            builder: (_, snapshot) {
              return SizedBox(
                width: size.width * .3,
                child: SignInTextField(
                  hintText: 'Email',
                  onChanged: (value) => validator.sinkEmail.add(value),
                  valid: snapshot.error == null,
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: validator.password,
            builder: (_, snapshot) {
              return SizedBox(
                width: size.width * .3,
                child: SignInTextField(
                  hintText: 'Password',
                  onChanged: (value) => validator.sinkPassword.add(value),
                  valid: snapshot.error == null,
                  obscureText: true,
                ),
              );
            },
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
          StreamBuilder(
            stream: validator.submitValid,
            builder: (_, snapshot) {
              return StreamBuilder(
                stream: validator.buttonAvailable,
                builder: (_, AsyncSnapshot<bool> available) {
                  return SignInButton(
                    onPressed: () async {
                      await validator.signIn(context);
                    },
                    valid: snapshot.error == null,
                    tapped: available.data ?? false,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
