import 'package:diploma_frontend/pages/ordered_batch_page/widgets/batch_view.dart';
import 'package:diploma_frontend/pages/ordered_batch_page/widgets/receive_batch_row.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:routemaster/routemaster.dart';
import 'package:translit/translit.dart';

class OrderedBatchPage extends StatelessWidget {
  final int batchId;
  const OrderedBatchPage({
    super.key,
    required this.batchId,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String productName =
        Routemaster.of(context).currentRoute.pathParameters['name'].toString();

    return Container(
      width: size.width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: constants.Colors.managerWarehouseMain.withOpacity(0.6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${'Stocks'.tr(context)} > ${'Stock'.tr(context)} (${Translit().unTranslit(source: productName)}) > ${'Batch'.tr(context)} №$batchId',
              style: const TextStyle(
                color: constants.Colors.subtitleTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            const SizedBox(height: 32),
            const BatchView(),
            const SizedBox(height: 64),
            Text(
              //TODO add receiving a batch to lang files
              'Receiving a batch'.tr(context),
              style: const TextStyle(
                color: constants.Colors.subtitleTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            const SizedBox(height: 32),
            const ReceiveBatchRow(),
          ],
        ),
      ),
    );
  }
}
