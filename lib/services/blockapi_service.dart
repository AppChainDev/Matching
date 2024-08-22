import 'dart:convert';
import 'package:drone/models/block_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class BlockApiService {
  final String baseUrl;
  final storage = const FlutterSecureStorage();
  
  BlockApiService({required this.baseUrl});

  // Example of a login function
  Future<List<BlockModel>> getBlockList() async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/block/get_blocklist?userId=$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<BlockModel> array = [];
      var reasponsData = jsonDecode(response.body);
      for(var singleItem in reasponsData){
        BlockModel item = BlockModel(id: singleItem["id"], avatar: singleItem["avatar"], name: singleItem["name"], age: singleItem["age"], prefectureId: singleItem["prefectureId"]);
        array.add(item);
      }
      return array;
    } else {
      return [];
    }
  }

  Future<bool> removeBlock(int id) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.delete(
      Uri.parse('$baseUrl/api/block/remove_block'),
      body: jsonEncode(<String, String>{
        'userId': userId!,
        'blockedUserId': id.toString()
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

  Future<bool> addBlock(int id) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/block/add_block'),
      body: jsonEncode(<String, String>{
        'userId': userId!,
        'blockUserId': id.toString()
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

  Future<bool> addReport(int id) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/block/add_report'),
      body: jsonEncode(<String, String>{
        'reporterId': userId!,
        'violatorId': id.toString()
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
}
