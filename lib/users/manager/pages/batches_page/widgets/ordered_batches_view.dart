import 'package:diploma_frontend/blocs/ordered_batches/ordered_batches_cubit.dart';
import 'package:diploma_frontend/models/ordered_batch.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderedBatchesView extends StatelessWidget {
  final Function(int) onClick;
  final int selected;
  const OrderedBatchesView(
      {super.key, required this.onClick, required this.selected});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width * .72,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getTitle(size, 'Product'.tr(context), bold: true),
                getTitle(size, 'Batch'.tr(context), bold: true),
                getTitle(size, 'Kind'.tr(context), bold: true),
                getTitle(size, 'Amount'.tr(context), bold: true),
                getTitle(size, 'Order date'.tr(context), bold: true),
              ],
            ),
          ),
          BlocBuilder<OrderedBatchesCubit, OrderedBatchesState>(
            builder: (context, state) {
              if (state is OrderedBatchesLoaded) {
                return SizedBox(
                  height: 180,
                  width: size.width * .72,
                  child: ListView.builder(
                    itemCount: state.orderedBatches.length,
                    itemBuilder: (context, index) {
                      final OrderedBatch batch = state.orderedBatches[index];
                      return InkWell(
                        onTap: () {
                          final OrderedBatchesCubit cubit =
                              BlocProvider.of(context);
                          cubit.orderedBatch = batch;
                          onClick(index);
                        },
                        child: Container(
                          width: size.width * .72,
                          height: 60,
                          color: getColor(index, batch.batchId),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getTitle(size, batch.productName),
                              getTitle(size, batch.batchId.toString()),
                              getTitle(size, batch.kind),
                              getTitle(size, batch.amount.toString()),
                              getTitle(size,
                                  batch.orderDate.toString().substring(0, 10)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }

  Color getColor(int index, int batchId) {
    if (selected == batchId) {
      return Colors.orange;
    } else {
      return index % 2 != 0 ? Colors.white : constants.Colors.greyTable;
    }
  }

  Widget getTitle(Size size, String title, {bool bold = false}) {
    return SizedBox(
      height: 60,
      width: size.width * .72 / 5,
      child: Align(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'OpenSans',
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
