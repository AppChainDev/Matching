import 'dart:io';

import 'package:drone/models/category_model.dart';
import 'package:drone/models/community_model.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/userapi_service.dart';

class UserState with ChangeNotifier {
  UserModel? _user;
  final UserApiService userApiService;
  bool _isAuthenticated = false;
  List<CommunityModel> _groups = [];
  List<Category> _categories = [];

  UserState({required this.userApiService});

  UserModel? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  List<CommunityModel> get groups => _groups;
  List<Category> get categories => _categories;

  Future<bool> phoneNumberSend(String phoneNumber) async {
    return await userApiService.phoneNumberSend(phoneNumber);
  }

  Future<bool> loginPhoneNumber(String phoneNumber, String verifyCode) async {
    return await userApiService.loginPhoneNumber(phoneNumber, verifyCode);
  }

  Future<bool> saveName(String name) async {
    return await userApiService.saveName(name);
  }

  Future<bool> saveAge(int age) async {
    return await userApiService.saveAge(age);
  }

  Future<bool> saveFirstStep(int gender, int prefectureId, int height, int bodyType, int attitude) async {
    return await userApiService.saveFirstStep(gender, prefectureId, height, bodyType, attitude);
  }

  Future<bool> saveSecondStep(int blood, int birth, int education, int jobType, int maritalHistory, int income, int children, int housework, int hopeMeet, int dateCost) async {
    return await userApiService.saveSecondStep(blood, birth, education, jobType, maritalHistory, income, children, housework, hopeMeet, dateCost);
  }

  Future<bool> saveAvatar1(File avatar) async {
    return await userApiService.saveAvatar1(avatar);
  }

  Future<void> getGroupList() async {
    _groups = await userApiService.getGroupList();
    notifyListeners();
  }

  Future<void> getCategoryList() async {
    _categories = await userApiService.getCategoryList();
    notifyListeners();
  }
  Future<bool> saveGroups(List<int> groups) async {
    return await userApiService.saveGroups(groups);
  }

  Future<bool> saveIntroduce(String introduce) async {
    return await userApiService.saveIntroduce(introduce);
  }

  Future<void> getUserInformation() async {
    _user = await userApiService.getUserInformation();
    notifyListeners();
  }


  // Future<void> login(String email, String password) async {
  //   _user = await userApiService.login(email, password);
  //   if (_user?.id != 0) {
  //     _isAuthenticated = true;
  //   }
  //   notifyListeners();
  // }

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
