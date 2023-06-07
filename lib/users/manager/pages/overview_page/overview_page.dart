import 'package:diploma_frontend/users/manager/pages/overview_page/widgets/overview_ordered_batches.dart';
import 'package:diploma_frontend/users/manager/pages/overview_page/widgets/overview_recent_actions.dart';
import 'package:diploma_frontend/users/manager/pages/overview_page/widgets/overview_reminder.dart';
import 'package:flutter/material.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // TODO: Yuliia`s question. Should I add const?
        // ignore: prefer_const_constructors
        OverviewRecentActions(),
        // SizedBox(
        //   width: 900,
        // ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OverviewReminder(),
            OverviewOrderedBatches(),
          ],
        )
      ],
    );
  }
}


// return Column(
//             children: [
//               ReceivedBatchInfo(
//                 batch: state.batch,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: BatchHistoryWidget(
//                       batch: state.batch,
//                     ),
//                   ),
//                   ReceivedBatchActionWidget(
//                     batch: state.batch,
//                   ),
//                 ],
//               ),
//             ],
//           );