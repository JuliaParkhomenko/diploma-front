import 'package:diploma_frontend/enums/role.dart';
import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/repositories/auth_repository/auth_repository.dart';
import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:diploma_frontend/services/database/database.dart';
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
            style: TextStyle(
              color: constants.Colors.main,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 100,
        ),
        SizedBox(
          width: size.width * .3,
          child: TextField(
            controller: email,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: 'Email', // Placeholder text
              border: OutlineInputBorder(), // Border style
              filled: true, // Background color
              fillColor: Colors.grey[200], // Background color
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: size.width * .3,
          child: TextField(
            controller: password,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              hintText: 'Password', // Placeholder text
              border: OutlineInputBorder(), // Border style
              filled: true, // Background color
              fillColor: Colors.grey[200], // Background color
            ),
            obscureText: true,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Forgot you password?',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(
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
              Size(188, 42),
            ),
            backgroundColor: MaterialStateProperty.all(constants.Colors.main),
          ),
          child: Text(
            'Sign in'.tr().toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Future<void> signIn() async {
    final AuthRepository authRepository = AuthRepository();
    final User? user = await authRepository.signIn(
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
      final Database db = Database();
      await db.addUser(user);
      final AppStateService appStateService = AppStateService();
      print("My error");
      //await appStateService.logIn();
      await Provider.of<AppStateService>(context, listen: false).logIn();
    }
  }
}
