import 'package:diploma_frontend/users/manager/pages/ordered_batch_page/widgets/batch_view.dart';
import 'package:diploma_frontend/users/manager/pages/ordered_batch_page/widgets/receive_batch_row.dart';
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
    final String productName =
        Routemaster.of(context).currentRoute.pathParameters['name'].toString();

    return Padding(
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
            'Receiving a batch'.tr(context),
            // ignore: prefer_const_constructors
            style: TextStyle(
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
    );
  }
}
