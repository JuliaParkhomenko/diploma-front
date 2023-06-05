import 'package:diploma_frontend/blocs/batch/batch_cubit.dart';
import 'package:diploma_frontend/users/manager/pages/received_batch_page/widgets/batch_history_widget.dart';
import 'package:diploma_frontend/users/manager/pages/received_batch_page/widgets/received_batch_action_widget.dart';
import 'package:diploma_frontend/users/manager/pages/received_batch_page/widgets/received_batch_info.dart';
import 'package:diploma_frontend/users/manager/pages/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceivedBatchPage extends StatelessWidget {
  final int batchId;

  const ReceivedBatchPage({
    super.key,
    required this.batchId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BatchCubit, BatchState>(
      builder: (context, state) {
        if (state is BatchInitial) {
          final BatchCubit cubit = BlocProvider.of(context);
          cubit.fetchBatch(batchId);
        }

        if (state is BatchLoading) {
          return const LoadingWidget();
        }

        if (state is BatchError) {
          return Center(
            child: Text(state.error),
          ); //Center
        }

        if (state is BatchLoaded) {
          return Column(
            children: [
              ReceivedBatchInfo(
                batch: state.batch,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BatchHistoryWidget(
                      batch: state.batch,
                    ),
                  ),
                  ReceivedBatchActionWidget(
                    batch: state.batch,
                  ),
                ],
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
