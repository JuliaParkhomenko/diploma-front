// ignore_for_file: use_build_context_synchronously

import 'package:diploma_frontend/blocs/batch/batch_cubit.dart';
import 'package:diploma_frontend/blocs/ordered_batches/ordered_batches_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/pages/widgets/info_overlay.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class ReceiveBatchButton extends StatelessWidget {
  final int batchId;
  final DateTime productionDate;
  final DateTime expirationDate;
  final int notificationDate;

  const ReceiveBatchButton({
    super.key,
    required this.batchId,
    required this.expirationDate,
    required this.notificationDate,
    required this.productionDate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await ServiceLocator.batchRepository.receiveBatch(
          batchId: batchId,
          productionTime: productionDate,
          expirationTime: expirationDate,
          notificationDate: notificationDate,
        );

        if (Routemaster.of(context).currentRoute.fullPath == '/batches') {
          final OrderedBatchesCubit orderedBatchCubit =
              BlocProvider.of(context);
          orderedBatchCubit.clear();
          final WarehouseCubit warehouseCubit = BlocProvider.of(context);
          await orderedBatchCubit
              .fetchBatches(warehouseCubit.selectedWarehouseIndex);
          showInfoPrikol(
              'Batch №{BATCH_ID} has successfully received!'
                  .tr(context)
                  .replaceAll('{BATCH_ID}', batchId.toString()),
              context);
        } else {
          final BatchCubit cubit = BlocProvider.of(context);
          cubit.clear();
          Routemaster.of(context).replace(
              '/stocks/product/${Routemaster.of(context).currentRoute.pathParameters['name']}/received/$batchId');
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 160,
        decoration: BoxDecoration(
          color: constants.Colors.main,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        //TODO add style (what I should change)
        child: Text(
          'Receive batch'.tr(context),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
