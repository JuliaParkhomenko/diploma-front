import 'package:diploma_frontend/models/batch.dart';
import 'package:diploma_frontend/models/batch_supply.dart';
import 'package:diploma_frontend/models/expiring_batch.dart';
import 'package:diploma_frontend/models/ordered_batch.dart';

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
  Future<List<OrderedBatch>?> orderedBatches({
    required int warehouseId,
    required String productName,
    required String batchId,
    required String kind,
  });

  Future<List<ExpiringBatch>?> expiringBatches({
    required int warehouseId,
    required int amount,
  });

  Future<List<BatchSupply>?> getSupplies({
    String productName = '',
    String warehouseName = '',
  });
}
