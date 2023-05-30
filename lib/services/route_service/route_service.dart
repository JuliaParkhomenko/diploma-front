import 'package:diploma_frontend/director/pages/applications_page/applications_page.dart';
import 'package:diploma_frontend/director/pages/contracts_page/contracts_page.dart';
import 'package:diploma_frontend/director/pages/overview_page/overview_page.dart'
    as directorOverviewPage;
import 'package:diploma_frontend/director/pages/statistics_page/statistics_page.dart'
    as directorStatisticsPage;
import 'package:diploma_frontend/director/pages/suppliers_page/suppliers_page.dart';
import 'package:diploma_frontend/director/pages/supplies_page/supplies_page.dart';
import 'package:diploma_frontend/director/pages/warehouses_page/warehouses_page.dart'
    as directorWarehousesPage;
import 'package:diploma_frontend/pages/admin/admin_page.dart';
import 'package:diploma_frontend/pages/application_page/application_page.dart';
import 'package:diploma_frontend/pages/auth_page/auth_page.dart';
import 'package:diploma_frontend/pages/batches_page/batches_page.dart';
import 'package:diploma_frontend/director/pages/director_page/director_page.dart';
import 'package:diploma_frontend/pages/landing_page/landing_page.dart';
import 'package:diploma_frontend/pages/manager_page/manager_page.dart';
import 'package:diploma_frontend/pages/ordered_batch_page/ordered_batch_page.dart';
import 'package:diploma_frontend/pages/overview_page/overview_page.dart'
    as managerOverviewPage;
import 'package:diploma_frontend/pages/received_batch_page/received_batch_page.dart';
import 'package:diploma_frontend/pages/reminders_page/reminders_page.dart';
import 'package:diploma_frontend/pages/specific_product/specific_product_page.dart';
import 'package:diploma_frontend/pages/splash_page/splash_page.dart';
import 'package:diploma_frontend/pages/statistics_page/statistics_page.dart'
    as managerStatisticsPage;
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
            child: managerOverviewPage.OverviewPage(),
          ),
      '/stocks': (route) => const MaterialPage(
            child: StocksPage(),
          ),
      '/stocks/product/:name': (route) {
        return MaterialPage(
          child: SpecificProductPage(
            productName: route.pathParameters['name']!,
            stockId: int.parse(route.queryParameters['id']!),
          ),
        );
      },
      '/stocks/product/:name/batch/:id': (route) => MaterialPage(
            child: OrderedBatchPage(
              batchId: int.parse(route.pathParameters['id']!),
            ),
          ),
      '/stocks/product/:name/received/:id': (route) => MaterialPage(
            child: ReceivedBatchPage(
              batchId: int.parse(route.pathParameters['id']!),
            ),
          ),
      '/batches': (route) => const MaterialPage(
            child: BatchesPage(),
          ),
      '/reminders': (route) => const MaterialPage(
            child: RemindersPage(),
          ),
      '/statistics': (route) => const MaterialPage(
            child: managerStatisticsPage.StatisticsPage(),
          ),
      '/application': (route) => const MaterialPage(
            child: ApplicationPage(),
          ),
    },
  );

  final RouteMap directorMap = RouteMap(
    onUnknownRoute: (_) => const Redirect('/'),
    routes: {
      '/': (route) => const IndexedPage(
            child: DirectorPage(),
            paths: [
              '/overview',
              '/warehouses',
              '/suppliers',
              '/contracts',
              '/supplies',
              '/applications',
              '/statistics',
            ],
          ),
      '/overview': (route) => const MaterialPage(
            child: directorOverviewPage.OverviewPage(),
          ),
      '/warehouses': (route) => const MaterialPage(
            child: directorWarehousesPage.WarehousesPage(),
          ),
      '/suppliers': (route) {
        return const MaterialPage(
          child: SuppliersPage(),
        );
      },
      '/contracts': (route) => const MaterialPage(
            child: ContractsPage(),
          ),
      '/supplies': (route) => const MaterialPage(
            child: SuppliesPage(),
          ),
      '/applications': (route) => const MaterialPage(
            child: ApplicationsPage(),
          ),
      '/statistics': (route) => const MaterialPage(
            child: directorStatisticsPage.StatisticsPage(),
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
