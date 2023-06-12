// ignore_for_file: use_build_context_synchronously

import 'package:diploma_frontend/blocs/batch/batch_cubit.dart';
import 'package:diploma_frontend/blocs/ordered_batches/ordered_batches_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:diploma_frontend/users/manager/pages/ordered_batch_page/widgets/date_picker_textfield.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:diploma_frontend/users/manager/pages/widgets/info_overlay.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class ReceiveBatchRow extends StatefulWidget {
  final int? batchId;
  const ReceiveBatchRow({super.key, this.batchId});

  @override
  State<ReceiveBatchRow> createState() => _ReceiveBatchRowState();
}

class _ReceiveBatchRowState extends State<ReceiveBatchRow> {
  final DateTime now = DateTime.now();
  late final TextEditingController productionDateController =
      TextEditingController(text: '${now.year}-${now.month}-${now.day}');
  late final TextEditingController expirationDateController =
      TextEditingController(text: '${now.year}-${now.month}-${now.day}');
  DateTime prodDate = DateTime.now();
  DateTime expDate = DateTime.now();

  late final TextEditingController reminders = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: size.width * .72,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Production date'.tr(context),
                      style: const TextStyle(
                        color: constants.Colors.label,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      width: 200,
                      height: 32,
                      child: DatePickerTextField(
                        controller: productionDateController,
                        onDateTimeChanged: (value) {
                          prodDate = value;
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiration date'.tr(context),
                      style: const TextStyle(
                        color: constants.Colors.label,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 200,
                      height: 32,
                      child: DatePickerTextField(
                        controller: expirationDateController,
                        onDateTimeChanged: (value) {
                          expDate = value;
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiration date reminder (days)'.tr(context),
                      style: const TextStyle(
                        color: constants.Colors.label,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 32,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        controller: reminders,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                            fontSize: 14,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.only(left: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 64),
            Align(
              alignment: Alignment.centerRight,
              child: DefaultAddButton(
                buttonText: 'Receive batch',
                onTap: () async {
                  final int batchId = widget.batchId ??
                      int.parse(
                        Routemaster.of(context)
                            .currentRoute
                            .pathParameters['id']!,
                      );
                  await ServiceLocator.batchRepository.receiveBatch(
                    batchId: batchId,
                    productionTime: prodDate,
                    expirationTime: expDate,
                    notificationDate: int.parse(reminders.text),
                  );

                  if (Routemaster.of(context).currentRoute.fullPath ==
                      '/batches') {
                    final OrderedBatchesCubit orderedBatchCubit =
                        BlocProvider.of(context);
                    orderedBatchCubit.clear();
                    final WarehouseCubit warehouseCubit =
                        BlocProvider.of(context);
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
