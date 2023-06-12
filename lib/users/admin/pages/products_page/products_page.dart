import 'package:diploma_frontend/blocs/product/product_cubit.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/admin/pages/products_page/widgets/add_category_dialog.dart';
import 'package:diploma_frontend/users/admin/pages/products_page/widgets/add_product_dialog.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
import 'package:diploma_frontend/widgets/default_table/default_custom_table.dart';
import 'package:diploma_frontend/widgets/default_table/default_table_header.dart';
import 'package:diploma_frontend/widgets/default_table/default_table_item.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const DefaultTableHeader header = DefaultTableHeader(
      headers: [
        'Id',
        'Name',
        'Category',
        'Measurement',
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Products'.tr(context),
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              Row(
                children: [
                  DefaultAddButton(
                    buttonText: 'Add category',
                    onTap: () async => _openAddCategoryDialog(context),
                  ),
                  const SizedBox(width: 15),
                  DefaultAddButton(
                    buttonText: 'Add product',
                    onTap: () async => _openAddProductDialog(context),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductInitial) {
                final ProductCubit cubit = BlocProvider.of(context);
                cubit.fetchProducts();
              }

              return state is ProductLoaded
                  ? DefaultCustomTable(
                      header: header,
                      items: List<DefaultTableItem>.generate(
                        state.products.length,
                        (index) => DefaultTableItem(
                          onTap: () {},
                          items: [
                            state.products[index].id.toString(),
                            state.products[index].name,
                            state.products[index].category.name,
                            state.products[index].measurement,
                          ],
                        ),
                      ),
                    )
                  : header;
            },
          ),
        ],
      ),
    );
  }

  Future<void> _openAddCategoryDialog(BuildContext context) async {
    await showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return const AddCategoryDialog();
      },
    );
  }

  Future<void> _openAddProductDialog(BuildContext context) async {
    await showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return const AddProductDialog();
      },
    );
  }
}
