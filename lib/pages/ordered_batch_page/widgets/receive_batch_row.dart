import 'package:diploma_frontend/pages/ordered_batch_page/widgets/date_picker_textfield.dart';
import 'package:diploma_frontend/pages/ordered_batch_page/widgets/receive_batch_button.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ReceiveBatchRow extends StatefulWidget {
  const ReceiveBatchRow({super.key});

  @override
  State<ReceiveBatchRow> createState() => _ReceiveBatchRowState();
}

class _ReceiveBatchRowState extends State<ReceiveBatchRow> {
  final DateTime now = DateTime.now();
  late final TextEditingController productionDateController =
      TextEditingController(text: '${now.year}-${now.month}-${now.day}');
  late final TextEditingController expirationDateController =
      TextEditingController(text: '${now.year}-${now.month}-${now.day}');
  DateTime prodDate = DateTime.now();
  DateTime expDate = DateTime.now();

  late final TextEditingController reminders = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: size.width * .72,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO add to lang files, add style
                    Text(
                      'Production date'.tr(context),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      width: 200,
                      height: 32,
                      child: DatePickerTextField(
                        controller: productionDateController,
                        onDateTimeChanged: (value) {
                          //TODO
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO add style
                    Text(
                      'Expiration date'.tr(context),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 200,
                      height: 32,
                      child: DatePickerTextField(
                        controller: expirationDateController,
                        onDateTimeChanged: (value) {
                          //TODO
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO add to lang files, add style
                    Text(
                      'Expiration date reminder (days)'.tr(context),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 32,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        controller: reminders,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                            fontSize: 14,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.only(left: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 64),
            Align(
              alignment: Alignment.centerRight,
              child: ReceiveBatchButton(
                batchId: int.parse(
                    Routemaster.of(context).currentRoute.pathParameters['id']!),
                expirationDate: expDate,
                productionDate: prodDate,
                notificationDate: int.parse(reminders.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
