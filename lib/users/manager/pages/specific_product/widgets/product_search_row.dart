import 'package:diploma_frontend/blocs/specific_product/specific_product_cubit.dart';
import 'package:diploma_frontend/users/manager/pages/specific_product/widgets/product_status_dropdown.dart';
import 'package:diploma_frontend/users/manager/pages/stocks_page/widgets/search_textfield.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSearchRow extends StatefulWidget {
  final int productId;
  const ProductSearchRow({
    super.key,
    required this.productId,
  });

  @override
  State<ProductSearchRow> createState() => _ProductSearchRowState();
}

class _ProductSearchRowState extends State<ProductSearchRow> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController kindController = TextEditingController();
  final TextEditingController makerController = TextEditingController();
  String status = '';
  bool clear = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 32,
          width: 200,
          child: SearchTextfield(
            hintText: 'Batch'.tr(context),
            onChanged: (value) async {
              final SpecificProductCubit cubit =
                  BlocProvider.of<SpecificProductCubit>(context);
              await cubit.fetchBatches(
                widget.productId,
                batchId: searchController.text,
                kind: kindController.text,
                maker: makerController.text,
                status: status,
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          height: 32,
          width: 200,
          child: SearchTextfield(
            hintText: 'Kind'.tr(context),
            onChanged: (value) async {
              final SpecificProductCubit cubit =
                  BlocProvider.of<SpecificProductCubit>(context);
              await cubit.fetchBatches(
                widget.productId,
                batchId: searchController.text,
                kind: kindController.text,
                maker: makerController.text,
                status: status,
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          height: 32,
          width: 200,
          child: SearchTextfield(
            hintText: 'Maker'.tr(context),
            onChanged: (value) async {
              final SpecificProductCubit cubit =
                  BlocProvider.of<SpecificProductCubit>(context);
              await cubit.fetchBatches(
                widget.productId,
                batchId: searchController.text,
                kind: kindController.text,
                maker: makerController.text,
                status: status,
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          height: 32,
          width: 200,
          child: ProductStatusDropDown(
            clear: clear,
            onChange: (value) async {
              final SpecificProductCubit cubit =
                  BlocProvider.of<SpecificProductCubit>(context);
              status = value;
              await cubit.fetchBatches(
                widget.productId,
                batchId: searchController.text,
                kind: kindController.text,
                maker: makerController.text,
                status: status,
              );
            },
            status: const [
              'Received',
              'Ordered',
              'Written off',
            ],
          ),
        ),
        const SizedBox(width: 16),
        InkWell(
          onTap: () async {
            searchController.clear();
            kindController.clear();
            makerController.clear();
            status = '';
            setState(() {
              clear = !clear;
            });
            final SpecificProductCubit cubit =
                BlocProvider.of<SpecificProductCubit>(context);
            await cubit.fetchBatches(
              widget.productId,
              batchId: searchController.text,
              kind: kindController.text,
              maker: makerController.text,
              status: status,
            );
          },
          child: const Icon(
            Icons.close_rounded,
            size: 32,
            color: constants.Colors.subtitleTextColor,
          ),
        ),
      ],
    );
  }
}
