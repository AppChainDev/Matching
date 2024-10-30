import 'dart:io';

import 'package:rinlin/models/advicestate_model.dart';
import 'package:rinlin/models/category_model.dart';
import 'package:rinlin/models/community_model.dart';
import 'package:rinlin/models/like_model.dart';
import 'package:rinlin/models/member_model.dart';
import 'package:rinlin/models/phrase_model.dart';
import 'package:rinlin/models/swipegroup_model.dart';
import 'package:rinlin/models/user.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/userapi_service.dart';

class UserState with ChangeNotifier {
  UserModel? _user;
  UserModel? _userById;
  List<LikeModel> _users = [];
  List<PhraseModel> _phrase = [];
  final UserApiService userApiService;
  bool _isAuthenticated = false;
  List<CommunityModel> _groups = [];
  List<SwipeGroupModel> _topGroups = [];
  List<SwipeGroupModel> _allSwipeGroups = [];
  List<Category> _categories = [];
  List<MemberModel> _groupUsers = [];
  List<LikeModel> _swipeSearchUsers = [];
  List<MemberModel> _groupSearchUsers = [];
  List<User> _matchedUserList = [];
  AdviceStateModel? _adviceState;

  UserState({required this.userApiService});

  UserModel? get user => _user;
  UserModel? get userById => _userById;
  List<LikeModel> get users => _users;
  List<PhraseModel> get phrase => _phrase;
  bool get isAuthenticated => _isAuthenticated;
  List<CommunityModel> get groups => _groups;
  List<SwipeGroupModel> get topGroups => _topGroups;
  List<SwipeGroupModel> get allSwipeGroups => _allSwipeGroups;
  List<Category> get categories => _categories;
  List<MemberModel> get groupUsers => _groupUsers;
  List<LikeModel> get swipeSearchUsers => _swipeSearchUsers;
  List<MemberModel> get groupSearchUsers => _groupSearchUsers;
  List<User> get matchedUserList => _matchedUserList;
  AdviceStateModel? get adviceState => _adviceState;

  Future<bool> phoneNumberSend(String phoneNumber) async {
    return await userApiService.phoneNumberSend(phoneNumber);
  }

  Future<bool> loginPhoneNumber(String phoneNumber, String verifyCode) async {
    return await userApiService.loginPhoneNumber(phoneNumber, verifyCode);
  }

  Future<bool> loginWithGoogle(String displayName, String email) async {
    return await userApiService.loginWithGoogle(displayName, email);
  }

  Future<bool> loginWithLine(String? lineId, String? displayName) async {
    if (lineId != null && displayName != null) {
      return await userApiService.loginWithLine(lineId, displayName);
    } else {
      return false;
    }
  }

  Future<bool> saveOnesignalId(String onesignalId) async {
    return await userApiService.saveOnesignalId(onesignalId);
  }

  Future<bool> saveName(String name) async {
    return await userApiService.saveName(name);
  }

  Future<bool> saveAge(int age) async {
    return await userApiService.saveAge(age);
  }

  Future<bool> saveFirstStep(int gender, int prefectureId, int height,
      int bodyType, int attitude) async {
    return await userApiService.saveFirstStep(
        gender, prefectureId, height, bodyType, attitude);
  }

  Future<bool> saveSecondStep(
      int blood,
      int birth,
      int education,
      int jobType,
      int maritalHistory,
      int income,
      int children,
      int housework,
      int hopeMeet,
      int dateCost) async {
    return await userApiService.saveSecondStep(blood, birth, education, jobType,
        maritalHistory, income, children, housework, hopeMeet, dateCost);
  }

  Future<bool> saveAvatar1(File avatar) async {
    return await userApiService.saveAvatar1(avatar);
  }

