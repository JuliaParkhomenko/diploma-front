import 'package:diploma_frontend/users/director/pages/suppliers_page/widgets/dialog_textfield.dart';
import 'package:diploma_frontend/users/director/pages/suppliers_page/widgets/edit_button.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class EditSupplierDialog extends StatefulWidget {
  final int supplierId;
  final String name;
  final String address;
  final String email;
  final String phoneNumber;
  const EditSupplierDialog({
    super.key,
    required this.supplierId,
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
  });

  @override
  State<EditSupplierDialog> createState() => _EditSupplierDialogState();
}

class _EditSupplierDialogState extends State<EditSupplierDialog> {
  late final TextEditingController nameController =
      TextEditingController(text: widget.name);
  late final TextEditingController addressController =
      TextEditingController(text: widget.address);
  late final TextEditingController emailController =
      TextEditingController(text: widget.email);
  late final TextEditingController phoneController =
      TextEditingController(text: widget.phoneNumber);
  late String name = widget.name;
  late String address = widget.address;
  late String email = widget.email;
  late String phoneNumber = widget.phoneNumber;

  @override
  Widget build(BuildContext context) {
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
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            hintText: "Name",
                            controller: nameController,
                            onChanged: (_) {
                              setState(() {
                                name = _;
                              });
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
                          child: DialogTextfield(
                            hintText: "Address",
                            controller: addressController,
                            onChanged: (_) {
                              setState(() {
                                address = _;
                              });
                            },
                          ),
                        ),
                        // const SizedBox(
                        //   width: 20,
                        // ),

                        // const SizedBox(
                        //   width: 40,
                        // ),
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
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            hintText: 'Email'.tr(context),
                            controller: emailController,
                            onChanged: (_) {
                              setState(() {
                                email = _;
                              });
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
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            hintText: 'Phone number'.tr(context),
                            controller: phoneController,
                            onChanged: (_) {
                              setState(() {
                                phoneNumber = _;
                              });
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
                child: EditButton(
                  supplierId: widget.supplierId,
                  name: nameController.text,
                  address: addressController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  onTap: (_) {
                    setState(() {});
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
