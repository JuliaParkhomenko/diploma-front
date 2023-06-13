import 'package:diploma_frontend/users/admin/pages/products_page/products_page.dart';
import 'package:diploma_frontend/users/admin/pages/users_page/users_page.dart';
import 'package:diploma_frontend/users/admin/pages/warehouses_page/warehouses_page.dart';
import 'package:diploma_frontend/users/director/pages/add_new_contract_page/add_new_contract_page.dart';
import 'package:diploma_frontend/users/director/pages/add_new_supply_page/add_new_supply_page.dart';
import 'package:diploma_frontend/users/director/pages/applications_page/applications_page.dart';
import 'package:diploma_frontend/users/director/pages/contracts_page/contracts_page.dart';
import 'package:diploma_frontend/users/director/pages/expiring_contracts_page/expiring_contracts_page.dart';
import 'package:diploma_frontend/users/director/pages/overview_page/overview_page.dart'
    as director_overview_page;

import 'package:diploma_frontend/users/director/pages/suppliers_page/suppliers_page.dart';
import 'package:diploma_frontend/users/director/pages/supplies_page/supplies_page.dart';
import 'package:diploma_frontend/users/admin/pages/admin_page/admin_page.dart';
import 'package:diploma_frontend/users/manager/pages/application_page/application_page.dart';
import 'package:diploma_frontend/users/unuthorized/pages/auth_page/auth_page.dart';
import 'package:diploma_frontend/users/manager/pages/batches_page/batches_page.dart';
import 'package:diploma_frontend/users/director/pages/director_page/director_page.dart';
import 'package:diploma_frontend/users/unuthorized/pages/landing_page/landing_page.dart';
import 'package:diploma_frontend/users/manager/pages/manager_page/manager_page.dart';
import 'package:diploma_frontend/users/manager/pages/ordered_batch_page/ordered_batch_page.dart';
import 'package:diploma_frontend/users/manager/pages/overview_page/overview_page.dart'
    as manager_overview_page;
import 'package:diploma_frontend/users/manager/pages/received_batch_page/received_batch_page.dart';
import 'package:diploma_frontend/users/manager/pages/reminders_page/reminders_page.dart';
import 'package:diploma_frontend/users/manager/pages/specific_product/specific_product_page.dart';
import 'package:diploma_frontend/users/manager/pages/splash_page/splash_page.dart';
import 'package:diploma_frontend/users/manager/pages/statistics_page/statistics_page.dart';
import 'package:diploma_frontend/users/manager/pages/stocks_page/stocks_page.dart';
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
      '/': (route) => const IndexedPage(
            child: AdminPage(),
            paths: ['/users', '/warehouses', '/products'],
          ),
      '/users': (route) => const MaterialPage(
            child: UsersPage(),
          ),
      '/warehouses': (route) => const MaterialPage(
            child: WarehousesPage(),
          ),
      '/products': (route) => const MaterialPage(
            child: ProductsPage(),
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
            child: manager_overview_page.OverviewPage(),
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
      '/': (route) => const IndexedPage(
            child: DirectorPage(),
            paths: [
              '/overview',
              '/suppliers',
              '/contracts',
              '/supplies',
              '/applications',
              '/statistics',
            ],
          ),
      '/overview': (route) => const MaterialPage(
            child: director_overview_page.OverviewPage(),
          ),
      '/overview/expiringContracts': (route) => const MaterialPage(
            child: ExpiringContractsPage(),
          ),
      '/suppliers': (route) {
        return const MaterialPage(
          child: SuppliersPage(),
        );
      },
      '/contracts': (route) => const MaterialPage(
            child: ContractsPage(),
          ),
      '/contracts/add': (route) => const MaterialPage(
            child: AddNewContractPage(),
          ),
      '/supplies': (route) => const MaterialPage(
            child: SuppliesPage(),
          ),
      '/supplies/add': (route) => const MaterialPage(
            child: AddNewSupplyPage(),
          ),
      '/applications': (route) => const MaterialPage(
            child: ApplicationsPage(),
          ),
      '/statistics': (route) => const MaterialPage(
            child: StatisticsPage(),
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
