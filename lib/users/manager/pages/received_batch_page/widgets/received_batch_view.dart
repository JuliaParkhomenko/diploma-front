import 'package:diploma_frontend/models/batch.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class ReceivedBatchView extends StatelessWidget {
  final Batch batch;
  const ReceivedBatchView({super.key, required this.batch});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(children: [
      Container(
        width: size.width * .72,
        color: constants.Colors.greyTable,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getTitle(size, 'Kind'.tr(context), bold: true),
            getTitle(size, 'Maker'.tr(context), bold: true),
            getTitle(size, 'Status'.tr(context), bold: true),
            getTitle(size, 'Amount'.tr(context), bold: true),
            getTitle(size, 'Production date'.tr(context), bold: true),
            getTitle(size, 'Expiration date'.tr(context), bold: true),
          ],
        ),
      ),
      Container(
        width: size.width * .72,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getTitle(size, batch.kind),
            getTitle(size, batch.maker),
            getTitle(size, batch.status.name),
            getTitle(size, batch.amount.toString()),
            getTitle(size, batch.productionDate.toString().substring(0, 10)),
            getTitle(size, batch.expirationDate.toString().substring(0, 10)),
          ],
        ),
      ),
    ]);
  }

  Widget getTitle(Size size, String title, {bool bold = false}) {
    return SizedBox(
      height: 60,
      width: size.width * .72 / 6,
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
