import 'package:diploma_frontend/repositories/auth_repository/auth_repository.dart';
import 'package:diploma_frontend/repositories/batch_repository/batch_repository.dart';
import 'package:diploma_frontend/repositories/product_repository/product_repository.dart';
import 'package:diploma_frontend/repositories/statistics/statistics_repository.dart';
import 'package:diploma_frontend/repositories/supplier_repository/supplier_repository.dart';
import 'package:diploma_frontend/repositories/warehouse_repository/warehouse_repository.dart';
import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:diploma_frontend/services/bloc_service/bloc_service.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:diploma_frontend/services/language_service/language_service.dart';
import 'package:diploma_frontend/services/route_service/route_service.dart';
import 'package:diploma_frontend/validators/edit_supplier_validator.dart';
import 'package:diploma_frontend/validators/sign_in_validator.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static void setupLocators() {
    final GetIt locator = GetIt.instance;

    locator.registerSingleton<AuthRepository>(
      AuthRepository(),
    );

    locator.registerSingleton<Database>(Database());

    locator.registerSingleton<RouteService>(RouteService());

    locator.registerSingleton<BlocService>(BlocService());

    locator.registerSingleton<ProductRepository>(
      ProductRepository(
        GetIt.instance<Database>(),
      ),
    );

    locator.registerSingleton<WarehouseRepository>(
      WarehouseRepository(
        GetIt.instance<Database>(),
      ),
    );

    locator.registerSingleton<BatchRepository>(
      BatchRepository(
        GetIt.instance<Database>(),
      ),
    );

    locator.registerSingleton<SupplierRepository>(
      SupplierRepository(
        GetIt.instance<Database>(),
      ),
    );

    locator.registerSingleton<StatisticsRepository>(
      StatisticsRepository(
        GetIt.instance<Database>(),
      ),
    );

    locator.registerSingleton<AppStateService>(
      AppStateService(
        GetIt.instance<Database>(),
      ),
    );

    locator.registerSingletonAsync<LanguageService>(() async {
      final LanguageService service = LanguageService();
      await service.init();
      return service;
    });

    locator.registerSingleton<SignInValidator>(SignInValidator());

    locator.registerSingleton<EditSupplierValidator>(EditSupplierValidator());
  }

  // Repositories
  static AuthRepository get authRepository => GetIt.instance<AuthRepository>();
  static ProductRepository get productRepository =>
      GetIt.instance<ProductRepository>();
  static WarehouseRepository get warehouseRepository =>
      GetIt.instance<WarehouseRepository>();
  static BatchRepository get batchRepository =>
      GetIt.instance<BatchRepository>();
  static SupplierRepository get supplierRepository =>
      GetIt.instance<SupplierRepository>();
  static StatisticsRepository get statisticsRepository =>
      GetIt.instance<StatisticsRepository>();

  // Services
  static AppStateService get appStateService =>
      GetIt.instance<AppStateService>();
  static BlocService get blocService => GetIt.instance<BlocService>();
  static Database get database => GetIt.instance<Database>();
  static LanguageService get languageService =>
      GetIt.instance<LanguageService>();
  static RouteService get routeService => GetIt.instance<RouteService>();
}
