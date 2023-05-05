import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminBody extends StatelessWidget {
  const AdminBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await ServiceLocator.database.clear();
        await Provider.of<AppStateService>(context, listen: false).logIn();
      },
      child: Container(
        color: Colors.blueGrey,
      ),
    );
  }
}
