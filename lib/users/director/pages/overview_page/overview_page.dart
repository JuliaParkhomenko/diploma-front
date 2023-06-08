import 'package:diploma_frontend/users/director/pages/overview_page/widgets/overview_expiring_contracts.dart';
import 'package:diploma_frontend/users/director/pages/overview_page/widgets/overview_recent_actions.dart';
import 'package:flutter/material.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OverviewRecentActions(),
        SizedBox(width: 16),
        OverviewExpiringContracts(),
      ],
    );
  }
}
