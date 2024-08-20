import 'dart:convert';
import 'package:drone/models/notification_model.dart';
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
        NotificationModel item = NotificationModel(singleItem["id"], singleItem["title"], singleItem["content"]);
        array.add(item);
      }
      return array;
    } else {
      return [];
    }
  }
}
