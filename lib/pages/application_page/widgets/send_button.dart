import 'package:diploma_frontend/enums/urgency.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class SendButton extends StatelessWidget {
  final int warehouseId;
  final int productId;
  final int amount;
  final String kind;
  final Urgency urgency;
  final String note;
  const SendButton({
    super.key,
    required this.warehouseId,
    required this.productId,
    required this.amount,
    required this.kind,
    required this.urgency,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await ServiceLocator.warehouseRepository.addAplication(
          warehouseId: warehouseId,
          productId: productId,
          amount: amount,
          kind: kind,
          urgency: urgency,
          note: note,
          context: context,
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 160,
        decoration: BoxDecoration(
          color: constants.Colors.main,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        //TODO add style
        child: Text(
          'Send'.tr(context),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
