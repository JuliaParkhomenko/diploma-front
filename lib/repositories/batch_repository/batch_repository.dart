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

  @override
  Future<int?> receiveBatch({
    required int batchId,
    required DateTime productionTime,
    required DateTime expirationTime,
    required int notificationDate,
  }) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Batch/receive',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final body = jsonEncode({
        'batchId': batchId,
        'productionDate': productionTime.toString(),
        'expirationDate': expirationTime.toString(),
        'notificationDate': notificationDate,
      });

      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['id'];
      }

      return null;
    } catch (_) {
      log(_.toString());
      return null;
    }
  }

  @override
  Future<Batch?> getBatch({required int id}) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Batch?batchId=$id',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Batch.fromJson(data);
      }

      return null;
    } catch (_) {
      log(_.toString());
      return null;
    }
  }

  @override
  Future<void> useBatch({required int id, required int amount}) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Batch/use',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      final body = jsonEncode({'batchId': id, 'amount': amount});

      await http.post(url, headers: headers, body: body);
    } catch (_) {
      log(_.toString());
    }
  }

  @override
  Future<void> writeOffAll({required int id}) async {
    try {
      final User? user = await _database.getUser();

      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Batch/writeOff?batchId=$id',
      );

      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };

      await http.get(url, headers: headers);
    } catch (_) {
      log(_.toString());
    }
  }
}
