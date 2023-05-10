import 'package:diploma_frontend/pages/admin/admin_page.dart';
import 'package:diploma_frontend/pages/application_page/application_page.dart';
import 'package:diploma_frontend/pages/auth_page/auth_page.dart';
import 'package:diploma_frontend/pages/batches_page/batches_page.dart';
import 'package:diploma_frontend/pages/director_page/director_page.dart';
import 'package:diploma_frontend/pages/landing_page/landing_page.dart';
import 'package:diploma_frontend/pages/manager_page/manager_page.dart';
import 'package:diploma_frontend/pages/overview_page/overview_page.dart';
import 'package:diploma_frontend/pages/reminders_page/reminders_page.dart';
import 'package:diploma_frontend/pages/specific_product/specific_product_page.dart';
import 'package:diploma_frontend/pages/splash_page/splash_page.dart';
import 'package:diploma_frontend/pages/statistics_page/statistics_page.dart';
import 'package:diploma_frontend/pages/stocks_page/stocks_page.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class RouteService {
  final RouteMap loadingMap = RouteMap(
    onUnknownRoute: (_) => const Redirect('/'),
    routes: {
      '/': (route) => const MaterialPage(
            child: SplashPage(),
          ),
    },
  );

  final RouteMap adminMap = RouteMap(
    onUnknownRoute: (_) => const Redirect('/'),
    routes: {
      '/': (route) => const MaterialPage(
            child: AdminPage(),
          ),
    },
  );

  final RouteMap managerMap = RouteMap(
    onUnknownRoute: (_) => const Redirect('/'),
    routes: {
      '/': (route) => const IndexedPage(
            child: ManagerPage(),
            paths: [
              '/overview',
              '/stocks',
              '/batches',
              '/reminders',
              '/statistics',
              '/application',
            ],
          ),
      '/overview': (route) => const MaterialPage(
            child: OverviewPage(),
          ),
      '/stocks': (route) => const MaterialPage(
            child: StocksPage(),
          ),
      '/stocks/product/:name': (route) => MaterialPage(
            child: SpecificProductPage(
              productName: route.pathParameters['name']!,
              stockId: int.parse(route.queryParameters['id']!),
            ),
          ),
      '/batches': (route) => const MaterialPage(
            child: BatchesPage(),
          ),
      '/reminders': (route) => const MaterialPage(
            child: RemindersPage(),
          ),
      '/statistics': (route) => const MaterialPage(
            child: StatisticsPage(),
          ),
      '/application': (route) => const MaterialPage(
            child: ApplicationPage(),
          ),
    },
  );

  final RouteMap directorMap = RouteMap(
    onUnknownRoute: (_) => const Redirect('/'),
    routes: {
      '/': (route) => const MaterialPage(
            child: DirectorPage(),
          ),
    },
  );

  final RouteMap authMap = RouteMap(
    onUnknownRoute: (_) => const Redirect('/'),
    routes: {
      '/': (route) => const MaterialPage(
            child: LandingPage(),
          ),
      '/sign-in': (route) => const MaterialPage(
            child: AuthPage(),
          ),
    },
  );
}
