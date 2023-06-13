// import 'package:diploma_frontend/blocs/application/application_cubit.dart';
// import 'package:diploma_frontend/blocs/batch/batch_cubit.dart';
// import 'package:diploma_frontend/blocs/batch_supply/batch_supply_cubit.dart';
// import 'package:diploma_frontend/blocs/category/category_cubit.dart';
// import 'package:diploma_frontend/blocs/expired_batches/expired_batches_cubit.dart';
// import 'package:diploma_frontend/blocs/expiring_batches/expiring_batches_cubit.dart';
// import 'package:diploma_frontend/blocs/expiring_contracts/expiring_contracts_cubit.dart';
// import 'package:diploma_frontend/blocs/kind/kind_cubit.dart';
// import 'package:diploma_frontend/blocs/manager/manager_cubit.dart';
// import 'package:diploma_frontend/blocs/opt_contract/opt_contract_cubit.dart';
// import 'package:diploma_frontend/blocs/ordered_batches/ordered_batches_cubit.dart';
// import 'package:diploma_frontend/blocs/product/product_cubit.dart';
// import 'package:diploma_frontend/blocs/specific_product/specific_product_cubit.dart';
// import 'package:diploma_frontend/blocs/statistics/statistics_cubit.dart';
import 'package:diploma_frontend/blocs/stock/stock_cubit.dart';
// import 'package:diploma_frontend/blocs/supplier/supplier_cubit.dart';
// import 'package:diploma_frontend/blocs/supply_contracts/supply_contracts_cubit.dart';
// import 'package:diploma_frontend/blocs/user_action/user_action_cubit.dart';
// import 'package:diploma_frontend/blocs/users/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocService {
  void changeWarehouseId(BuildContext context) {
    final StockCubit stockCubit = BlocProvider.of<StockCubit>(context);
    stockCubit.clear();
  }

  void clearCubits(BuildContext context) {
    // final ApplicationCubit applicationCubit = BlocProvider.of(context);
    // applicationCubit.clear();

    // final BatchCubit batchCubit = BlocProvider.of(context);
    // batchCubit.clear();

    // final BatchSupplyCubit batchSupplyCubit = BlocProvider.of(context);
    // batchSupplyCubit.clear();

    // final CategoryCubit categoryCubit = BlocProvider.of(context);
    // categoryCubit.clear();

    // final ExpiredBatchesCubit expiredBatchesCubit = BlocProvider.of(context);
    // expiredBatchesCubit.clear();

    // final ExpiringBatchesCubit expiringBatchesCubit = BlocProvider.of(context);
    // expiringBatchesCubit.clear();

    // final ExpiringContractsCubit expiringContractsCubit =
    //     BlocProvider.of(context);
    // expiringContractsCubit.clear();

    // final KindCubit kindCubit = BlocProvider.of(context);
    // kindCubit.clear();

    // final ManagerCubit managerCubit = BlocProvider.of(context);
    // managerCubit.clear();

    // final OptContractCubit optContractCubit = BlocProvider.of(context);
    // optContractCubit.clear();

    // final OrderedBatchesCubit orderedBatchesCubit = BlocProvider.of(context);
    // orderedBatchesCubit.clear();

    // final ProductCubit productCubit = BlocProvider.of(context);
    // productCubit.clear();

    // final SpecificProductCubit specificProductCubit = BlocProvider.of(context);
    // specificProductCubit.clear();

    // final StatisticsCubit statisticsCubit = BlocProvider.of(context);
    // statisticsCubit.clear();

    // final StockCubit stockCubit = BlocProvider.of(context);
    // stockCubit.clear();

    // final SupplierCubit supplierCubit = BlocProvider.of(context);
    // supplierCubit.clear();

    // final SupplyContractsCubit supplyContractsCubit = BlocProvider.of(context);
    // supplyContractsCubit.clear();

    // final UserActionCubit userActionCubit = BlocProvider.of(context);
    // userActionCubit.clear();

    // final UsersCubit usersCubit = BlocProvider.of(context);
    // usersCubit.clear();

    // final WarehouseCubit warehouseCubit = BlocProvider.of(context);
    // warehouseCubit.clear();
  }
}
