import 'package:diploma_frontend/blocs/stock/stock_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocService {
  void changeWarehouseId(BuildContext context) {
    final StockCubit stockCubit = BlocProvider.of<StockCubit>(context);
    stockCubit.clear();
  }
}
