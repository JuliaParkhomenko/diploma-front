import 'package:diploma_frontend/blocs/product/product_cubit.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract/widgets/dialog_textfield.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract/widgets/edit_button.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract/widgets/products_dropdown.dart';
import 'package:diploma_frontend/users/manager/pages/widgets/info_overlay.dart';
import 'package:diploma_frontend/models/product.dart';
import 'package:diploma_frontend/models/supply_condition.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class EditConditionDialog extends StatefulWidget {
  final Function(SupplyCondition) onChange;
  final String product;
  final String kind;
  final String maker;
  final double minBatch;
  final double maxBatch;
  final double pricePerUnit;
  final String dialogName;
  const EditConditionDialog({
    super.key,
    required this.product,
    required this.kind,
    required this.maker,
    required this.minBatch,
    required this.maxBatch,
    required this.pricePerUnit,
    required this.dialogName,
    required this.onChange,
  });

  @override
  State<EditConditionDialog> createState() => _EditConditionDialogState();
}

class _EditConditionDialogState extends State<EditConditionDialog> {
  String productName = '';
  int productId = -1;
  late final TextEditingController minBatchController =
      TextEditingController(text: widget.minBatch.toString());
  late final TextEditingController maxBatchController =
      TextEditingController(text: widget.maxBatch.toString());
  late final TextEditingController kindController =
      TextEditingController(text: widget.kind);
  late final TextEditingController makerController =
      TextEditingController(text: widget.maker);
  late final TextEditingController pricePerUnitController =
      TextEditingController(text: widget.pricePerUnit.toString());

  late String kind = widget.kind;
  late String maker = widget.maker;
  late double? minBatch = widget.minBatch;
  late double? maxBatch = widget.maxBatch;
  late double? pricePerUnit = widget.pricePerUnit;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.55,
      height: size.height * 0.6,
      decoration: BoxDecoration(
        color: constants.Colors.mainButton,
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.dialogName.tr(context),
              style: const TextStyle(
                color: constants.Colors.subtitleTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            SizedBox(
              width: 850,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 340,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Product'.tr(context),
                          style: const TextStyle(
                            color: constants.Colors.subtitleTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: products(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 340,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Min batch'.tr(context),
                          style: const TextStyle(
                            color: constants.Colors.subtitleTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            hintText: 'Min batch'.tr(context),
                            controller: minBatchController,
                            onChanged: (_) {
                              setState(() {
                                minBatch = double.tryParse(_);
                              });
                            },
                          ),
                        ),
                        // const SizedBox(
                        //   width: 20,
                        // ),

                        // const SizedBox(
                        //   width: 40,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              width: 850,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 340,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Kind'.tr(context),
                          style: const TextStyle(
                            color: constants.Colors.subtitleTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            hintText: 'Kind'.tr(context),
                            controller: kindController,
                            onChanged: (_) {
                              setState(() {
                                kind = _;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 340,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Max batch'.tr(context),
                          style: const TextStyle(
                            color: constants.Colors.subtitleTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            hintText: 'Max batch'.tr(context),
                            controller: maxBatchController,
                            onChanged: (_) {
                              setState(() {
                                maxBatch = double.tryParse(_);
                              });
                            },
                          ),
                        ),
                        // const SizedBox(
                        //   width: 20,
                        // ),

                        // const SizedBox(
                        //   width: 40,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              width: 850,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 340,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Maker'.tr(context),
                          style: const TextStyle(
                            color: constants.Colors.subtitleTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            hintText: 'Maker'.tr(context),
                            controller: makerController,
                            onChanged: (_) {
                              setState(() {
                                maker = _;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 340,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price per unit'.tr(context),
                          style: const TextStyle(
                            color: constants.Colors.subtitleTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            hintText: 'Price per unit'.tr(context),
                            controller: pricePerUnitController,
                            onChanged: (_) {
                              setState(() {
                                maxBatch = double.tryParse(_);
                              });
                            },
                          ),
                        ),
                        // const SizedBox(
                        //   width: 20,
                        // ),

                        // const SizedBox(
                        //   width: 40,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              width: 1000,
              child: Align(
                alignment: Alignment.centerRight,
                child: EditButton(
                  dialogName: widget.dialogName,
                  onTap: () {
                    print(productName);
                    final SupplyCondition supplyCondition = SupplyCondition(
                      productId: productId,
                      productName: productName,
                      kind: kindController.text,
                      maker: makerController.text,
                      minAmount: double.tryParse(minBatchController.text) ?? 0,
                      maxAmount: double.tryParse(maxBatchController.text) ?? 0,
                      pricePerUnit:
                          double.tryParse(pricePerUnitController.text) ?? 0,
                      id: DateTime.now().millisecondsSinceEpoch,
                      productMeasurement: '',
                    );
                    widget.onChange(supplyCondition);
                    showInfoPrikol('Successfully edited'.tr(context), context);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget products(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductInitial) {
          final ProductCubit cubit = BlocProvider.of(context);
          cubit.fetchProducts();
        }

        if (state is ProductError) {
          return Center(
            child: Text(state.error),
          );
        }

        if (state is ProductLoading) {
          return ProductsDropdown(
            initialValue: widget.product,
            onChange: (_) {},
            products: [
              Product.empty(),
              Product.empty(),
            ],
          );
        }

        if (state is ProductLoaded) {
          if (productId == -1 && productName != '') {
            productId = state.products
                .firstWhere((element) => element.name == widget.product)
                .id;
            productName = state.products
                .firstWhere((element) => element.name == widget.product)
                .name;
          }

          if (productName == '') {
            productName = state.products.first.name;
          }

          return ProductsDropdown(
            initialValue: widget.product == ''
                ? ''
                : state.products
                    .firstWhere(
                      (element) => element.name == widget.product,
                    )
                    .id
                    .toString(),
            onChange: (productInd) {
              setState(() {
                productId = state.products[productInd - 1].id;
                productName = state.products[productInd - 1].name;
              });
            },
            products: state.products,
          );
        }

        return Container();
      },
    );
  }
}
