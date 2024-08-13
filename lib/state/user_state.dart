import 'dart:io';

import 'package:drone/models/category_model.dart';
import 'package:drone/models/community_model.dart';
import 'package:drone/models/like_model.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/userapi_service.dart';

class UserState with ChangeNotifier {
  UserModel? _user;
  UserModel? _userById;
  List<LikeModel> _users = [];
  final UserApiService userApiService;
  bool _isAuthenticated = false;
  List<CommunityModel> _groups = [];
  List<Category> _categories = [];

  UserState({required this.userApiService});

  UserModel? get user => _user;
  UserModel? get userById => _userById;
  List<LikeModel> get users => _users;
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
  Future<void> saveAvatar(File avatar, int index) async {
    final result =  await userApiService.saveAvatar(avatar, index);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
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
  Future<void> getUserById(int userId) async {
    _userById = await userApiService.getUserById(userId);
    notifyListeners();
  }
  Future<void> getUsers() async {
    _users = await userApiService.getUsers();
    notifyListeners();
  }

  Future<bool> saveQuestionAnswer(String answer, int index) async{
    return await userApiService.saveQuestionAnswer(answer, index);
  }
  Future<void> saveFavoriteImage(File image) async {
    final result =  await userApiService.saveFavoriteImage(image);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<bool> saveFavoriteDescription(String description) async{
    return await userApiService.saveFavoriteDescription(description);
  }
  Future<void> updatePrefecture(int prefectureId) async{
    final result = await userApiService.updatePrefecture(prefectureId);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateHeight(int height) async{
    final result = await userApiService.updateHeight(height);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateBodyType(int bodyType) async{
    final result = await userApiService.updateBodyType(bodyType);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateBlood(int blood) async{
    final result = await userApiService.updateBlood(blood);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateBirth(int birth) async{
    final result = await userApiService.updateBirth(birth);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateEducation(int education) async{
    final result = await userApiService.updateEducation(education);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateJobType(int jobType) async{
    final result = await userApiService.updateJobType(jobType);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateIncome(int income) async{
    final result = await userApiService.updateIncome(income);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateMaritalHistory(int maritalHistory) async{
    final result = await userApiService.updateMaritalHistory(maritalHistory);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateAttitude(int attitude) async{
    final result = await userApiService.updateAttitude(attitude);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateChildren(int children) async{
    final result = await userApiService.updateChildren(children);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateHousework(int housework) async{
    final result = await userApiService.updateHousework(housework);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateHopeMeet(int hopeMeet) async{
    final result = await userApiService.updateHopeMeet(hopeMeet);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateDateCost(int dateCost) async{
    final result = await userApiService.updateDateCost(dateCost);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateHoliday(int holiday) async{
    final result = await userApiService.updateHoliday(holiday);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateRoomate(int roomate) async{
    final result = await userApiService.updateRoomate(roomate);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateAlcohol(int alcohol) async{
    final result = await userApiService.updateAlcohol(alcohol);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateSmoking(int smoking) async{
    final result = await userApiService.updateSmoking(smoking);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }
  Future<void> updateSaving(int saving) async{
    final result = await userApiService.updateSaving(saving);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<bool> removeGroups(List<int> removeGroups) async{
    final result = await userApiService.removeGroups(removeGroups);
    if (result) {
      return true;
    } else {
      return false;
    }
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

  skipSwipe() {}
}
