import 'package:diploma_frontend/blocs/localization/localization_cubit.dart';
import 'package:diploma_frontend/models/warehouse.dart';
import 'package:diploma_frontend/pages/widgets/warehouse_selector.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManagerHeader extends StatelessWidget {
  final int selectedIndex;
  final List<Warehouse> warehouses;

  const ManagerHeader({
    super.key,
    required this.selectedIndex,
    required this.warehouses,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: 70,
      width: size.width - 140,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                constants.ManagerPagesList.generatePageNames(
                    context)[selectedIndex],
                style: const TextStyle(
                  color: constants.Colors.main,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(
              height: 1,
            ),
          ),
          WarehouseSelector(
            warehouses: warehouses,
          ),
          BlocBuilder<LocalizationCubit, LocalizationState>(
            builder: (context, state) {
              if (state is ChangeLocalState) {
                return GestureDetector(
                  onTap: () async {
                    await BlocProvider.of<LocalizationCubit>(context)
                        .changeLanguage(
                            state.locale == const Locale('uk') ? 'en' : 'uk');
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: SizedBox(
                      height: 20,
                      width: 30,
                      child: state.locale == const Locale('uk')
                          ? SvgPicture.asset(
                              'assets/images/ukraine-flag-icon.svg',
                              fit: BoxFit.fill,
                            )
                          : SvgPicture.asset(
                              'assets/images/england-flag-icon.svg',
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: constants.Colors.notificationShape,
            ),
            child: const Icon(
              Icons.notifications_none_outlined,
              size: 28,
              color: Color.fromARGB(200, 62, 62, 62),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromARGB(200, 62, 62, 62),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person,
              size: 34,
              color: constants.Colors.mainButtonBorder,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
