// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:diploma_frontend/blocs/specific_product/specific_product_cubit.dart';
import 'package:diploma_frontend/blocs/stock/stock_cubit.dart';
import 'package:diploma_frontend/enums/stocks_filter.dart';
import 'package:diploma_frontend/models/stock.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:routemaster/routemaster.dart';

class StocksTable extends StatefulWidget {
  final int warehouseId;
  const StocksTable({
    super.key,
    required this.warehouseId,
  });

  @override
  State<StocksTable> createState() => _StocksTableState();
}

class _StocksTableState extends State<StocksTable> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<StockCubit, StockState>(
      builder: (BuildContext context, StockState state) {
        if (state is StockInitial) {
          final StockCubit cubit = BlocProvider.of<StockCubit>(context);
          cubit.fetchStocks(widget.warehouseId, '');
        }
        if (state is StockLoading) {
          final StockCubit cubit = BlocProvider.of<StockCubit>(context);
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 60,
              child: getTableHeader(size, state, cubit),
            ),
          );
        }
        if (state is StockError) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is StockLoaded) {
          final StockCubit cubit = BlocProvider.of<StockCubit>(context);
          if (state.stocks.isEmpty) {
            return Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 60,
                child: getTableHeader(size, state, cubit),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.stocks.length,
            itemBuilder: (context, index) {
              final Stock item = state.stocks[index];

              if (index == 0) {
                return Column(
                  children: [
                    getTableHeader(size, state, cubit),
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
      width: (size.width * 0.72 - 24) / 4,
      //color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'OpenSans',
                color: Colors.black,
              ),
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
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        fixedSize: MaterialStatePropertyAll(
          Size(size.width * .72, 60),
        ),
      ),
      onPressed: () {
        final SpecificProductCubit cubit =
            BlocProvider.of<SpecificProductCubit>(context);

        cubit.fetchBatches(
          item.productId,
        );
        Routemaster.of(context).push(
          '/stocks/product/${item.productName}',
          queryParameters: {
            'id': item.id.toString(),
          },
        );
      },
      child: Row(
        children: [
          // const SizedBox(
          //   width: 13,
          // ),
          getTitle(item.productName, size),
          getTitle(item.amountText, size),
          getTitle(item.orderedText, size),
          getTitle(item.total, size),
        ],
      ),
    );
  }

  Widget getTableHeader(Size size, StockState state, StockCubit cubit) {
    return Container(
      alignment: Alignment.topCenter,
      height: 60,
      color: Colors.white,
      child: Row(
        children: [
          // const SizedBox(
          //   width: 20,
          // ),
          InkWell(
            onTap: () {
              if (state is StockLoaded) {
                cubit.filterStocks(
                  state.filter == StockFilter.productUp
                      ? StockFilter.productDown
                      : StockFilter.productUp,
                  state.stocks,
                );
              }
            },
            child: getTitle(
              'Product'.tr(context),
              size,
              bold: true,
              showIcon: state is StockLoaded
                  ? (state.filter == StockFilter.productUp ||
                      state.filter == StockFilter.productDown)
                  : false,
              up: state is StockLoaded
                  ? state.filter == StockFilter.productUp
                  : false,
            ),
          ),
          InkWell(
            onTap: () {
              if (state is StockLoaded) {
                cubit.filterStocks(
                  state.filter == StockFilter.amountUp
                      ? StockFilter.amountDown
                      : StockFilter.amountUp,
                  state.stocks,
                );
              }
            },
            child: getTitle(
              'Amount'.tr(context),
              size,
              bold: true,
              showIcon: state is StockLoaded
                  ? (state.filter == StockFilter.amountDown ||
                      state.filter == StockFilter.amountUp)
                  : false,
              up: state is StockLoaded
                  ? state.filter == StockFilter.amountUp
                  : false,
            ),
          ),
          InkWell(
            onTap: () {
              if (state is StockLoaded) {
                cubit.filterStocks(
                  state.filter == StockFilter.orderedUp
                      ? StockFilter.orderedDown
                      : StockFilter.orderedUp,
                  state.stocks,
                );
              }
            },
            child: getTitle(
              'Ordered'.tr(context),
              size,
              bold: true,
              showIcon: state is StockLoaded
                  ? (state.filter == StockFilter.orderedUp ||
                      state.filter == StockFilter.orderedDown)
                  : false,
              up: state is StockLoaded
                  ? state.filter == StockFilter.orderedUp
                  : false,
            ),
          ),
          InkWell(
            onTap: () {
              if (state is StockLoaded) {
                cubit.filterStocks(
                  state.filter == StockFilter.totalUp
                      ? StockFilter.totalDown
                      : StockFilter.totalUp,
                  state.stocks,
                );
              }
            },
            child: getTitle(
              'Total'.tr(context),
              size,
              bold: true,
              showIcon: state is StockLoaded
                  ? (state.filter == StockFilter.totalUp ||
                      state.filter == StockFilter.totalDown)
                  : false,
              up: state is StockLoaded
                  ? state.filter == StockFilter.totalUp
                  : false,
            ),
          ),
        ],
      ),
    );
  }
}
