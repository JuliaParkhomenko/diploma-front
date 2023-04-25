import 'package:diploma_frontend/blocs/stock/stock_cubit.dart';
import 'package:diploma_frontend/models/stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StocksTable extends StatelessWidget {
  const StocksTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockCubit, StockState>(
      builder: (BuildContext context, state) {
        if (state is StockInitial) {
          final StockCubit cubit = BlocProvider.of<StockCubit>(context);
          cubit.fetchStocks(3);
        }
        if (state is StockLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is StockError) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is StockLoaded) {
          return ListView.builder(
            itemCount: state.stocks.length,
            itemBuilder: (context, index) {
              final Stock item = state.stocks[index];
              return Text(item.productName);
            },
          );
        }
        return Container();
      },
    );
  }
}
