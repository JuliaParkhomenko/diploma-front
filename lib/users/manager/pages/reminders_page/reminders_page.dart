import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/manager/pages/reminders_page/widgets/expired_batches_widget.dart';
import 'package:diploma_frontend/users/manager/pages/reminders_page/widgets/expiring_batches_widget.dart';
import 'package:flutter/material.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          children: [
            SizedBox(
              height: 32,
              child: TabBar(
                overlayColor: const MaterialStatePropertyAll(Colors.black),
                tabs: [
                  Tab(
                    text: 'Expiration date is coming up'.tr(context),
                  ),
                  Tab(
                    text: 'Expiration date has passed'.tr(context),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  ExpiringBatchesWidget(),
                  ExpiredBatchesWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
