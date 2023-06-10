import 'package:diploma_frontend/models/ordered_batch.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class OverviewOrderedBatchesTable extends StatelessWidget {
  final List<OrderedBatch> orderedBatches;
  const OverviewOrderedBatchesTable({
    super.key,
    required this.orderedBatches,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      //Yuliia: it used to be receivedHistoryWidget
      children: [
        Container(
          width: size.width * .61,
          color: constants.Colors.greyTable,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getTitle(size, 'Batch'.tr(context), bold: true),
              getTitle(size, 'Product'.tr(context), bold: true),
              getTitle(size, 'Order date'.tr(context), bold: true),
            ],
          ),
        ),
        SizedBox(
          height: 110, //(size.height - 132) * .4,
          child: ListView.builder(
            itemCount: orderedBatches.length,
            itemBuilder: (context, index) {
              final OrderedBatch orderedBatch = orderedBatches[index];

              return Container(
                width: size.width * .61,
                color:
                    index % 2 == 0 ? Colors.white : constants.Colors.greyTable,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTitle(size, '№${orderedBatch.batchId}'),
                    getTitle(
                      size,
                      orderedBatch.productName,
                    ),
                    getTitle(size,
                        orderedBatch.orderDate.toString().substring(0, 10)),
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
      width: size.width * .17 / 2,
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
