// ignore_for_file: use_decorated_box

import 'package:diploma_frontend/blocs/user_action/user_action_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/director/pages/overview_page/widgets/overview_recent_actions_table.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class OverviewRecentActions extends StatelessWidget {
  const OverviewRecentActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            constants.Colors.overviewRecentActionsColor.withOpacity(0.2),
            constants.Colors.overviewRecentActionsColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 31,
          right: 31,
          bottom: 20,
          top: 31,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent actions'.tr(context),
              style: const TextStyle(
                color: constants.Colors.subtitleTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            const SizedBox(height: 32),
            BlocBuilder<UserActionCubit, UserActionState>(
              builder: (context, state) {
                if (state is UserActionInitial) {
                  final UserActionCubit cubit =
                      BlocProvider.of<UserActionCubit>(context);
                  cubit.fetchUserActions(
                    BlocProvider.of<WarehouseCubit>(context)
                        .selectedWarehouseIndex,
                  );
                }

                if (state is UserActionLoading) {
                  return const OverviewRecentActionsTable(
                    actions: [],
                  );
                }

                if (state is UserActionError) {
                  return const Text('Error on server :)');
                }

                if (state is UserActionLoaded) {
                  return OverviewRecentActionsTable(
                    actions: state.userActions,
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
