import 'package:diploma_frontend/blocs/kind/kind_cubit.dart';
import 'package:diploma_frontend/blocs/product/product_cubit.dart';
import 'package:diploma_frontend/pages/application_page/widgets/kind_dropdown.dart';
import 'package:diploma_frontend/pages/application_page/widgets/product_dropdown.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
              'Application for ordering products'.tr(context),
              style: const TextStyle(
                color: constants.Colors.subtitleTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            Row(
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
                const Expanded(
                  child: SizedBox(),
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
                      onChange: (_) {
                        final KindCubit cubit =
                            BlocProvider.of<KindCubit>(context);
                        cubit.fetchKind(_);
                      },
                      products: state.products,
                    );
                  }
                  return Container();
                }),
                const Expanded(
                  child: SizedBox(),
                ),
                Text(
                  'Kind'.tr(context),
                  style: const TextStyle(
                    color: constants.Colors.subtitleTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                //TODO: implement function
                BlocBuilder<KindCubit, KindState>(builder: (context, state) {
                  if (state is KindLoading) {
                    return KindDropdown(
                      onChange: (_) {},
                      kinds: const [],
                    );
                  }
                  if (state is KindError) {
                    return const Text('Error on server :)');
                  }
                  if (state is KindLoaded) {
                    return KindDropdown(
                      onChange: (_) {},
                      kinds: state.kinds,
                    );
                  }
                  return Container();
                }),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
            Row(
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
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
