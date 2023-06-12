import 'package:diploma_frontend/blocs/expired_batches/expired_batches_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/manager/pages/reminders_page/widgets/expired_batches_table.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpiredBatchesWidget extends StatelessWidget {
  const ExpiredBatchesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expiration date has passed'.tr(context),
          style: const TextStyle(
            color: constants.Colors.subtitleTextColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        const SizedBox(height: 32),
        BlocBuilder<ExpiredBatchesCubit, ExpiredBatchesState>(
            builder: (context, state) {
          final WarehouseCubit warehouseCubit = BlocProvider.of(context);
          if (state is ExpiredBatchesInitial) {
            final ExpiredBatchesCubit cubit =
                BlocProvider.of<ExpiredBatchesCubit>(context);
            cubit.fetchExpiredBatches(warehouseCubit.selectedWarehouseIndex, 0);
          }
          if (state is ExpiredBatchesError) {
            return const Text('Error on server :)');
          }
          if (state is ExpiredBatchesLoaded) {
            return ExpiredBatchesTable(
              expiredBatches: state.expiredBatches,
            );
          }
          return Container();
        }),
      ],
    );
  }
}
