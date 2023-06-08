import 'package:diploma_frontend/blocs/expiring_contracts/expiring_contracts_cubit.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/director/pages/overview_page/widgets/expiring_contracts_view_more_button.dart';
import 'package:diploma_frontend/users/director/pages/overview_page/widgets/overview_expiring_contracts_table.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class OverviewExpiringContracts extends StatefulWidget {
  const OverviewExpiringContracts({
    super.key,
  });

  @override
  State<OverviewExpiringContracts> createState() =>
      _OverviewExpiringContractsState();
}

class _OverviewExpiringContractsState extends State<OverviewExpiringContracts> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: (size.width * .65) / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            constants.Colors.overviewReminderColor.withOpacity(0.2),
            constants.Colors.overviewReminderColor.withOpacity(0.7),
          ],
        ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Expiring contracts'.tr(context),
                  style: const TextStyle(
                    color: constants.Colors.subtitleTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ExpiringContractsViewMoreButton(
                    onTap: () {
                      Routemaster.of(context)
                          .push('/overview/expiringContracts');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<ExpiringContractsCubit, ExpiringContractsState>(
              builder: (context, state) {
                if (state is ExpiringContractsInitial) {
                  final ExpiringContractsCubit cubit =
                      BlocProvider.of<ExpiringContractsCubit>(context);
                  cubit.clear();
                  cubit.featchExpiringContracts(
                    limit: 10,
                  );
                }

                if (state is ExpiringContractsLoading) {
                  return const OverviewExpiringContractsTable(
                    expiringContracts: [],
                  );
                }

                if (state is ExpiringContractsError) {
                  return const Text('Error on server :)');
                }

                if (state is ExpiringContractsLoaded) {
                  return OverviewExpiringContractsTable(
                    expiringContracts: state.expiringContracts,
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
