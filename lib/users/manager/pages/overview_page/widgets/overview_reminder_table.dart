import 'package:diploma_frontend/models/expiring_batch.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/utils/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class OverviewReminderTable extends StatelessWidget {
  final List<ExpiringBatch> expiringBatches;
  const OverviewReminderTable({
    super.key,
    required this.expiringBatches,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      //Yuliia: it used to be receivedHistoryWidget
      children: [
        Container(
          width: size.width * .62,
          color: constants.Colors.greyTable,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getTitle(size, 'Product'.tr(context), bold: true),
              getTitle(size, 'Use in days'.tr(context), bold: true),
              getTitle(size, 'Expiration date'.tr(context), bold: true),
            ],
          ),
        ),
        SizedBox(
          height: 170, //(size.height - 132) * .4,
          child: ListView.builder(
            itemCount: expiringBatches.length,
            itemBuilder: (context, index) {
              final ExpiringBatch expiringBatch = expiringBatches[index];

              return Container(
                width: size.width * .62,
                color:
                    index % 2 == 0 ? Colors.white : constants.Colors.greyTable,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTitle(size, expiringBatch.productName),
                    getTitle(
                      size,
                      expiringBatch.expirationDate.differenceInDays(),
                    ),
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
      height: 56,
      width: size.width * .21 / 3,
      child: Align(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'OpenSans',
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
