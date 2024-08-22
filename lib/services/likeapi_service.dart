import 'dart:convert';
import 'package:drone/models/like_model.dart';
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

  Future<bool> skipSwipe() async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/like/skip_swipe'),
      body: jsonEncode(<String, String>{
        'userId': userId.toString(),
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

  Future<bool> sendMessageLike(int id, String text) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/like/send_messagelike'),
      body: jsonEncode(<String, String>{
        'userId': userId.toString(),
        'receivedId': id.toString(),
        'text': text
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

  Future<List<LikeModel>> getLikeList() async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/like/get_likelist?userId=$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<LikeModel> array = [];
      var reasponsData = jsonDecode(response.body);
      for(var singleItem in reasponsData){
        List<String> avatars = (singleItem["avatars"] as List).map((avatar) => avatar.toString()).toList();
        LikeModel item = LikeModel(singleItem["id"], singleItem["name"], singleItem["description"], singleItem["prefectureId"], singleItem["age"], avatars, singleItem["verify"], singleItem["favouriteText"], singleItem["favouriteImage"]);
        array.add(item);
      }
      return array;
    } else {
      return [];
    }
  }

  Future<bool> skipLike(int senderId) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/like/skip_like'),
      body: jsonEncode(<String, String>{
        'receivedId': userId.toString(),
        'userId': senderId.toString()
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

  Future<bool> createMatching(int matchedUserId) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/like/create_matching'),
      body: jsonEncode(<String, String>{
        'userId': userId.toString(),
        'matchedUserId': matchedUserId.toString()
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
