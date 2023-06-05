import 'package:diploma_frontend/users/director/pages/contracts_page/widgets/contracts_filters.dart';
import 'package:diploma_frontend/users/director/pages/contracts_page/widgets/contracts_table.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class ContractsPage extends StatefulWidget {
  const ContractsPage({super.key});

  @override
  State<ContractsPage> createState() => _ContractsPageState();
}

class _ContractsPageState extends State<ContractsPage> {
  bool activeContracts = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            !activeContracts
                ? 'Active contracts'.tr(context)
                : 'Past contracts'.tr(context),
            style: const TextStyle(
              color: constants.Colors.subtitleTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          ContractsFilters(
            old: activeContracts,
            onChanged: (value) {
              setState(() {
                activeContracts = value;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          // DO NOT REMOVE
          // ignore: prefer_const_constructors
          ContractsTable(),
        ],
      ),
    );
  }
}
