import 'package:diploma_frontend/pages/overview_page/widgets/overview_recent_actions.dart';
import 'package:flutter/material.dart';

import 'package:diploma_frontend/constants/constants.dart' as constants;

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        //color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // TODO: Yuliia`s question. Should I add const?
          // ignore: prefer_const_constructors
          OverviewRecentActions(),
          // SizedBox(
          //   width: 900,
          // ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        constants.Colors.overviewReminderColor.withOpacity(0.2),
                        constants.Colors.overviewReminderColor.withOpacity(0.7),
                      ],
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        constants.Colors.overviewOrderedBatchesColor
                            .withOpacity(0.2),
                        constants.Colors.overviewOrderedBatchesColor
                            .withOpacity(0.7),
                      ],
                    )),
              ),
            ],
          )
        ],
      ),
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