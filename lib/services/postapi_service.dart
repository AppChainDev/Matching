import 'dart:convert';
import 'dart:io';
import 'package:drone/models/post_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PostApiService {
  final String baseUrl;
  final storage = const FlutterSecureStorage();
  
  PostApiService({required this.baseUrl});

  // Example of a login function
  Future<bool> createPost(File avatar, String description) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final url = Uri.parse('$baseUrl/api/upload/create_post');
    final imageUploadRequest = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $accessToken'
      ..fields['userId'] = userId!
      ..fields['description'] = description
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        avatar.path,
      ));
    final response = await imageUploadRequest.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PostModel>> getMyPost() async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/posts/get_mypost?userId=$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<PostModel> array = [];
      var reasonData = jsonDecode(response.body);
      for(var singleItem in reasonData){
        PostModel item = PostModel(singleItem["id"], singleItem["userId"], singleItem["name"], singleItem["description"], singleItem["prefectureId"], singleItem["age"], singleItem["avatar"], singleItem["backImage"], singleItem["messageCount"]);
        array.add(item);
      }
      return array;
    } else {
      return [];
    }
  }

  Future<List<PostModel>> getPosts() async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/posts/get_posts?userId=$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<PostModel> array = [];
      var reasonData = jsonDecode(response.body);
      for(var singleItem in reasonData){
        PostModel item = PostModel(singleItem["id"], singleItem["userId"], singleItem["name"], singleItem["description"], singleItem["prefectureId"], singleItem["age"], singleItem["avatar"], singleItem["backImage"], singleItem["messageCount"]);
        array.add(item);
      }
      return array;
    } else {
      return [];
    }
  }

  
}