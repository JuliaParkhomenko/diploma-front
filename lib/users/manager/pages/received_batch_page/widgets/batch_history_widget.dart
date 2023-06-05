import 'package:diploma_frontend/models/batch.dart';
import 'package:diploma_frontend/users/manager/pages/received_batch_page/widgets/received_history_widget.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class BatchHistoryWidget extends StatelessWidget {
  final Batch batch;
  const BatchHistoryWidget({
    super.key,
    required this.batch,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8),
      child: Container(
        width: size.width * .6,
        height: size.height * .522,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: constants.Colors.managerWarehouseMain.withOpacity(0.6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'History'.tr(context),
              style: const TextStyle(
                color: constants.Colors.subtitleTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            const SizedBox(height: 32),
            ReceivedHistoryWidget(
              batches: batch.batchAudit ?? [],
            ),
          ],
        ),
      ),
    );
  }
}
