import 'package:diploma_frontend/users/director/pages/supplies_page/widgets/supplies_filters.dart';
import 'package:diploma_frontend/users/director/pages/supplies_page/widgets/supplies_table.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class SuppliesPage extends StatelessWidget {
  const SuppliesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Supplies'.tr(context),
            style: const TextStyle(
              color: constants.Colors.subtitleTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          const SuppliesFilters(),
          const SuppliesTable(),
        ],
      ),
    );
  }
}
