import 'package:diploma_frontend/enums/logged_in_state.dart';
import 'package:diploma_frontend/enums/role.dart';
import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:flutter/material.dart';

class AppStateService with ChangeNotifier {
  LoggedInState _loggedInState = LoggedInState.loading;
  LoggedInState get loggedInState => _loggedInState;

  Future<void> logIn() async {
    _loggedInState = LoggedInState.loading;
    notifyListeners();

    try {
      final Database db = Database();
      final User? user = await db.getUser();

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
}
