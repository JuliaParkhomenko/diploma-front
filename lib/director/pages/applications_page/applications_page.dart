import 'package:diploma_frontend/blocs/application/application_cubit.dart';
import 'package:diploma_frontend/director/pages/applications_page/widgets/application_button.dart';
import 'package:diploma_frontend/director/pages/applications_page/widgets/application_switcher.dart';
import 'package:diploma_frontend/director/pages/applications_page/widgets/application_table.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  bool past = false;
  List<int> selectedIdx = [];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: constants.Colors.managerWarehouseMain.withOpacity(0.6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            //TODO add to lang
            Row(
              children: [
                Text(
                  past
                      ? 'Past applications'.tr(context)
                      : 'Active applications'.tr(context),
                  style: const TextStyle(
                    color: constants.Colors.subtitleTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                ApplicationSwitcher(
                  onChanged: (value) {
                    setState(() {
                      past = value;
                    });
                    final ApplicationCubit cubit =
                        BlocProvider.of<ApplicationCubit>(context);
                    cubit.fetchApplications(
                      warehouseName: '',
                      past: value,
                    );
                  },
                ),
                const SizedBox(width: 128),
                ApplicationButton(
                  onTap: () {},
                  text: 'Order'.tr(context),
                  color: constants.Colors.main,
                ),
                const SizedBox(width: 32),
                ApplicationButton(
                  onTap: () async {
                    await ServiceLocator.warehouseRepository
                        .declineApplications(ids: selectedIdx);
                    final ApplicationCubit cubit =
                        BlocProvider.of<ApplicationCubit>(context);
                    cubit.clear();
                  },
                  text: 'Decline'.tr(context),
                  color: Colors.redAccent,
                ),
              ],
            ),
            const SizedBox(height: 32),
            ApplicationTable(
              past: past,
              name: '',
              indexChanges: (value) {
                selectedIdx = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
