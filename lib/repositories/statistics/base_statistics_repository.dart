import 'package:diploma_frontend/models/statistics.dart';

abstract class BaseStatisticsRepository {
  Future<Statistics?> product({
    int? warehouseId,
    int? productId,
    DateTime? dateFrom,
    DateTime? dateTo,
    bool? ordered,
    bool? used,
    bool? writtenOff,
  });
}
