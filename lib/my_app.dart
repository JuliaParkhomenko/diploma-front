import 'package:diploma_frontend/blocs/stock/stock_cubit.dart';
import 'package:diploma_frontend/blocs/warehouse/warehouse_cubit.dart';
import 'package:diploma_frontend/enums/logged_in_state.dart';
import 'package:diploma_frontend/repositories/warehouse_repository/warehouse_repository.dart';
import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:diploma_frontend/services/route_service/route_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppStateService appStateService = AppStateService();

  @override
  void initState() {
    appStateService.logIn();
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
        BlocProvider(
          create: (context) => StockCubit(
            WarehouseRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => WarehouseCubit(
            WarehouseRepository(),
          ),
        ),
      ],
      child: ChangeNotifierProvider<AppStateService>.value(
        value: appStateService,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          title: 'Diploma work',
          localizationsDelegates: context.localizationDelegates,
          routeInformationParser: const RoutemasterParser(),
          routerDelegate: _routemasterDelegate,
        ),
      ),
    );
  }
}
