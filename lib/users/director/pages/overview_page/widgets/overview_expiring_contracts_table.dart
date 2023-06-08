import 'package:diploma_frontend/models/expiring_contracts.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class OverviewExpiringContractsTable extends StatelessWidget {
  final List<ExpiringContract> expiringContracts;
  const OverviewExpiringContractsTable({
    super.key,
    required this.expiringContracts,
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
              getTitle(size, 'Contract number'.tr(context), bold: true),
              getTitle(size, 'Supplier'.tr(context), bold: true),
              getTitle(size, 'Expiration date'.tr(context), bold: true),
            ],
          ),
        ),
        SizedBox(
          height: 400, //(size.height - 132) * .4,
          child: ListView.builder(
            itemCount: expiringContracts.length,
            itemBuilder: (context, index) {
              final ExpiringContract expiringContract =
                  expiringContracts[index];

              return Container(
                width: size.width * .61,
                color:
                    index % 2 == 0 ? Colors.white : constants.Colors.greyTable,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTitle(size, expiringContract.id.toString()),
                    getTitle(
                      size,
                      expiringContract.supplierName,
                    ),
                    getTitle(size,
                        expiringContract.endDate.toString().substring(0, 10)),
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
