import 'package:diploma_frontend/enums/logged_in_state.dart';
import 'package:diploma_frontend/enums/role.dart';
import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';

class AppStateService with ChangeNotifier {
  final Database _database;
  AppStateService(this._database);

  LoggedInState _loggedInState = LoggedInState.loading;
  LoggedInState get loggedInState => _loggedInState;

  Future<void> logIn() async {
    _loggedInState = LoggedInState.loading;
    notifyListeners();

    try {
      final User? user = await _database.getUser();

      await Future.delayed(const Duration(milliseconds: 1500));

      if (user == null) {
        _loggedInState = LoggedInState.loggedOut;
        notifyListeners();
        return;
      }

      if (user.role == Role.director) {
        _loggedInState = LoggedInState.director;
        notifyListeners();
        return;
      }

      if (user.role == Role.admin) {
        _loggedInState = LoggedInState.admin;
        notifyListeners();
        return;
      }

      if (user.role == Role.manager) {
        _loggedInState = LoggedInState.manager;
        notifyListeners();
        return;
      }

      _loggedInState = LoggedInState.loggedOut;
      notifyListeners();
    } catch (error) {
      _loggedInState = LoggedInState.loggedOut;
      notifyListeners();
    }
  }

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    final User? user = await ServiceLocator.authRepository.signIn(
      email: email,
      password: password,
    );

    if (user == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect email or password'),
        ),
      );
    } else {
      await ServiceLocator.database.addUser(user);

      await logIn();
    }
  }
}
