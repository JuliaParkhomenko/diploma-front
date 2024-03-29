// ignore_for_file: use_build_context_synchronously

import 'package:diploma_frontend/blocs/kind/kind_cubit.dart';
import 'package:diploma_frontend/blocs/product/product_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/enums/urgency.dart';
import 'package:diploma_frontend/models/category.dart';
import 'package:diploma_frontend/models/product.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:diploma_frontend/users/manager/pages/application_page/widgets/amount_textfield.dart';
import 'package:diploma_frontend/users/manager/pages/application_page/widgets/kind_dropdown.dart';
import 'package:diploma_frontend/users/manager/pages/application_page/widgets/note_textfield.dart';
import 'package:diploma_frontend/users/manager/pages/application_page/widgets/product_dropdown.dart';
import 'package:diploma_frontend/users/manager/pages/application_page/widgets/send_button.dart';
import 'package:diploma_frontend/users/manager/pages/application_page/widgets/urgency_dropdown.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/manager/pages/widgets/info_overlay.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  String? kind;
  Urgency urgency = Urgency.notUrgent;

  Product currentProduct = Product(
    id: 0,
    category: Category(
      id: 1,
      name: '',
      minTemp: 0,
      maxTemp: 0,
    ),
    name: '',
    measurement: '',
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Application for ordering products'.tr(context),
            style: const TextStyle(
              color: constants.Colors.subtitleTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: 1000,
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
                      BlocBuilder<ProductCubit, ProductState>(
                          builder: (context, state) {
                        if (state is ProductInitial) {
                          final ProductCubit cubit =
                              BlocProvider.of<ProductCubit>(context);
                          cubit.fetchProducts();
                        }
                        if (state is ProductLoading) {
                          return ProductDropdown(
                            onChange: (_) {},
                            products: const [],
                          );
                        }
                        if (state is ProductError) {
                          return const Text('Error on server :)');
                        }
                        if (state is ProductLoaded) {
                          return ProductDropdown(
                            onChange: (productInd) {
                              //print(productInd);
                              final KindCubit cubit =
                                  BlocProvider.of<KindCubit>(context);
                              cubit.fetchKind(state.products
                                  .firstWhere(
                                      (element) => element.id == productInd)
                                  .id);
                              setState(() {
                                currentProduct = state.products.firstWhere(
                                    (element) => element.id == productInd);
                              });
                            },
                            products: state.products,
                          );
                        }
                        return Container();
                      }),
                    ],
                  ),
                ),
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
                      BlocBuilder<KindCubit, KindState>(
                          builder: (context, state) {
                        if (state is KindLoading) {
                          return IgnorePointer(
                            child: KindDropdown(
                              onChange: (_) {},
                              // ignore: prefer_const_literals_to_create_immutables
                              kinds: [' ', '  '],
                            ),
                          );
                        }
                        if (state is KindInitial) {
                          final KindCubit cubit =
                              BlocProvider.of<KindCubit>(context);
                          cubit.fetchKind(0);
                          return IgnorePointer(
                            child: KindDropdown(
                              onChange: (_) {},
                              // ignore: prefer_const_literals_to_create_immutables
                              kinds: [' ', '  '],
                            ),
                          );
                        }
                        if (state is KindError) {
                          return const Text('Error on server :)');
                        }
                        if (state is KindLoaded) {
                          if (state.kinds.isEmpty) {
                            return IgnorePointer(
                              child: KindDropdown(
                                onChange: (_) {},
                                // ignore: prefer_const_literals_to_create_immutables
                                kinds: [' ', '  '],
                              ),
                            );
                          }
                          return KindDropdown(
                            onChange: (String changedKind) {
                              kind = changedKind;
                            },
                            kinds: state.kinds,
                          );
                        }
                        return Container();
                      }),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 340,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount'.tr(context),
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
                        child: AmountTextfield(
                          hintText: 'Amount'.tr(context),
                          controller: amountController,
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: Text(
                    currentProduct.id == -1
                        ? ''
                        : currentProduct.measurement.tr(context),
                    style: const TextStyle(
                      color: constants.Colors.subtitleTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
                SizedBox(
                  width: 340,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Urgency'.tr(context),
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
                        height: 42,
                        width: 200,
                        child: UrgencyDropDown(
                          onChange: (String changed) {
                            urgency = changed.getUrgency();
                          },
                        ),
                      ),
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
            width: 540,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Note'.tr(context),
                  style: const TextStyle(
                    color: constants.Colors.subtitleTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                SizedBox(
                  width: 400,
                  height: 100,
                  child: NoteTextfield(
                    hintText: 'Note'.tr(context),
                    controller: noteController,
                    onChanged: (_) {},
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
              child: SendButton(
                onTap: () async {
                  await ServiceLocator.warehouseRepository.addAplication(
                    warehouseId: BlocProvider.of<WarehouseCubit>(context)
                        .selectedWarehouseIndex,
                    productId: currentProduct.id,
                    amount: int.tryParse(amountController.text) ?? 0,
                    kind: kind ?? '',
                    urgency: urgency,
                    note: noteController.text,
                    context: context,
                  );
                  showInfoPrikol(
                      'Application sent successfully'.tr(context), context);
                  final KindCubit kindCubit =
                      BlocProvider.of<KindCubit>(context);
                  await kindCubit.fetchKind(1);
                  final ProductCubit productCubit =
                      BlocProvider.of<ProductCubit>(context);
                  noteController.clear();
                  amountController.clear();
                  kind = '';
                  setState(() {
                    currentProduct = Product(
                      id: 1,
                      category: Category(
                        id: 1,
                        name: '',
                        minTemp: 0,
                        maxTemp: 0,
                      ),
                      name: '',
                      measurement: '',
                    );
                  });
                  await productCubit.fetchProducts();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
