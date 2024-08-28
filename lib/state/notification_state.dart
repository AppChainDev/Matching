
import 'package:rinlin/models/notification_model.dart';
import 'package:rinlin/services/notificationapi_service.dart';
import 'package:flutter/material.dart';

class NotificationState with ChangeNotifier {
  final NotificationApiService notificationApiService;
  List<NotificationModel> _notifications = [];

  NotificationState({required this.notificationApiService});

  List<NotificationModel> get notifications => _notifications;

  Future<void> getNotifications() async {
    _notifications = await notificationApiService.getNotifications();
    notifyListeners();
  }
  Future<void> addUserToNotification(int id) async {
    await notificationApiService.addUserToNotification(id);
  }
  
}
