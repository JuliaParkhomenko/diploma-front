import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/manager/pages/reminders_page/widgets/expired_batches_widget.dart';
import 'package:diploma_frontend/users/manager/pages/reminders_page/widgets/expiring_batches_widget.dart';
import 'package:flutter/material.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage>
    with SingleTickerProviderStateMixin {
  late final TabController controller = TabController(
    length: 2,
    vsync: this,
  )..addListener(() {
      setState(() {});
    });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          gradient: LinearGradient(
            colors: [
              controller.index == 0
                  ? Colors.orange.withOpacity(.2)
                  : Colors.red.withOpacity(.2),
              controller.index == 0
                  ? Colors.orangeAccent.withOpacity(.5)
                  : Colors.redAccent.withOpacity(.5),
            ],
          ),
        ),
        height: size.height - 105,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 32,
              child: TabBar(
                controller: controller,
                tabs: [
                  Tab(
                    child: Text(
                      'Expiration date is coming up'.tr(context),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Expiration date has passed'.tr(context),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 18),
                    child: ExpiringBatchesWidget(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 18),
                    child: ExpiredBatchesWidget(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
