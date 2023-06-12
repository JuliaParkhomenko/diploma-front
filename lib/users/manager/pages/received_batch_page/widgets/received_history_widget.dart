import 'package:diploma_frontend/models/batch_audit.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';

class ReceivedHistoryWidget extends StatelessWidget {
  final List<BatchAudit> batches;
  const ReceivedHistoryWidget({super.key, required this.batches});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width * .72,
          color: constants.Colors.greyTable,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getTitle(size, 'Event'.tr(context), bold: true),
              getTitle(size, 'Amount'.tr(context), bold: true),
              getTitle(size, 'Remaining'.tr(context), bold: true),
              getTitle(size, 'Date'.tr(context), bold: true),
            ],
          ),
        ),
        SizedBox(
          height: 180, //(size.height - 132) * .4,
          child: ListView.builder(
            itemCount: batches.length,
            itemBuilder: (context, index) {
              final BatchAudit audit = batches[index];

              return Container(
                width: size.width * .72,
                color:
                    index % 2 == 0 ? Colors.white : constants.Colors.greyTable,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTitle(size, audit.reason),
                    getTitle(size, audit.amount.toString()),
                    getTitle(size, audit.remaining.toString()),
                    getTitle(size, audit.date.toString().split('.')[0]),
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
      width: size.width * .4 / 4,
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
