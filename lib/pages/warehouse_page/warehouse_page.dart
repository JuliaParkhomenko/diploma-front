import 'package:diploma_frontend/pages/warehouse_page/widgets/search_textfield.dart';
import 'package:diploma_frontend/pages/warehouse_page/widgets/stocks_table.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class WarehousePage extends StatefulWidget {
  const WarehousePage({super.key});

  @override
  State<WarehousePage> createState() => _WarehousePageState();
}

class _WarehousePageState extends State<WarehousePage> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.all(15),
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
              '${'Warehouse'.tr()} > ${'Stocks'.tr()}',
              style: TextStyle(
                color: constants.Colors.subtitleTextColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            SizedBox(
              height: 45,
            ),
            SizedBox(
              width: 200,
              height: 32,
              child: SearchTextfield(
                controller: searchController,
              ),
            ),
            Flexible(child: StocksTable()),
          ],
        ),
      ),
    );
  }
}
