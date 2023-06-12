// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SignInValidator {
  final BehaviorSubject<String> _email = BehaviorSubject<String>.seeded('@');
  final BehaviorSubject<String> _password = BehaviorSubject<String>.seeded('');

  Stream<String> get email => _email.stream;
  Sink<String> get sinkEmail => _email.sink;

  Stream<String> get password => _password.stream;
  Sink<String> get sinkPassword => _password.sink;

  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, m) => true).asBroadcastStream();

  final StreamController<bool> _tapStreamController = StreamController<bool>()
    ..add(false);
  Stream<bool> get buttonAvailable => _tapStreamController.stream;

  Future<void> signIn(BuildContext context) async {
    if (await submitValid.first) {
      _tapStreamController.add(true);
      final AppStateService service =
          Provider.of<AppStateService>(context, listen: false);
      await service.signIn(
        context,
        await email.first,
        await password.first,
      );
      _tapStreamController.add(false);
    }
  }

  void dispose() {
    _email.close();
    _password.close();
    _tapStreamController.close();
  }
}
