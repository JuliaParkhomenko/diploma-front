import 'package:diploma_frontend/blocs/specific_product/specific_product_cubit.dart';
import 'package:diploma_frontend/users/manager/pages/specific_product/widgets/product_search_row.dart';
import 'package:diploma_frontend/users/manager/pages/specific_product/widgets/specific_product_table.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translit/translit.dart';

class SpecificProductPage extends StatefulWidget {
  final int stockId;
  final String productName;
  const SpecificProductPage({
    super.key,
    required this.productName,
    required this.stockId,
  });

  @override
  State<SpecificProductPage> createState() => _SpecificProductPageState();
}

class _SpecificProductPageState extends State<SpecificProductPage> {
  @override
  void initState() {
    final SpecificProductCubit cubit =
        BlocProvider.of<SpecificProductCubit>(context);
    cubit.fetchBatches(
      widget.stockId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${'Stocks'.tr(context)} > ${'Stock'.tr(context)} (${Translit().unTranslit(source: widget.productName)})',
            style: const TextStyle(
              color: constants.Colors.subtitleTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          ProductSearchRow(
            productId: widget.stockId,
          ),
          const SizedBox(
            height: 15,
          ),
          SpecificProductTable(
            stockId: widget.stockId,
          ),
        ],
      ),
    );
  }
}
