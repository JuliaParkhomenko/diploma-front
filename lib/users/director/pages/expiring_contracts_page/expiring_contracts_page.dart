import 'package:diploma_frontend/blocs/supply_contracts/supply_contracts_cubit.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:diploma_frontend/models/supply_contract.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/director/pages/expiring_contracts_page/widgets/expiring_contracts_table.dart';
import 'package:diploma_frontend/widgets/default_table/default_custom_table.dart';
import 'package:diploma_frontend/widgets/default_table/default_table_header.dart';
import 'package:diploma_frontend/widgets/default_table/default_table_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class ExpiringContractsPage extends StatelessWidget {
  const ExpiringContractsPage({super.key});

  static const DefaultTableHeader _header = DefaultTableHeader(
    headers: [
      'Contract number',
      'Supplier',
      'Min amount',
      'Max amount',
      'Start date',
      'End date',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: constants.Colors.managerWarehouseMain.withOpacity(0.6),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 31,
          right: 31,
          bottom: 20,
          top: 31,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Routemaster.of(context).history.back(),
              child: Text(
                '${'Overview'.tr(context)} > ${'Expiring contracts'.tr(context)}',
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const SizedBox(
              height: 20,
            ),
            const ExpiringContractsTable(),
          ],
        ),
      ),
    );
  }
}
