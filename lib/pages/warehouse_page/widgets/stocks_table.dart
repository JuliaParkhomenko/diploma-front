import 'package:diploma_frontend/blocs/stock/stock_cubit.dart';
import 'package:diploma_frontend/enums/stocks_filter.dart';
import 'package:diploma_frontend/models/stock.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

class StocksTable extends StatefulWidget {
  final bool update;
  const StocksTable({super.key, required this.update});

  @override
  State<StocksTable> createState() => _StocksTableState();
}

class _StocksTableState extends State<StocksTable> {
  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<StockCubit, StockState>(
      builder: (BuildContext context, state) {
        if (state is StockInitial) {
          final StockCubit cubit = BlocProvider.of<StockCubit>(context);
          cubit.fetchStocks(3);
        }
        if (state is StockLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is StockError) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is StockLoaded) {
          final StockCubit cubit = BlocProvider.of<StockCubit>(context);

          return ListView.builder(
            itemCount: state.stocks.length,
            itemBuilder: (context, index) {
              final Stock item = state.stocks[index];

              if (index == 0) {
                return Column(
                  children: [
                    Container(
                      height: 60,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              cubit.filterStocks(
                                state.filter == StockFilter.productUp
                                    ? StockFilter.productDown
                                    : StockFilter.productUp,
                                state.stocks,
                              );
                            },
                            child: getTitle(
                              'Product'.tr(),
                              size,
                              bold: true,
                              showIcon:
                                  (state.filter == StockFilter.productUp ||
                                      state.filter == StockFilter.productDown),
                              up: state.filter == StockFilter.productUp,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.filterStocks(
                                state.filter == StockFilter.amountUp
                                    ? StockFilter.amountDown
                                    : StockFilter.amountUp,
                                state.stocks,
                              );
                            },
                            child: getTitle(
                              'Amount'.tr(),
                              size,
                              bold: true,
                              showIcon:
                                  (state.filter == StockFilter.amountDown ||
                                      state.filter == StockFilter.amountUp),
                              up: state.filter == StockFilter.amountUp,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.filterStocks(
                                state.filter == StockFilter.orderedUp
                                    ? StockFilter.orderedDown
                                    : StockFilter.orderedUp,
                                state.stocks,
                              );
                            },
                            child: getTitle(
                              'Ordered'.tr(),
                              size,
                              bold: true,
                              showIcon:
                                  (state.filter == StockFilter.orderedUp ||
                                      state.filter == StockFilter.orderedDown),
                              up: state.filter == StockFilter.orderedUp,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.filterStocks(
                                state.filter == StockFilter.totalUp
                                    ? StockFilter.totalDown
                                    : StockFilter.totalUp,
                                state.stocks,
                              );
                            },
                            child: getTitle(
                              'Total'.tr(),
                              size,
                              bold: true,
                              showIcon: (state.filter == StockFilter.totalUp ||
                                  state.filter == StockFilter.totalDown),
                              up: state.filter == StockFilter.totalUp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      color: constants.Colors.greyTable,
                      child: getItem(item, size),
                    ),
                  ],
                );
              } else {
                return Container(
                  height: 60,
                  color: index ~/ 2 == 0
                      ? Colors.white
                      : constants.Colors.greyTable,
                  child: getItem(item, size),
                );
              }
            },
          );
        }
        return Container();
      },
    );
  }

  Widget getTitle(
    String title,
    Size size, {
    bool bold = false,
    bool showIcon = false,
    bool up = false,
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      width: (size.width * 0.7 - 20) / 4,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (showIcon)
            const Expanded(
              child: SizedBox(),
            ),
          if (showIcon)
            Icon(
              up ? Icons.arrow_upward : Icons.arrow_downward,
              color: const Color.fromARGB(255, 255, 179, 0),
            ),
          if (showIcon) const SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget getItem(Stock item, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 20,
        ),
        getTitle(item.productName, size),
        getTitle(item.amountText, size),
        getTitle(item.orderedText, size),
        getTitle(item.total, size),
      ],
    );
  }
}
