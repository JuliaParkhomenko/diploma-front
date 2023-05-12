import 'package:diploma_frontend/models/batch.dart';

abstract class BaseBatchRepository {
  Future<List<Batch>?> forStock({required int id});

  Future<int?> receiveBatch({
    required int batchId,
    required DateTime productionTime,
    required DateTime expirationTime,
    required int notificationDate,
  });

  Future<Batch?> getBatch({required int id});
  Future<void> useBatch({required int id, required int amount});
  Future<void> writeOffAll({required int id});
}
