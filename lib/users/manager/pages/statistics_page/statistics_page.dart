import 'package:diploma_frontend/blocs/product/product_cubit.dart';
import 'package:diploma_frontend/blocs/statistics/statistics_cubit.dart';
import 'package:diploma_frontend/models/category.dart';
import 'package:diploma_frontend/users/manager/pages/statistics_page/widgets/line_chart_widget.dart';
import 'package:diploma_frontend/users/manager/pages/statistics_page/widgets/product_dropdown.dart';
import 'package:diploma_frontend/models/product.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  Product currentProduct = Product(
    id: 1,
    category: Category(id: 1, name: '', minTemp: -1, maxTemp: -1),
    name: '',
    measurement: '',
  );
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final StatisticsCubit cubit = BlocProvider.of(context);
        if (state is StatisticsInitial) {
          cubit.fetchStatistics();
        }

        if (state is StatisticsLoaded) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Statistics'.tr(context),
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
                Row(
                  children: [
                    Text(
                      'Product'.tr(context),
                      style: const TextStyle(
                        color: constants.Colors.subtitleTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                      if (state is ProductInitial) {
                        final ProductCubit cubit =
                            BlocProvider.of<ProductCubit>(context);
                        cubit.fetchProducts();
                      }
                      if (state is ProductLoading) {
                        return ProductDropdown(
                          onChange: (_) {},
                          products: const [],
                        );
                      }
                      if (state is ProductError) {
                        return const Text('Error on server :)');
                      }
                      if (state is ProductLoaded) {
                        return ProductDropdown(
                          onChange: (productInd) {
                            setState(() {
                              //TODO: index!=id
                              currentProduct = state.products.firstWhere(
                                  (element) => element.id == productInd);
                            });
                          },
                          products: state.products,
                        );
                      }
                      return Container();
                    }),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height * 0.65,
                  width: size.width * 0.72,
                  child: LineChartWidget(
                    update: (p0) {
                      setState(() {});
                    },
                    isShowingMainData: true,
                    statistics: state.statistics,
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
