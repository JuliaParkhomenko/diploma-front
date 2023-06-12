import 'package:diploma_frontend/blocs/users/users_cubit.dart';
import 'package:diploma_frontend/enums/role.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/admin/pages/users_page/widgets/add_user_dialog.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
import 'package:diploma_frontend/widgets/default_table/default_custom_table.dart';
import 'package:diploma_frontend/widgets/default_table/default_table_header.dart';
import 'package:diploma_frontend/widgets/default_table/default_table_item.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    const DefaultTableHeader header = DefaultTableHeader(
      headers: [
        'Id',
        'Full name',
        'Email',
        'Role',
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Users'.tr(context),
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              DefaultAddButton(
                buttonText: 'Add user',
                onTap: () async => _openAddDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 30),
          BlocBuilder<UsersCubit, UsersState>(
            builder: (context, state) {
              if (state is UsersInitial) {
                final UsersCubit cubit = BlocProvider.of(context);
                cubit.fetchUsers();
              }

              return state is UsersLoaded
                  ? DefaultCustomTable(
                      header: header,
                      items: List<DefaultTableItem>.generate(
                        state.users.length,
                        (index) => DefaultTableItem(
                          onTap: () {},
                          items: [
                            state.users[index].id.toString(),
                            state.users[index].fullName.toString(),
                            state.users[index].email.toString(),
                            state.users[index].role.getName(),
                          ],
                        ),
                      ),
                    )
                  : header;
            },
          ),
        ],
      ),
    );
  }

  Future<void> _openAddDialog(BuildContext context) async {
    await showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return const AddUserDialog();
      },
    );
  }
}
