import 'package:diploma_frontend/blocs/statistics/statistics_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/models/statistics.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  bool total = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final StatisticsCubit cubit = BlocProvider.of(context);
        if (state is StatisticsInitial) {
          final WarehouseCubit warehouseCubit = BlocProvider.of(context);
          cubit.fetchStatistics(warehouseCubit.selectedWarehouseIndex);
        }

        if (state is StatisticsLoaded) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Row(
                      children: [
                        Text(total ? 'Total' : 'Daily'),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 100,
                          child: Switch(
                            value: total,
                            onChanged: (value) {
                              setState(() {
                                total = !total;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: getMaxElement(state.statistics).toDouble(),
                      interval:
                          (getMaxElement(state.statistics).toDouble() / 15)
                              .roundToDouble(),
                    ),
                    series: [
                      ColumnSeries<_ChartData, String>(
                        dataSource: List.generate(
                          state.statistics.length,
                          (index) => _ChartData(
                            state.statistics[index].productName,
                            total
                                ? state.statistics[index].totalUsed.toDouble()
                                : state.statistics[index].userDaily.toDouble(),
                          ),
                        ),
                        xValueMapper: (_ChartData data, _) => data.x,
                        yValueMapper: (_ChartData data, _) => data.y,
                        name: 'Gold',
                      ),
                    ],
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

  num getMaxElement(List<Statistics> list) {
    num maxValue = 0;
    for (final i in list) {
      if (total) {
        if (maxValue < i.total) {
          maxValue = i.total;
        }
      } else {
        if (maxValue < i.userDaily) {
          maxValue = i.userDaily;
        }
      }
    }

    return maxValue < 15 ? 15 : maxValue;
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
