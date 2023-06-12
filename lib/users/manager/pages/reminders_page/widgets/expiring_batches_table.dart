import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:diploma_frontend/models/expiring_batch.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';

class ExpiringBatchesTable extends StatelessWidget {
  final List<ExpiringBatch> expiringBatches;
  const ExpiringBatchesTable({super.key, required this.expiringBatches});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width,
          color: constants.Colors.greyTable,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getTitle(size, 'Batch'.tr(context), bold: true),
              getTitle(size, 'Product'.tr(context), bold: true),
              getTitle(size, 'Amount'.tr(context), bold: true),
              getTitle(size, 'Use in days'.tr(context), bold: true),
              getTitle(size, 'Expiration date'.tr(context), bold: true),
            ],
          ),
        ),
        SizedBox(
          height: size.height * .72, //(size.height - 132) * .4,
          child: ListView.builder(
            itemCount: expiringBatches.length,
            itemBuilder: (context, index) {
              final ExpiringBatch expiringBatch = expiringBatches[index];

              return Container(
                width: size.width * .72,
                color:
                    index % 2 == 0 ? Colors.white : constants.Colors.greyTable,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTitle(size, expiringBatch.batchId.toString()),
                    getTitle(size, expiringBatch.productName),
                    getTitle(size, expiringBatch.amount.toString()),
                    getTitle(
                        size,
                        (expiringBatch.expirationDate
                                .difference(DateTime.now())
                                .inDays)
                            .toString()
                            .split('.')[0]),
                    getTitle(
                        size,
                        expiringBatch.expirationDate
                            .toString()
                            .substring(0, 10)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget getTitle(Size size, String title, {bool bold = false}) {
    return SizedBox(
      height: 60,
      width: size.width * .5 / 5,
      child: Align(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'OpenSans',
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
