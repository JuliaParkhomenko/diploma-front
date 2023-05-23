import 'package:diploma_frontend/enums/urgency.dart';
import 'package:diploma_frontend/pages/widgets/info_overlay.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class SendButton extends StatelessWidget {
  final Function(bool) onTap;
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
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await ServiceLocator.warehouseRepository.addAplication(
          warehouseId: warehouseId,
          productId: productId,
          amount: amount,
          kind: kind,
          urgency: urgency,
          note: note,
          context: context,
        );
        onTap(true);
        showInfoPrikol('Application sent successfully'.tr(context), context);
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.green.withOpacity(0.7)),
        backgroundColor: MaterialStateProperty.all(constants.Colors.main),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(),
          ),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 160,
        child: Text(
          'Send'.tr(context),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
