import 'package:diploma_frontend/pages/application_page/application_page.dart';
import 'package:diploma_frontend/pages/batches_page/batches_page.dart';
import 'package:diploma_frontend/pages/overview_page/overview_page.dart';
import 'package:diploma_frontend/pages/reminders_page/reminders_page.dart';
import 'package:diploma_frontend/pages/statistics_page/statistics_page.dart';
import 'package:diploma_frontend/pages/stocks_page/stocks_page.dart';
import 'package:flutter/material.dart';

class DestinationPage extends StatelessWidget {
  final int warehouseId;
  final int index;

  const DestinationPage({
    super.key,
    required this.warehouseId,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final List<Widget> result = [
      const OverviewPage(),
      const StocksPage(
          // update: context.locale == ServiceLocator.languageService.fallbackLocale,
          // warehouseId: warehouseId,
          ),
      const BatchesPage(),
      const RemindersPage(),
      const StatisticsPage(),
      const ApplicationPage(),
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 20),
      child: SizedBox(
        height: size.height - 70,
        child: result[index],
      ),
    );
  }
}
