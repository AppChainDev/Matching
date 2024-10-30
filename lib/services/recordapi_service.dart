import 'dart:convert';
import 'package:rinlin/models/record_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RecordApiService {
  final String baseUrl;
  final storage = const FlutterSecureStorage();
  
  RecordApiService({required this.baseUrl});

  // Example of a login function
  Future<bool> saveRecord(int id) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/records/save_record'),
      body: jsonEncode(<String, String>{
        'userId': id.toString(),
        'visiterId': userId.toString()
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<RecordModel>> getRecord() async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/records/get_record?userId=$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<RecordModel> array = [];
      var reasonData = jsonDecode(response.body);
      for(var singleItem in reasonData){
        RecordModel item = RecordModel(id: singleItem["id"], avatar: singleItem["avatar"], name: singleItem["name"], age: singleItem["age"], prefectureId: singleItem["prefectureId"]);
        array.add(item);
      }
      return array;
    } else {
      return [];
    }
  }
  
}
