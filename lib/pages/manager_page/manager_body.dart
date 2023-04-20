import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManagerBody extends StatelessWidget {
  const ManagerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Database db = Database();
        await db.clear();
        AppStateService appStateService = AppStateService();
        //await appStateService.logIn();
        await Provider.of<AppStateService>(context, listen: false).logIn();
      },
      child: Container(
        color: Colors.yellowAccent,
      ),
    );
  }
}
