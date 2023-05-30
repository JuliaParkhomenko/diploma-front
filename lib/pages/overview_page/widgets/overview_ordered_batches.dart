import 'package:diploma_frontend/blocs/ordered_batches/ordered_batches_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/pages/overview_page/widgets/ordered_batches_view_more_button.dart';
import 'package:diploma_frontend/pages/overview_page/widgets/overview_ordered_batches_table.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class OverviewOrderedBatches extends StatefulWidget {
  const OverviewOrderedBatches({
    super.key,
  });

  @override
  State<OverviewOrderedBatches> createState() => _OverviewOrderedBatchesState();
}

class _OverviewOrderedBatchesState extends State<OverviewOrderedBatches> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            constants.Colors.overviewOrderedBatchesColor.withOpacity(0.2),
            constants.Colors.overviewOrderedBatchesColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(31),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                const Align(
                  alignment: Alignment.topRight,
                  child: OrderedBatchesViewMoreButton(),
                ),
              ],
            ),
            const SizedBox(height: 22),
            BlocBuilder<OrderedBatchesCubit, OrderedBatchesState>(
              builder: (context, state) {
                if (state is OrderedBatchesInitial) {
                  final OrderedBatchesCubit cubit =
                      BlocProvider.of<OrderedBatchesCubit>(context);
                  cubit.fetchBatches(
                    BlocProvider.of<WarehouseCubit>(context)
                        .selectedWarehouseIndex,
                  );
                }

                if (state is OrderedBatchesLoading) {
                  return const OverviewOrderedBatchesTable(
                    orderedBatches: [],
                  );
                }

                if (state is OrderedBatchesError) {
                  return const Text('Error on server :)');
                }

                if (state is OrderedBatchesLoaded) {
                  return OverviewOrderedBatchesTable(
                    orderedBatches: state.orderedBatches,
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
