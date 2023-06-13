// ignore_for_file: use_build_context_synchronously

import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:diploma_frontend/services/bloc_service/bloc_service.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DestinationWidget extends StatelessWidget {
  final IconData icon;
  final int selectedIndex;
  final String text;
  final int pageIndex;
  final Function(int) onIndexChanged;
  final double padding;

  const DestinationWidget({
    super.key,
    required this.text,
    this.padding = 0,
    required this.icon,
    required this.pageIndex,
    required this.onIndexChanged,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: InkWell(
        onTap: () async {
          if (pageIndex == -1) {
            await ServiceLocator.database.clear();
            BlocService().clearCubits(context);
            await Provider.of<AppStateService>(context, listen: false).logIn();
          }

          onIndexChanged(pageIndex);
        },
        child: Container(
          height: 50,
          decoration: selectedIndex == pageIndex
              ? BoxDecoration(
                  color: Colors.white.withOpacity(.2),
                  borderRadius: BorderRadius.circular(17),
                )
              : null,
          width: 140,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        pageIndex == selectedIndex ? FontWeight.bold : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
