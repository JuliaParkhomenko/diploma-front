import 'package:diploma_frontend/blocs/application/application_cubit.dart';
import 'package:diploma_frontend/blocs/batch/batch_cubit.dart';
import 'package:diploma_frontend/blocs/batch_supply/batch_supply_cubit.dart';
import 'package:diploma_frontend/blocs/expiring_batches/expiring_batches_cubit.dart';
import 'package:diploma_frontend/blocs/kind/kind_cubit.dart';
import 'package:diploma_frontend/blocs/localization/localization_cubit.dart';
import 'package:diploma_frontend/blocs/ordered_batches/ordered_batches_cubit.dart';
import 'package:diploma_frontend/blocs/product/product_cubit.dart';
import 'package:diploma_frontend/blocs/specific_product/specific_product_cubit.dart';
import 'package:diploma_frontend/blocs/statistics/statistics_cubit.dart';
import 'package:diploma_frontend/blocs/stock/stock_cubit.dart';
import 'package:diploma_frontend/blocs/supplier/supplier_cubit.dart';
import 'package:diploma_frontend/blocs/supply_contracts/supply_contracts_cubit.dart';
import 'package:diploma_frontend/blocs/user_action/user_action_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/enums/logged_in_state.dart';
import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:diploma_frontend/services/language_service/app_localization.dart';
import 'package:diploma_frontend/services/route_service/route_service.dart';
import 'package:diploma_frontend/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    ServiceLocator.appStateService.logIn();
    super.initState();
  }

  final RoutemasterDelegate _routemasterDelegate = RoutemasterDelegate(
    routesBuilder: (context) {
      final AppStateService appStateService = Provider.of<AppStateService>(
        context,
      );

      switch (appStateService.loggedInState) {
        case LoggedInState.admin:
          return RouteService().adminMap;
        case LoggedInState.manager:
          return RouteService().managerMap;
        case LoggedInState.director:
          return RouteService().directorMap;
        case LoggedInState.loading:
          return RouteService().loadingMap;
        case LoggedInState.loggedOut:
          return RouteService().authMap;
        default:
          return RouteService().directorMap;
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BatchCubit>(
          create: (context) => BatchCubit(
            ServiceLocator.batchRepository,
          ),
        ),
        BlocProvider<StatisticsCubit>(
          create: (context) => StatisticsCubit(
            ServiceLocator.statisticsRepository,
          ),
        ),
        BlocProvider<StockCubit>(
          create: (context) => StockCubit(
            ServiceLocator.warehouseRepository,
          ),
        ),
        BlocProvider<WarehouseCubit>(
          create: (context) => WarehouseCubit(
            ServiceLocator.warehouseRepository,
          ),
        ),
        BlocProvider<ProductCubit>(
          create: (context) => ProductCubit(
            ServiceLocator.productRepository,
          ),
        ),
        BlocProvider<SpecificProductCubit>(
          create: (context) => SpecificProductCubit(
            ServiceLocator.batchRepository,
          ),
        ),
        BlocProvider<BatchSupplyCubit>(
          create: (context) => BatchSupplyCubit(
            ServiceLocator.batchRepository,
          ),
        ),
        BlocProvider<OrderedBatchesCubit>(
          create: (context) => OrderedBatchesCubit(
            ServiceLocator.batchRepository,
          ),
        ),
        BlocProvider<ApplicationCubit>(
          create: (context) => ApplicationCubit(
            ServiceLocator.warehouseRepository,
          ),
        ),
        BlocProvider<KindCubit>(
          create: (context) => KindCubit(
            ServiceLocator.productRepository,
          ),
        ),
        BlocProvider<UserActionCubit>(
          create: (context) => UserActionCubit(
            ServiceLocator.warehouseRepository,
          ),
        ),
        BlocProvider<ExpiringBatchesCubit>(
          create: (context) => ExpiringBatchesCubit(
            ServiceLocator.batchRepository,
          ),
        ),
        BlocProvider<SupplierCubit>(
          create: (context) => SupplierCubit(
            ServiceLocator.supplierRepository,
          ),
        ),
        BlocProvider<SupplyContractsCubit>(
          create: (context) => SupplyContractsCubit(
            ServiceLocator.supplierRepository,
          ),
        ),
      ],
      child: FutureBuilder(
        future: GetIt.instance.allReady(),
        builder: (_, snapshot) {
          return ChangeNotifierProvider<AppStateService>.value(
            value: ServiceLocator.appStateService,
            child: BlocBuilder<LocalizationCubit, LocalizationState>(
              builder: (context, state) {
                if (state is ChangeLocalState) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    supportedLocales: const [
                      Locale('uk', ''),
                      Locale('en', ''),
                    ],
                    title: 'Diploma work',
                    localizationsDelegates: const [
                      AppLocalization.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate
                    ],
                    localeResolutionCallback: (current, supported) {
                      for (final locale in supported) {
                        if (current != null &&
                            current.languageCode == locale.languageCode) {
                          return current;
                        }
                      }
                      return supported.first;
                    },
                    routeInformationParser: const RoutemasterParser(),
                    routerDelegate: _routemasterDelegate,
                    locale: state.locale,
                  );
                } else {
                  return Container();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
