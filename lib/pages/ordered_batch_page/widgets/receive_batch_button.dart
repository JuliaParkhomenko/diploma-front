// ignore_for_file: use_build_context_synchronously

import 'package:diploma_frontend/blocs/batch/batch_cubit.dart';
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

        final BatchCubit cubit = BlocProvider.of(context);
        cubit.clear();

        Routemaster.of(context).replace(
            '/stocks/product/${Routemaster.of(context).currentRoute.pathParameters['name']}/received/$batchId');
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
        //TODO add to lang, style
        child: const Text(
          'Receive batch',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
