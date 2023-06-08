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
        // const DefaultTableHeader(
        //     headers: ['User', 'Action', 'Action with', 'Date']),
        Container(
          width: size.width,
          color: constants.Colors.greyTable,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getTitle(size, 'User'.tr(context), bold: true),
              getTitle(size, 'Action'.tr(context), bold: true),
              getTitle(size, 'Object of action'.tr(context), bold: true),
              getTitle(size, 'Date'.tr(context), bold: true),
            ],
          ),
        ),
        SizedBox(
          height: 445,
          child: ListView.builder(
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final UserAction userAction = actions[index];
              print(actions.length);
              return Container(
                color:
                    index % 2 == 0 ? Colors.white : constants.Colors.greyTable,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTitle(size, userAction.userFullName),
                    getTitle(
                      size,
                      userAction.type == ActionType.batch
                          ? ('${userAction.action.getActionStatus(context)} ${userAction.amount} ${userAction.productMeasurement} ${userAction.productName}')
                          : userAction.action
                              .getActionStatus(context)
                              .tr(context),
                    ),
                    getTitle(size,
                        '${userAction.type.getActionType(context).tr(context)} ${userAction.targetId}'),
                    getTitle(size, userAction.date.toString().substring(0, 10)),
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
