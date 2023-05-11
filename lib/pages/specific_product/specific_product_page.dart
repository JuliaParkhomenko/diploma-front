import 'package:diploma_frontend/pages/specific_product/widgets/specific_product_table.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class SpecificProductPage extends StatelessWidget {
  final int stockId;
  final String productName;
  const SpecificProductPage({
    super.key,
    required this.productName,
    required this.stockId,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: constants.Colors.managerWarehouseMain.withOpacity(0.6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${'Stocks'.tr(context)} > ${'Stock'.tr(context)} ($productName)',
              style: const TextStyle(
                color: constants.Colors.subtitleTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            SpecificProductTable(
              stockId: stockId,
            ),
          ],
        ),
      ),
    );
  }
}
