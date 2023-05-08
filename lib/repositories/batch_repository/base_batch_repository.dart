import 'package:diploma_frontend/models/batch.dart';

abstract class BaseBatchRepository {
  Future<List<Batch>?> forStock({required int id});
}
