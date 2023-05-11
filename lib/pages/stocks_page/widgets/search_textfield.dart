import 'package:diploma_frontend/blocs/stock/stock_cubit.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextfield extends StatelessWidget {
  final TextEditingController controller;
  const SearchTextfield({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextField(
        onChanged: (value) async {
          final StockCubit cubit = BlocProvider.of<StockCubit>(context);
          await cubit.fetchStocks(3, value);
        },
        style: const TextStyle(
          fontSize: 14,
        ),
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontSize: 14,
          ),
          alignLabelWithHint: true,
          hintText: 'Search by name'.tr(context),
          prefixIcon: const Icon(
            Icons.search,
            size: 22,
          ),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}
