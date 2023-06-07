import 'package:diploma_frontend/blocs/ordered_batches/ordered_batches_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/users/manager/pages/batches_page/widgets/ordered_batches_view.dart';
import 'package:diploma_frontend/users/manager/pages/ordered_batch_page/widgets/receive_batch_row.dart';
import 'package:diploma_frontend/users/manager/pages/stocks_page/widgets/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class BatchesPage extends StatefulWidget {
  const BatchesPage({
    super.key,
  });

  @override
  State<BatchesPage> createState() => _BatchesPageState();
}

class _BatchesPageState extends State<BatchesPage> {
  final TextEditingController productController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController kindController = TextEditingController();

  @override
  void didChangeDependencies() {
    final WarehouseCubit warehouseCubit = BlocProvider.of(context);
    final OrderedBatchesCubit cubit = BlocProvider.of(context);
    cubit.fetchBatches(
      warehouseCubit.selectedWarehouseIndex,
      productName: productController.text,
      batchId: batchController.text,
      kind: kindController.text,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<OrderedBatchesCubit, OrderedBatchesState>(
      builder: (context, state) {
        final OrderedBatchesCubit cubit = BlocProvider.of(context);
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ordered batches'.tr(context),
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  SizedBox(
                    height: 32,
                    width: 200,
                    child: SearchTextfield(
                      hintText: 'Product'.tr(context),
                      onChanged: (value) {
                        search(cubit);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 32,
                    width: 200,
                    child: SearchTextfield(
                      hintText: 'Batch'.tr(context),
                      onChanged: (value) {
                        search(cubit);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 32,
                    width: 200,
                    child: SearchTextfield(
                      hintText: 'Kind'.tr(context),
                      onChanged: (value) {
                        search(cubit);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () async {
                      productController.clear();
                      kindController.clear();
                      batchController.clear();
                      search(cubit);
                    },
                    child: const Icon(
                      Icons.close_rounded,
                      size: 32,
                      color: constants.Colors.subtitleTextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              OrderedBatchesView(
                onClick: (value) {
                  if (value) {
                    setState(() {});
                  }
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Receiving a batch'.tr(context),
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              const SizedBox(height: 32),
              if (cubit.orderedBatch != null)
                ReceiveBatchRow(
                  batchId: cubit.orderedBatch!.batchId,
                ),
            ],
          ),
        );
      },
    );
  }

  void search(OrderedBatchesCubit cubit) {
    final WarehouseCubit warehouseCubit = BlocProvider.of(context);
    cubit.fetchBatches(
      warehouseCubit.selectedWarehouseIndex,
      productName: productController.text,
      batchId: batchController.text,
      kind: kindController.text,
    );
  }
}
