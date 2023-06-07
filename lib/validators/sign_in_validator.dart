// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:diploma_frontend/utils/is_email.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SignInValidator {
  final BehaviorSubject<String> _email = BehaviorSubject<String>.seeded('@');
  final BehaviorSubject<String> _password = BehaviorSubject<String>.seeded('');

  Stream<String> get email => _email.stream.transform(_validateEmail);
  Sink<String> get sinkEmail => _email.sink;

  Stream<String> get password => _password.stream.transform(_validatePassword);
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

  final _validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (value.length != 1) {
        isEmail(value)
            ? sink.add(value)
            : sink.addError('Please enter valid email');
      }
    },
  );

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (value.isNotEmpty) {
        if (value.length < 8 || value.length > 24) {
          sink.addError('Validation error');
        } else {
          sink.add(value);
        }
      }
    },
  );
}
