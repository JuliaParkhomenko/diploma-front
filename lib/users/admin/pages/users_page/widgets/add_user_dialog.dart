import 'package:diploma_frontend/blocs/users/users_cubit.dart';
import 'package:diploma_frontend/enums/role.dart';
import 'package:diploma_frontend/models/admin_user.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/admin/pages/users_page/widgets/role_dropdown.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract_page/widgets/dialog_textfield.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserDialog extends StatefulWidget {
  final String fullName;
  final Role role;
  final String email;
  final String password;
  final bool edit;
  final int id;
  const AddUserDialog({
    super.key,
    this.id = 0,
    required this.edit,
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.role = Role.admin,
  });

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  late String fullName = widget.fullName;
  late Role role = widget.role;
  late String email = widget.email;
  late String password = widget.password;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: constants.Colors.mainButton,
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        width: size.width * 0.55,
        height: size.height * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Adding new user'.tr(context),
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text('Full name'.tr(context))),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            initialValue: fullName,
                            hintText: 'Full name',
                            onChanged: (value) => fullName = value,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Role'.tr(context)),
                        const SizedBox(width: 15),
                        RoleDropDown(
                          initialRole: role,
                          onChange: (value) => role = value,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //
              const SizedBox(height: 50),
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Email'.tr(context)),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            initialValue: email,
                            hintText: 'Email',
                            onChanged: (value) => email = value,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Password'.tr(context)),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            initialValue: password,
                            hintText: 'Password',
                            onChanged: (value) => password = value,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Align(
                alignment: Alignment.centerRight,
                child: DefaultAddButton(
                  buttonText: widget.edit ? 'Edit' : 'Add new',
                  onTap: () async {
                    if (!widget.edit) {
                      final AdminUser user = AdminUser(
                        id: 0,
                        fullName: fullName,
                        email: email,
                        role: role,
                      );
                      final UsersCubit cubit = BlocProvider.of(context);
                      await cubit
                          .addUser(user: user, password: password)
                          .then((value) {
                        Navigator.pop(context);
                      });
                    } else {}
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