  Future<void> saveAvatar(File avatar, int index) async {
    final result = await userApiService.saveAvatar(avatar, index);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> getGroupList() async {
    _groups = await userApiService.getGroupList();
    notifyListeners();
  }

  Future<void> getTopGroups() async {
    _topGroups = await userApiService.getTopGroups();
    notifyListeners();
  }

  Future<void> getSwipeAllGroups() async {
    _allSwipeGroups = await userApiService.getSwipeAllGroups();
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

  Future<bool> saveQuestionAnswer(String answer, int index) async {
    return await userApiService.saveQuestionAnswer(answer, index);
  }

  Future<void> saveFavoriteImage(File image) async {
    final result = await userApiService.saveFavoriteImage(image);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<bool> saveFavoriteDescription(String description) async {
    return await userApiService.saveFavoriteDescription(description);
  }

  Future<void> updatePrefecture(int prefectureId) async {
    final result = await userApiService.updatePrefecture(prefectureId);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateHeight(int height) async {
    final result = await userApiService.updateHeight(height);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateBodyType(int bodyType) async {
    final result = await userApiService.updateBodyType(bodyType);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateBlood(int blood) async {
    final result = await userApiService.updateBlood(blood);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateBirth(int birth) async {
    final result = await userApiService.updateBirth(birth);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateEducation(int education) async {
    final result = await userApiService.updateEducation(education);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateJobType(int jobType) async {
    final result = await userApiService.updateJobType(jobType);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateIncome(int income) async {
    final result = await userApiService.updateIncome(income);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateMaritalHistory(int maritalHistory) async {
    final result = await userApiService.updateMaritalHistory(maritalHistory);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateAttitude(int attitude) async {
    final result = await userApiService.updateAttitude(attitude);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateChildren(int children) async {
    final result = await userApiService.updateChildren(children);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateHousework(int housework) async {
    final result = await userApiService.updateHousework(housework);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateHopeMeet(int hopeMeet) async {
    final result = await userApiService.updateHopeMeet(hopeMeet);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateDateCost(int dateCost) async {
    final result = await userApiService.updateDateCost(dateCost);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateHoliday(int holiday) async {
    final result = await userApiService.updateHoliday(holiday);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateRoomate(int roomate) async {
    final result = await userApiService.updateRoomate(roomate);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateAlcohol(int alcohol) async {
    final result = await userApiService.updateAlcohol(alcohol);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateSmoking(int smoking) async {
    final result = await userApiService.updateSmoking(smoking);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<void> updateSaving(int saving) async {
    final result = await userApiService.updateSaving(saving);
    if (result) {
      getUserInformation();
      notifyListeners();
    }
  }

  Future<bool> removeGroups(List<int> removeGroups) async {
    final result = await userApiService.removeGroups(removeGroups);
    if (result) {
      return true;
    } else {
      return false;
    }
  }

  Future getGroupUsers(int groupId) async {
    _groupUsers = await userApiService.getGroupUsers(groupId);
    notifyListeners();
  }

  Future<bool> checkMember(int groupId) async {
    return await userApiService.checkMember(groupId);
  }

  Future<bool> enterGroup(int groupId) async {
    return await userApiService.enterGroup(groupId);
  }

  Future<void> searchSwipeUser(
      int minAge,
      int maxAge,
      int minHeigth,
      int maxHeight,
      List<int> prefectureIds,
      List<int> bodyTypes,
      List<int> maritalHistories,
      List<int> attitudes) async {
    _swipeSearchUsers = await userApiService.searchSwipeUser(
        minAge,
        maxAge,
        minHeigth,
        maxHeight,
        prefectureIds,
        bodyTypes,
        maritalHistories,
        attitudes);
    notifyListeners();
  }

  Future<void> searchGroupUser(
      int groupId,
      int minAge,
      int maxAge,
      int minHeigth,
      int maxHeight,
      List<int> prefectureIds,
      List<int> bodyTypes,
      List<int> maritalHistories,
      List<int> attitudes) async {
    _groupSearchUsers = await userApiService.searchGroupUser(
        groupId,
        minAge,
        maxAge,
        minHeigth,
        maxHeight,
        prefectureIds,
        bodyTypes,
        maritalHistories,
        attitudes);
    notifyListeners();
  }

  Future<void> getMatchedUserList() async {
    _matchedUserList = await userApiService.getMatchedUserList();
    notifyListeners();
  }

  Future<void> getPhrase() async {
    _phrase = await userApiService.getPhrase();
    notifyListeners();
  }

  Future<bool> updatePhrase(int id, String text) async {
    return await userApiService.updatePhrase(id, text);
  }

  Future<bool> sendAdviceRequest(int id) async {
    return await userApiService.sendAdviceRequest(id);
  }

  Future<void> getAdviceState(int id) async {
    _adviceState = await userApiService.getAdviceState(id);
  }

  Future<bool> sendVerifyCard(File image, String verifyType) async {
    return await userApiService.sendVerifyCard(image, verifyType);
  }

  Future<String?> getVerifyState() async {
    return await userApiService.getVerifyState();
  }

  Future<bool> verifyChecked() async {
    return await userApiService.verifyChecked();
  }

  Future<void> clearViewUsers() async {
    await userApiService.clearViewUsers();
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

  Future<bool> deleteAccount() async {
    return await userApiService.deleteAccount();
  }

  Future<bool> setIsRegisterd() async {
    return await userApiService.setIsRegisterd();
  }
  Future<bool> getIsRegistered() async {
    return await userApiService.getIsRegisterd();
  }

  // Future<void> checkAuthStatus() async {
  //   _isAuthenticated = await userApiService.isAuthenticated();
  //   notifyListeners();
  // }

  // Future<void> scheduleTokenRefresh() async {
  //   userApiService.scheduleTokenRefresh();
  // }
}
