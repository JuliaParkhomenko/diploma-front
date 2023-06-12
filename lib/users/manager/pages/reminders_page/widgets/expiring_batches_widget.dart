import 'package:diploma_frontend/blocs/expiring_batches/expiring_batches_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/manager/pages/reminders_page/widgets/expiring_batches_table.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpiringBatchesWidget extends StatelessWidget {
  const ExpiringBatchesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expiration date is coming up'.tr(context),
          style: const TextStyle(
            color: constants.Colors.subtitleTextColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        const SizedBox(height: 32),
        BlocBuilder<ExpiringBatchesCubit, ExpiringBatchesState>(
            builder: (context, state) {
          final WarehouseCubit warehouseCubit = BlocProvider.of(context);
          if (state is ExpiringBatchesInitial) {
            final ExpiringBatchesCubit cubit =
                BlocProvider.of<ExpiringBatchesCubit>(context);
            cubit.fetchExpiringBatches(
                warehouseCubit.selectedWarehouseIndex, 0);
          }
          if (state is ExpiringBatchesError) {
            return const Text('Error on server :)');
          }
          if (state is ExpiringBatchesLoaded) {
            return ExpiringBatchesTable(
              expiringBatches: state.expiringBatches,
            );
          }
          return Container();
        }),
      ],
    );
  }
}
