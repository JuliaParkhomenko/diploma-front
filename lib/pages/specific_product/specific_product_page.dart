import 'package:diploma_frontend/blocs/specific_product/specific_product_cubit.dart';
import 'package:diploma_frontend/pages/widgets/loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecificProductPage extends StatelessWidget {
  final int productId;
  final String productName;
  const SpecificProductPage({
    super.key,
    required this.productName,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<SpecificProductCubit, SpecificProductState>(
      builder: (context, state) {
        if (state is SpecificProductInitial) {
          final SpecificProductCubit cubit = BlocProvider.of(context);
          cubit.fetchBatches(productId);
        }

        if (state is SpecificProductLoading) {
          return const LoadingWidget();
        }

        if (state is SpecificProductError) {
          return Center(
            child: Text(state.error),
          );
        }

        if (state is SpecificProductLoaded) {
          return Container(
            width: size.width,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: constants.Colors.managerWarehouseMain.withOpacity(0.6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'Warehouse'.tr()} > ${'Stocks'.tr()} > ${'Stock'.tr()} ($productName)',
                    style: const TextStyle(
                      color: constants.Colors.subtitleTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Container(
          width: size.width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: constants.Colors.managerWarehouseMain.withOpacity(0.6),
          ),
        );
      },
    );
  }
}
