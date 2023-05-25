import 'package:diploma_frontend/enums/action_status.dart';
import 'package:diploma_frontend/enums/action_type.dart';
import 'package:diploma_frontend/models/user_action.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class OverviewRecentActionsTable extends StatelessWidget {
  final List<UserAction> actions;
  const OverviewRecentActionsTable({
    super.key,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      //Yuliia: it used to be receivedHistoryWidget
      children: [
        Container(
          width: size.width * .72,
          color: constants.Colors.greyTable,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getTitle(size, 'User'.tr(context), bold: true),
              getTitle(size, 'Action'.tr(context), bold: true),
              getTitle(size, 'Action with'.tr(context), bold: true),
              getTitle(size, 'Date'.tr(context), bold: true),
            ],
          ),
        ),
        SizedBox(
          height: 504, //(size.height - 132) * .4,
          child: ListView.builder(
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final UserAction userAction = actions[index];

              return Container(
                width: size.width * .72,
                color:
                    index % 2 == 0 ? Colors.white : constants.Colors.greyTable,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTitle(size, userAction.userFullName),
                    getTitle(
                      size,
                      userAction.type == ActionType.batch
                          ? ('${userAction.action.getActionStatus(context).tr(context)} ${userAction.amount} ${userAction.productMeasurement} ${userAction.productName}')
                          : userAction.action
                              .getActionStatus(context)
                              .tr(context),
                    ),
                    getTitle(
                        size,
                        userAction.type == ActionType.batch
                            ? ('${userAction.type.getActionType(context).tr(context)} ${userAction.targetId}')
                            : userAction.type
                                .getActionType(context)
                                .tr(context)),
                    getTitle(size, userAction.date.toString().split('.')[0]),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget getTitle(Size size, String title, {bool bold = false}) {
    return SizedBox(
      height: 56,
      width: size.width * .4 / 4,
      child: Align(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'OpenSans',
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;

//     return SizedBox(
//       height: 240,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: size.width * .72,
//             color: Colors.white,
//             child: Row(
//               mainAxisAlignment:
//                   MainAxisAlignment.spaceBetween, //Yuliia: OrderedBatches
//               children: [
//                 getTitle(size, 'User'.tr(context), bold: true),
//                 getTitle(size, 'Action'.tr(context), bold: true),
//                 getTitle(size, 'Action with'.tr(context), bold: true),
//                 getTitle(size, 'Date'.tr(context), bold: true),
//               ],
//             ),
//           ),
//           BlocBuilder<UserActionCubit, UserActionState>(
//             //Yuliia: OrderedBatches
//             builder: (context, state) {
//               if (state is OrderedBatchesLoaded) {
//                 return SizedBox(
//                   height: 180,
//                   width: size.width * .72,
//                   child: ListView.builder(
//                     itemCount: state.orderedBatches.length,
//                     itemBuilder: (context, index) {
//                       final OrderedBatch batch = state.orderedBatches[index];
//                       return InkWell(
//                         onTap: () {
//                           final OrderedBatchesCubit cubit =
//                               BlocProvider.of(context);
//                           cubit.orderedBatch = batch;
//                         },
//                         child: Container(
//                           width: size.width * .72,
//                           height: 60,
//                           color: index % 2 != 0
//                               ? Colors.white
//                               : constants.Colors.greyTable,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               getTitle(size, batch.productName),
//                               getTitle(size, batch.batchId.toString()),
//                               getTitle(size, batch.kind),
//                               getTitle(size, batch.amount.toString()),
//                               getTitle(size,
//                                   batch.orderDate.toString().substring(0, 10)),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               }

//               return Container();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget getTitle(Size size, String title, {bool bold = false}) {
//     return SizedBox(
//       height: 60,
//       width: size.width * .72 / 5,
//       child: Align(
//         child: Text(
//           title,
//           style: TextStyle(
//             fontWeight: bold ? FontWeight.bold : FontWeight.normal,
//             fontFamily: 'OpenSans',
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
