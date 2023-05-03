import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:provider/provider.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({super.key});

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  final TextEditingController email =
      TextEditingController(text: 'yuliia.parkhomenko@nure.ua');
  final TextEditingController password =
      TextEditingController(text: 'Yul1234567!');
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
            'Sign in to your account'.tr(),
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
          'Forgot your password?'.tr(),
          style: const TextStyle(
            decoration: TextDecoration.underline,
            fontFamily: 'OpenSans',
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextButton(
          onPressed: () async {
            await signIn();
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
            'Sign in'.tr().toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> signIn() async {
    final User? user = await ServiceLocator.authRepository.signIn(
      email: email.text,
      password: password.text,
    );
    if (!mounted) {
      return;
    }
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect email or password'),
        ),
      );
    } else {
      await ServiceLocator.database.addUser(user);
      // ignore: use_build_context_synchronously
      await Provider.of<AppStateService>(context, listen: false).logIn();
    }
  }
}
