import 'package:diploma_frontend/blocs/category/category_cubit.dart';
import 'package:diploma_frontend/blocs/product/product_cubit.dart';
import 'package:diploma_frontend/models/category.dart';
import 'package:diploma_frontend/models/product.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/admin/pages/products_page/widgets/category_dropdown.dart';
import 'package:diploma_frontend/users/admin/pages/products_page/widgets/measurement_dropdown.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract_page/widgets/dialog_textfield.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductDialog extends StatefulWidget {
  const AddProductDialog({super.key});

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  String name = '';
  String measurement = '';
  Category category = Category.empty();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: constants.Colors.mainButton,
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        width: size.width * 0.55,
        height: size.height * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Adding new product'.tr(context),
                style: const TextStyle(
                  color: constants.Colors.subtitleTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text('Name'.tr(context))),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            initialValue: '',
                            hintText: 'Name',
                            onChanged: (value) => name = value,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Category'.tr(context)),
                        const SizedBox(width: 15),
                        BlocBuilder<CategoryCubit, CategoryState>(
                          builder: (context, state) {
                            if (state is CategoryInitial) {
                              final CategoryCubit cubit =
                                  BlocProvider.of(context);
                              cubit.fetchCategories();
                            }

                            if (state is CategoryLoaded) {
                              return SizedBox(
                                width: 200,
                                height: 42,
                                child: CategoryDropdown(
                                  categories: state.categories,
                                  onChange: (value) {
                                    category = value;
                                  },
                                ),
                              );
                            }

                            return Container();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              //
              const SizedBox(height: 50),
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Measurement'.tr(context)),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: MeasurementDropdown(
                            onChange: (value) {
                              measurement = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 350,
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Align(
                alignment: Alignment.centerRight,
                child: DefaultAddButton(
                  buttonText: 'Add new',
                  onTap: () async {
                    final ProductCubit cubit = BlocProvider.of(context);
                    await cubit
                        .addProduct(
                          Product(
                            id: 0,
                            category: category,
                            name: name,
                            measurement: measurement,
                          ),
                        )
                        .then((value) => Navigator.pop(context));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
