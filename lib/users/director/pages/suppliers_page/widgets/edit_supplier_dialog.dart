import 'package:diploma_frontend/models/supplier.dart';
import 'package:diploma_frontend/users/director/pages/suppliers_page/widgets/dialog_textfield.dart';
import 'package:diploma_frontend/users/director/pages/suppliers_page/widgets/edit_button.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/validators/edit_supplier_validator.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:get_it/get_it.dart';

class EditSupplierDialog extends StatelessWidget {
  final Supplier supplier;

  const EditSupplierDialog({
    super.key,
    required this.supplier,
  });

  @override
  Widget build(BuildContext context) {
    final EditSupplierValidator validator =
        GetIt.instance<EditSupplierValidator>();
    validator.emailSink.add(supplier.email);
    validator.nameSink.add(supplier.name);
    validator.phoneNumberSink.add(supplier.phoneNum);
    validator.addressSink.add(supplier.address);

    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.55,
      height: size.height * 0.6,
      decoration: BoxDecoration(
        color: constants.Colors.mainButton,
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit supplier'.tr(context),
              style: const TextStyle(
                color: constants.Colors.subtitleTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            SizedBox(
              width: 850,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 340,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name'.tr(context),
                          style: const TextStyle(
                            color: constants.Colors.subtitleTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: StreamBuilder(
                            stream: validator.name,
                            builder: (_, snapshot) {
                              return DialogTextfield(
                                valid: snapshot.error == null,
                                initialValue: supplier.name,
                                hintText: 'Name',
                                onChanged: (value) =>
                                    validator.nameSink.add(value),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 340,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Address'.tr(context),
                          style: const TextStyle(
                            color: constants.Colors.subtitleTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: StreamBuilder(
                            stream: validator.address,
                            builder: (_, snapshot) {
                              return DialogTextfield(
                                valid: snapshot.error == null,
                                hintText: 'Address',
                                initialValue: supplier.address,
                                onChanged: (value) =>
                                    validator.addressSink.add(value),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              width: 850,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 340,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email'.tr(context),
                          style: const TextStyle(
                            color: constants.Colors.subtitleTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: StreamBuilder(
                            stream: validator.email,
                            builder: (_, snapshot) {
                              return DialogTextfield(
                                valid: snapshot.error == null,
                                hintText: 'Email'.tr(context),
                                initialValue: supplier.email,
                                onChanged: (value) =>
                                    validator.emailSink.add(value),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 340,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone number'.tr(context),
                          style: const TextStyle(
                            color: constants.Colors.subtitleTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: StreamBuilder(
                            stream: validator.phoneNumber,
                            builder: (_, snapshot) {
                              return DialogTextfield(
                                valid: snapshot.error == null,
                                hintText: 'Phone number'.tr(context),
                                initialValue: supplier.phoneNum,
                                onChanged: (value) =>
                                    validator.phoneNumberSink.add(value),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              width: 1000,
              child: Align(
                alignment: Alignment.centerRight,
                child: StreamBuilder(
                  stream: validator.validData,
                  builder: (_, snapshot) {
                    return EditButton(
                      valid: snapshot.error == null,
                      onTap: () async {
                        if (snapshot.error != null) {
                          return;
                        }

                        await validator
                            .editSupplier(id: supplier.id, context: context)
                            .then((_) {
                          Navigator.pop(context);
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
