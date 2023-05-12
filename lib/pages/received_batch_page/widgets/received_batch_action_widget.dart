import 'package:diploma_frontend/blocs/batch/batch_cubit.dart';
import 'package:diploma_frontend/models/batch.dart';
import 'package:diploma_frontend/pages/received_batch_page/widgets/use_batch_button.dart';
import 'package:diploma_frontend/pages/received_batch_page/widgets/write_off_all_button.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceivedBatchActionWidget extends StatefulWidget {
  final Batch batch;
  const ReceivedBatchActionWidget({super.key, required this.batch});

  @override
  State<ReceivedBatchActionWidget> createState() =>
      _ReceivedBatchActionWidgetState();
}

class _ReceivedBatchActionWidgetState extends State<ReceivedBatchActionWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: size.width * .3 - 15, //TODO change -15 if overflowed
        height: size.height * .6,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: constants.Colors.managerWarehouseMain.withOpacity(0.6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Actions'.tr(context),
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Use'.tr(context),
              style: const TextStyle(
                color: constants.Colors.subtitleTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 14,
                ),
                controller: controller,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  alignLabelWithHint: true,
                  hintText: 'Amount'.tr(context),
                  contentPadding: const EdgeInsets.only(left: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 64),
            Center(
              child: UseBatchButton(
                onTap: (_) async {
                  await ServiceLocator.batchRepository.useBatch(
                      id: widget.batch.id,
                      amount: int.tryParse(controller.text) ?? 0);
                  final BatchCubit cubit = BlocProvider.of(context);
                  cubit.clear();
                },
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            WriteOffAllButton(id: widget.batch.id),
          ],
        ),
      ),
    );
  }
}
