import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/userapi_service.dart';

class UserState with ChangeNotifier {
  UserModel? _user;
  final UserApiService userApiService;
  bool _isAuthenticated = false;

  UserState({required this.userApiService});

  UserModel? get user => _user;
  bool get isAuthenticated => _isAuthenticated;

  Future<bool> phoneNumberSend(String phoneNumber) async {
    return await userApiService.phoneNumberSend(phoneNumber);
  }

  Future<bool> loginPhoneNumber(String phoneNumber, String verifyCode) async {
    return await userApiService.loginPhoneNumber(phoneNumber, verifyCode);
  }

  Future<bool> saveName(String name) async {
    return await userApiService.saveName(name);
  }

  Future<void> login(String email, String password) async {
    _user = await userApiService.login(email, password);
    if (_user?.id != 0) {
      _isAuthenticated = true;
    }
    notifyListeners();
  }

  Future<bool> register(String email) async {
    try {
      await userApiService.register(email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await userApiService.logout();
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    _isAuthenticated = await userApiService.isAuthenticated();
    notifyListeners();
  }

  Future<void> scheduleTokenRefresh() async {
    userApiService.scheduleTokenRefresh();
  }
}
