import 'package:diploma_frontend/blocs/expiring_batches/expiring_batches_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/manager/pages/overview_page/widgets/overview_reminder_table.dart';
import 'package:diploma_frontend/manager/pages/overview_page/widgets/reminder_view_more_button.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class OverviewReminder extends StatefulWidget {
  const OverviewReminder({
    super.key,
  });

  @override
  State<OverviewReminder> createState() => _OverviewReminderState();
}

class _OverviewReminderState extends State<OverviewReminder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            constants.Colors.overviewReminderColor.withOpacity(0.2),
            constants.Colors.overviewReminderColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(31),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reminder'.tr(context),
                  style: const TextStyle(
                    color: constants.Colors.subtitleTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                const Align(
                  alignment: Alignment.topRight,
                  child: ReminderViewMoreButton(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<ExpiringBatchesCubit, ExpiringBatchesState>(
              builder: (context, state) {
                if (state is ExpiringBatchesInitial) {
                  final ExpiringBatchesCubit cubit =
                      BlocProvider.of<ExpiringBatchesCubit>(context);
                  cubit.fetchExpiringBatches(
                      BlocProvider.of<WarehouseCubit>(context)
                          .selectedWarehouseIndex,
                      0);
                }

                if (state is ExpiringBatchesLoading) {
                  return const OverviewReminderTable(
                    expiringBatches: [],
                  );
                }

                if (state is ExpiringBatchesError) {
                  return const Text('Error on server :)');
                }

                if (state is ExpiringBatchesLoaded) {
                  return OverviewReminderTable(
                    expiringBatches: state.expiringBatches,
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
