import 'package:diploma_frontend/blocs/specific_product/specific_product_cubit.dart';
import 'package:diploma_frontend/enums/action_status.dart';
import 'package:diploma_frontend/models/batch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;

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
        if (state is SpecificProductInitial) {}
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

  Widget getItem(Batch item, Size size) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        fixedSize: MaterialStatePropertyAll(
          Size(size.width * .72, 60),
        ),
      ),
      onPressed: () {},
      child: Row(
        children: [
          // const SizedBox(
          //   width: 13,
          // ),
          getTitle(item.id.toString(), size),
          getTitle(item.kind, size),
          getTitle(item.maker, size),
          getTitle(item.status.getActionStatus(), size),
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
          // const SizedBox(
          //   width: 20,
          // ),
          InkWell(
            onTap: () {
              if (state is SpecificProductLoaded) {
                // cubit.filterBatches(
                //   state.filter == StockFilter.productUp
                //       ? StockFilter.productDown
                //       : StockFilter.productUp,
                //   state.stocks,
                // );
              }
            },
            child: getTitle('Batch'.tr(), size,
                bold: true, showIcon: state is SpecificProductLoaded),
          ),
          InkWell(
            onTap: () {
              if (state is SpecificProductLoaded) {}
            },
            child: getTitle('Kind'.tr(), size,
                bold: true, showIcon: state is SpecificProductLoaded),
          ),
          InkWell(
            onTap: () {
              if (state is SpecificProductLoaded) {}
            },
            child: getTitle('Maker'.tr(), size,
                bold: true, showIcon: state is SpecificProductLoaded),
          ),
          InkWell(
            onTap: () {},
            child: getTitle('Status'.tr(), size,
                bold: true, showIcon: state is SpecificProductLoaded),
          ),
          InkWell(
            onTap: () {},
            child: getTitle('Amount'.tr(), size,
                bold: true, showIcon: state is SpecificProductLoaded),
          ),
          InkWell(
            onTap: () {},
            child: getTitle('Expiration date'.tr(), size,
                bold: true, showIcon: state is SpecificProductLoaded),
          ),
        ],
      ),
    );
  }
}
