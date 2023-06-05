import 'dart:async';

import 'package:diploma_frontend/utils/is_email.dart';
import 'package:rxdart/rxdart.dart';

class SignInValidator {
  final BehaviorSubject<String> _email = BehaviorSubject<String>.seeded('@');
  final BehaviorSubject<String> _password = BehaviorSubject<String>.seeded('');

  Stream<String> get email => _email.stream.transform(_validateEmail);
  Sink<String> get sinkEmail => _email.sink;

  Stream<String> get password => _password.stream.transform(_validatePassword);
  Sink<String> get sinkPassword => _password.sink;

  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, m) => true);

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
