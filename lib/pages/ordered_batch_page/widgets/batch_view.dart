import 'package:diploma_frontend/blocs/specific_product/specific_product_cubit.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:diploma_frontend/constants/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

class BatchView extends StatelessWidget {
  const BatchView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width * .72,
          color: constants.Colors.greyTable,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getTitle(size, 'Kind'.tr(context), bold: true),
              getTitle(size, 'Maker'.tr(context), bold: true),
              getTitle(size, 'Status'.tr(context), bold: true),
              getTitle(size, 'Amount'.tr(context), bold: true),
              //TODO add order date to lang files
              getTitle(size, 'Order date'.tr(context), bold: true),
            ],
          ),
        ),
        BlocBuilder<SpecificProductCubit, SpecificProductState>(
          builder: (context, state) {
            if (state is SpecificProductLoaded) {
              final SpecificProductCubit cubit = BlocProvider.of(context);
              return Container(
                width: size.width * .72,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTitle(size, cubit.batch!.kind),
                    getTitle(size, cubit.batch!.maker),
                    getTitle(size, cubit.batch!.status.name),
                    getTitle(size, cubit.batch!.amount.toString()),
                    //TODO add order date to lang files
                    getTitle(
                        size,
                        cubit.batch!.expirationDate
                            .toString()
                            .substring(0, 10)),
                  ],
                ),
              );
            }

            return Container();
          },
        ),
      ],
    );
  }

  Widget getTitle(Size size, String title, {bool bold = false}) {
    return SizedBox(
      height: 60,
      width: size.width * .72 / 5,
      child: Align(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'OpenSans',
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
