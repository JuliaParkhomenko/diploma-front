import 'dart:convert';
import 'dart:developer';
import 'package:diploma_frontend/models/batch.dart';
import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/repositories/batch_repository/base_batch_repository.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:http/http.dart' as http;

class BatchRepository implements BaseBatchRepository {
  final Database _database;
  BatchRepository(this._database);
  @override
  Future<List<Batch>?> forStock({
    required int id,
    String batchId = '',
    String kind = '',
    String maker = '',
    String status = '',
  }) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Batch/forStock?stockId=$id&batchId=$batchId&kind=$kind&maker=$maker&status=$status',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<Batch>((e) {
          return Batch.fromJson(e);
        }).toList();
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
