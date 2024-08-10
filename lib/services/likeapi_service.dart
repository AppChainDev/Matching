import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LikeApiService {
  final String baseUrl;
  final storage = const FlutterSecureStorage();
  
  LikeApiService({required this.baseUrl});

  // Example of a login function
  Future<bool> sendLike(int id) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/like/send_like'),
      body: jsonEncode(<String, String>{
        'userId': userId.toString(),
        'receivedId': id.toString()
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
