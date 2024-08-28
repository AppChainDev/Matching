import 'dart:convert';
import 'package:rinlin/models/notification_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class NotificationApiService {
  final String baseUrl;
  final storage = const FlutterSecureStorage();
  
  NotificationApiService({required this.baseUrl});

  // Example of a login function
  Future<List<NotificationModel>> getNotifications() async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/notifications/get_notifications?userId=$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<NotificationModel> array = [];
      var reasponsData = jsonDecode(response.body);
      for(var singleItem in reasponsData){
        List<int> usersArray = (singleItem["usersArray"] as List).map((user) => int.parse(user.toString())).toList();
        NotificationModel item = NotificationModel(singleItem["id"], singleItem["title"], singleItem["content"], usersArray);
        array.add(item);
      }
      return array;
    } else {
      return [];
    }
  }
  Future<void> addUserToNotification(int id) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    await http.post(
      Uri.parse('$baseUrl/api/notifications/adduser'),
      body: jsonEncode(<String, String>{
        'userId': userId!,
        'notificationId': id.toString()
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
  }
}
