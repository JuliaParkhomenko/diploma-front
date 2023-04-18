import 'package:diploma_frontend/enums/logged_in_state.dart';
import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:diploma_frontend/services/route_service/route_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

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
      final AppStateService appStateService =
          Provider.of<AppStateService>(context);
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
          return RouteService().authMap;
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppStateService>.value(
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
    );
  }
}
