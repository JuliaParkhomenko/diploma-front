import 'package:diploma_frontend/models/optimization.dart';
import 'package:diploma_frontend/models/requests/opt_request.dart';
import 'package:diploma_frontend/models/statistics.dart';

abstract class BaseStatisticsRepository {
  Future<List<Statistics>?> product({required int warehouseId});

  Future<List<Optimization>?> optimization({
    required List<OptRequest> opt,
  });
}
