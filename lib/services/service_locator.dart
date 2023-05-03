import 'package:diploma_frontend/repositories/auth_repository/auth_repository.dart';
import 'package:diploma_frontend/repositories/product_repository/product_repository.dart';
import 'package:diploma_frontend/repositories/warehouse_repository/warehouse_repository.dart';
import 'package:diploma_frontend/services/app_state_service/app_state_service.dart';
import 'package:diploma_frontend/services/bloc_service/bloc_service.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:diploma_frontend/services/language_service/language_service.dart';
import 'package:diploma_frontend/services/route_service/route_service.dart';

class ServiceLocator {
  // Repositories
  static AuthRepository authRepository = AuthRepository();
  static ProductRepository productRepository = ProductRepository(database);
  static WarehouseRepository warehouseRepository =
      WarehouseRepository(database);

  // Services
  static AppStateService appStateService = AppStateService(database);
  static BlocService blocService = BlocService();
  static Database database = Database();
  static LanguageService languageService = LanguageService();
  static RouteService routeService = RouteService();
}
