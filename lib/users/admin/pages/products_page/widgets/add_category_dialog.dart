import 'package:diploma_frontend/blocs/category/category_cubit.dart';
import 'package:diploma_frontend/models/category.dart';
import 'package:diploma_frontend/repositories/product_repository/product_repository.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract_page/widgets/dialog_textfield.dart';
import 'package:diploma_frontend/widgets/default_add_button.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  String name = '';
  num minTemp = 0;
  num maxTemp = 0;

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
                'Adding new category'.tr(context),
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
                        Text('Min temp.'.tr(context)),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            initialValue: '',
                            hintText: 'Min temperature',
                            onChanged: (value) =>
                                minTemp = num.tryParse(value) ?? 0,
                          ),
                        ),
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
                        Text('Max temp.'.tr(context)),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 200,
                          height: 42,
                          child: DialogTextfield(
                            initialValue: '',
                            hintText: 'Max temperature',
                            onChanged: (value) =>
                                maxTemp = num.tryParse(value) ?? 0,
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
                    final ProductRepository repository =
                        GetIt.instance<ProductRepository>();
                    await repository
                        .addCategory(
                      category: Category(
                        id: 0,
                        name: name,
                        minTemp: minTemp.toInt(),
                        maxTemp: maxTemp.toInt(),
                      ),
                    )
                        .then(
                      (value) {
                        final CategoryCubit cubit = BlocProvider.of(context);
                        cubit.clear();
                        Navigator.pop(context);
                      },
                    );
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
