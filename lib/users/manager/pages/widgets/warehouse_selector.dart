import 'package:diploma_frontend/blocs/ordered_batches/ordered_batches_cubit.dart';
import 'package:diploma_frontend/blocs/stock/stock_cubit.dart';
import 'package:diploma_frontend/blocs/user_action/user_action_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/models/warehouse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WarehouseSelector extends StatefulWidget {
  final List<Warehouse> warehouses;
  const WarehouseSelector({
    super.key,
    required this.warehouses,
  });

  @override
  State<WarehouseSelector> createState() => _WarehouseSelectorState();
}

class _WarehouseSelectorState extends State<WarehouseSelector> {
  String? value;

  final List<Map<String, String>> warehouses = [];
  @override
  void initState() {
    for (final i in widget.warehouses) {
      warehouses.add({
        'value': i.id.toString(),
        'label': i.name,
      });
    }
    final OrderedBatchesCubit orderedBatchesCubit =
        BlocProvider.of<OrderedBatchesCubit>(context);
    orderedBatchesCubit.fetchBatches(widget.warehouses.first.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.warehouses.isEmpty) {
      return Container();
    }
    if (widget.warehouses.length == 1) {
      return Text(widget.warehouses.first.name);
    }
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: DropdownButton<String>(
        //dropdownColor: Colors.lightGreen,
        focusColor: Colors.white10,
        underline: const SizedBox(),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        selectedItemBuilder: (context) {
          return warehouses
              .map<DropdownMenuItem<String>>(
                (e) => DropdownMenuItem<String>(
                  value: e['value'],
                  child: Text(
                    e['label']!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
              .toList();
        },
        hint: Text(
          widget.warehouses.first.name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        value: value,
        items: warehouses
            .map<DropdownMenuItem<String>>(
              (e) => DropdownMenuItem<String>(
                value: e['value'],
                child: Text(
                  e['label']!,
                  style: const TextStyle(
                    //color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (newValue) {
          final WarehouseCubit cubit = BlocProvider.of<WarehouseCubit>(context);
          cubit.selectedWarehouseIndex = int.parse(newValue!);
          final StockCubit stockCubit = BlocProvider.of<StockCubit>(context);
          stockCubit.fetchStocks(cubit.selectedWarehouseIndex, '');
          final OrderedBatchesCubit orderedBatchesCubit =
              BlocProvider.of<OrderedBatchesCubit>(context);
          final UserActionCubit userActionCubit =
              BlocProvider.of<UserActionCubit>(context);
          userActionCubit.fetchUserActions(
            BlocProvider.of<WarehouseCubit>(context).selectedWarehouseIndex,
          );
          orderedBatchesCubit.fetchBatches(int.parse(newValue));
          setState(() {
            value = newValue;
          });
        },
      ),
    );
  }
}
