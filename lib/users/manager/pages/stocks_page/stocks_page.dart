import 'package:diploma_frontend/blocs/stock/stock_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/users/manager/pages/stocks_page/widgets/search_textfield.dart';
import 'package:diploma_frontend/users/manager/pages/stocks_page/widgets/stocks_table.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class StocksPage extends StatefulWidget {
  const StocksPage({super.key});

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<WarehouseCubit, WarehouseState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final WarehouseCubit cubit = BlocProvider.of(context);

        return Container(
          width: size.width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: constants.Colors.managerWarehouseMain.withOpacity(0.6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stocks'.tr(context),
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
                SizedBox(
                  width: 200,
                  height: 32,
                  child: SearchTextfield(
                    hintText: 'Search by name'.tr(context),
                    onChanged: (value) async {
                      final StockCubit cubit =
                          BlocProvider.of<StockCubit>(context);
                      await cubit.fetchStocks(3, value);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height * 0.65,
                  width: size.width * 0.72,
                  child: StocksTable(
                    warehouseId: cubit.selectedWarehouseIndex,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
