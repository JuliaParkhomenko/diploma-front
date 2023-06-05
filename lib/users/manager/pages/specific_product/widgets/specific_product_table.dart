// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:diploma_frontend/blocs/batch/batch_cubit.dart';
import 'package:diploma_frontend/blocs/specific_product/specific_product_cubit.dart';
import 'package:diploma_frontend/enums/action_status.dart';
import 'package:diploma_frontend/enums/specific_product_filter.dart';
import 'package:diploma_frontend/models/batch.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:routemaster/routemaster.dart';

class SpecificProductTable extends StatefulWidget {
  final int stockId;
  const SpecificProductTable({
    super.key,
    required this.stockId,
  });

  @override
  State<SpecificProductTable> createState() => _SpecificProductTableState();
}

class _SpecificProductTableState extends State<SpecificProductTable> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<SpecificProductCubit, SpecificProductState>(
      builder: (BuildContext context, SpecificProductState state) {
        if (state is SpecificProductLoading) {
          final SpecificProductCubit cubit =
              BlocProvider.of<SpecificProductCubit>(context);
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 60,
              child: getTableHeader(size, state, cubit),
            ),
          );
        }
        if (state is SpecificProductError) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is SpecificProductLoaded) {
          final SpecificProductCubit cubit =
              BlocProvider.of<SpecificProductCubit>(context);
          if (state.batches.isEmpty) {
            return Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 60,
                child: getTableHeader(size, state, cubit),
              ),
            );
          }
          return SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: state.batches.length,
              itemBuilder: (context, index) {
                final Batch item = state.batches[index];

                if (index == 0) {
                  return Column(
                    children: [
                      getTableHeader(size, state, cubit),
                      Container(
                        height: 60,
                        width: size.width,
                        color: constants.Colors.greyTable,
                        child: getItem(item, size, state),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    height: 60,
                    color: index % 2 != 0
                        ? Colors.white
                        : constants.Colors.greyTable,
                    child: getItem(item, size, state),
                  );
                }
              },
            ),
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
      width: (size.width * 0.72 - 24) / 5,
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

  Widget getItem(Batch item, Size size, SpecificProductState state) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        fixedSize: MaterialStatePropertyAll(
          Size(size.width * .72, 60),
        ),
      ),
      onPressed: () {
        if (state is SpecificProductLoaded) {
          final SpecificProductCubit cubit =
              BlocProvider.of<SpecificProductCubit>(context);
          cubit.batch = item;
        }

        final BatchCubit batchCubit = BlocProvider.of(context);
        batchCubit.clear();

        if (item.status.name.toLowerCase().contains('ordered')) {
          Routemaster.of(context).push(
            '/stocks/product/${Routemaster.of(context).currentRoute.pathParameters['name']}/batch/${item.id}',
          );
        } else {
          Routemaster.of(context).push(
            '/stocks/product/${Routemaster.of(context).currentRoute.pathParameters['name']}/received/${item.id}',
          );
        }
      },
      child: Row(
        children: [
          getTitle(item.id.toString(), size),
          getTitle(item.kind, size),
          getTitle(item.maker, size),
          getTitle(item.status.getActionStatus(context), size),
          getTitle(item.amount.toString(), size),
          getTitle(item.expirationDate.toString().substring(0, 11), size),
        ],
      ),
    );
  }

  Widget getTableHeader(
      Size size, SpecificProductState state, SpecificProductCubit cubit) {
    return Container(
      alignment: Alignment.topCenter,
      height: 60,
      color: Colors.white,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (state is SpecificProductLoaded) {
                cubit.filterBatches(
                  state.filter == SpecificProductFilter.idDown
                      ? SpecificProductFilter.idUp
                      : SpecificProductFilter.idDown,
                  state.batches,
                );
              }
            },
            child: getTitle(
              'Batch'.tr(context),
              size,
              bold: true,
              showIcon: state is SpecificProductLoaded
                  ? state.filter == SpecificProductFilter.idUp ||
                      state.filter == SpecificProductFilter.idDown
                  : false,
              up: state is SpecificProductLoaded
                  ? state.filter == SpecificProductFilter.idUp
                  : false,
            ),
          ),
          getTitle('Kind'.tr(context), size, bold: true),
          getTitle('Maker'.tr(context), size, bold: true),
          getTitle('Status'.tr(context), size, bold: true),
          InkWell(
            onTap: () {
              if (state is SpecificProductLoaded) {
                cubit.filterBatches(
                  state.filter == SpecificProductFilter.amountDown
                      ? SpecificProductFilter.amountUp
                      : SpecificProductFilter.amountDown,
                  state.batches,
                );
              }
            },
            child: getTitle('Amount'.tr(context), size,
                bold: true,
                showIcon: state is SpecificProductLoaded
                    ? (state.filter == SpecificProductFilter.amountUp ||
                        state.filter == SpecificProductFilter.amountDown)
                    : false,
                up: state is SpecificProductLoaded
                    ? state.filter == SpecificProductFilter.amountUp
                    : false),
          ),
          InkWell(
            onTap: () {
              if (state is SpecificProductLoaded) {
                cubit.filterBatches(
                  state.filter == SpecificProductFilter.expirationDown
                      ? SpecificProductFilter.expirationUp
                      : SpecificProductFilter.expirationDown,
                  state.batches,
                );
              }
            },
            child: getTitle('Expiration date'.tr(context), size,
                bold: true,
                showIcon: state is SpecificProductLoaded
                    ? (state.filter == SpecificProductFilter.expirationUp ||
                        state.filter == SpecificProductFilter.expirationDown)
                    : false,
                up: state is SpecificProductLoaded
                    ? state.filter == SpecificProductFilter.expirationUp
                    : false),
          ),
        ],
      ),
    );
  }
}
