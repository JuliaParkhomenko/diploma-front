// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:diploma_frontend/blocs/supplier/supplier_cubit.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:diploma_frontend/users/manager/pages/widgets/info_overlay.dart';
import 'package:diploma_frontend/utils/is_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class EditSupplierValidator {
  final BehaviorSubject<String> _name = BehaviorSubject<String>.seeded('');
  final BehaviorSubject<String> _address = BehaviorSubject<String>.seeded('');
  final BehaviorSubject<String> _email = BehaviorSubject<String>.seeded('@');
  final BehaviorSubject<String> _phoneNumber =
      BehaviorSubject<String>.seeded('');

  Stream<String> get name => _name.transform(_validateName);
  Stream<String> get address => _address.transform(_validateName);
  Stream<String> get email => _email.transform(_validateEmail);
  Stream<String> get phoneNumber => _phoneNumber.transform(_validateName);

  Sink<String> get nameSink => _name.sink;
  Sink<String> get addressSink => _address.sink;
  Sink<String> get emailSink => _email.sink;
  Sink<String> get phoneNumberSink => _phoneNumber.sink;

  Stream<bool> get validData => Rx.combineLatest4(
        name,
        address,
        email,
        phoneNumber,
        (a, b, c, d) => true,
      );

  final _validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (value.length != 1) {
        isEmail(value)
            ? sink.add(value)
            : sink.addError('Please enter valid email');
      }
    },
  );

  final _validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (value.isNotEmpty) {
        if (value.length < 2 || value.length > 20) {
          sink.addError('Validation error');
        } else {
          sink.add(value);
        }
      }
    },
  );

  Future<void> editSupplier({
    required int id,
    required BuildContext context,
  }) async {
    await ServiceLocator.supplierRepository.edit(
      id: id,
      name: await _name.first,
      address: await _address.first,
      email: await _email.first,
      phoneNum: await _phoneNumber.first,
    );
    showInfoPrikol('Successfully edited'.tr(context), context);
    final SupplierCubit cubit = BlocProvider.of(context);
    await cubit.fetchSuppliers('');
  }
}
