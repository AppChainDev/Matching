import 'dart:convert';
import 'dart:io';
import 'package:drone/models/advicestate_model.dart';
import 'package:drone/models/category_model.dart';
import 'package:drone/models/community_model.dart';
import 'package:drone/models/like_model.dart';
import 'package:drone/models/member_model.dart';
import 'package:drone/models/phrase_model.dart';
import 'package:drone/models/swipegroup_model.dart';
import 'package:drone/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../models/user_model.dart';

class UserApiService {
  final String baseUrl;
  final storage = const FlutterSecureStorage();
  
  UserApiService({required this.baseUrl});

  // Example of a login function
  Future<bool> phoneNumberSend(String phoneNumber) async{
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/phone_register'),
      body: jsonEncode(<String, String>{
        'phone_number': phoneNumber
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> loginPhoneNumber(String phoneNumber, String verifyCode) async{
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/phone_login'),
      body: jsonEncode(<String, String>{
        'phone_number': phoneNumber,
        'verify_code': verifyCode
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int userId = data['id'];
      int? gender = data['gender'];
      String accessToken = data['accessToken'];
      String refreshToken = data['refreshToken'];
      await storage.write(key: 'userId', value: jsonEncode(userId));
      if (gender != null) {
        await storage.write(key: 'gender', value: gender.toString()); 
      }
      await storage.write(key: 'accessToken', value: accessToken);
      await storage.write(key: 'refreshToken', value: refreshToken);
      return true;
    } else {
      return false;
    }
  }
  Future<bool> saveName(String name) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/save_name'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'name': name,
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
  Future<bool> saveAge(int age) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/save_age'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'age': age.toString(),
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
  Future<bool> saveFirstStep(int gender, int prefectureId, int height, int bodyType, int attitude) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/save_firststep'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'gender': gender.toString(),
        'prefectureId': prefectureId.toString(),
        'height': height.toString(),
        'bodyType': bodyType.toString(),
        'attitude': attitude.toString(),
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      await storage.write(key: 'gender', value: gender.toString());
      return true;
    } else {
      return false;
    }
  }
  Future<bool> saveSecondStep(int blood, int birth, int education, int jobType, int maritalHistory, int income, int children, int housework, int hopeMeet, int dateCost) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/save_secondstep'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'blood': blood.toString(),
        'birth': birth.toString(),
        'education': education.toString(),
        'jobType': jobType.toString(),
        'maritalHistory': maritalHistory.toString(),
        'income': income.toString(),
        'children': children.toString(),
        'housework': housework.toString(),
        'hopeMeet': hopeMeet.toString(),
        'dateCost': dateCost.toString()
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
  Future<bool> saveAvatar1(File avatar) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final url = Uri.parse('$baseUrl/api/upload/add_mainavatar');
    final imageUploadRequest = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $accessToken'
      ..fields['userId'] = userId!
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
  Future<bool> saveAvatar(File avatar, int index) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final url = Uri.parse('$baseUrl/api/upload/addavatar');
    final imageUploadRequest = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $accessToken'
      ..fields['userId'] = userId!
      ..fields['index'] = index.toString()
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
  Future<List<CommunityModel>> getGroupList() async{
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/groups/getallgroups'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      List<CommunityModel> array = [];
      var reasonData = jsonDecode(response.body);
      for(var singleItem in reasonData){
        CommunityModel item = CommunityModel(id: singleItem["id"], name: singleItem["name"], image: singleItem["image"], members: singleItem["members"], categoryId: singleItem["categoryId"]);
        array.add(item);
      }
      return array;
    }else{
      return [];
    }
  }
  Future<List<Category>> getCategoryList() async{
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/groups/getallcategories'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      List<Category> array = [];
      var reasonData = jsonDecode(response.body);
      for(var singleItem in reasonData){
        Category item = Category(id: singleItem["id"], label: singleItem["name"]);
        array.add(item);
      }
      return array;
    }else{
      return [];
    }
  }

  Future<List<SwipeGroupModel>> getTopGroups() async{
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/groups/get_topgroups'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      List<SwipeGroupModel> array = [];
      var reasonData = jsonDecode(response.body);
      for(var singleItem in reasonData){
        SwipeGroupModel item = SwipeGroupModel(id: singleItem["id"], name: singleItem["name"], members: singleItem["members"], thumbnail: singleItem["thumbnail"], categoryId: singleItem["categoryId"]);
        array.add(item);
      }
      return array;
    }else{
      return [];
    }
  }

  Future<List<SwipeGroupModel>> getSwipeAllGroups() async{
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/groups/get_allswipegroups'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      List<SwipeGroupModel> array = [];
      var reasonData = jsonDecode(response.body);
      for(var singleItem in reasonData){
        SwipeGroupModel item = SwipeGroupModel(id: singleItem["id"], name: singleItem["name"], members: singleItem["members"], thumbnail: singleItem["thumbnail"], categoryId: singleItem["categoryId"]);
        array.add(item);
      }
      return array;
    }else{
      return [];
    }
  }

  Future<bool> saveGroups(List<int> groups) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/groups/save_groups'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'groups': jsonEncode(groups)
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
  Future<bool> saveIntroduce(String introduce) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/save_introduce'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'introduce': introduce
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
  Future<UserModel> getUserInformation() async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/auth/getuser?userId=$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      var responseData = jsonDecode(response.body);
      List<String> avatars = (responseData["avatars"] as List).map((avatar) => avatar.toString()).toList();
      List<int> groups = (responseData["groups"] as List).map((group) => int.parse(group.toString())).toList();
      List<String> questions = (responseData["questions"] as List).map((question) => question.toString()).toList();
      List<String> phrases = (responseData["phrases"] as List).map((phrase) => phrase.toString()).toList();
      return UserModel(
        id: responseData["id"], 
        name: responseData["name"], 
        age: responseData["age"], 
        gender: responseData["gender"], 
        introduce: responseData["introduce"], 
        prefectureId: responseData["prefectureId"], 
        height: responseData["height"], 
        bodyType: responseData["bodyType"], 
        attitude: responseData["attitude"], 
        avatars: avatars, 
        blood: responseData["blood"], 
        birth: responseData["birth"], 
        education: responseData["birth"], 
        jobType: responseData["education"], 
        income: responseData["income"], 
        materialHistory: responseData["materialHistory"], 
        children: responseData["children"], 
        housework: responseData["housework"], 
        hopeMeet: responseData["hopeMeet"], 
        dateCost: responseData["dateCost"], 
        holiday: responseData["holiday"],
        roomate: responseData["roomate"], 
        alcohol: responseData["alcohol"], 
        smoking: responseData["smoking"], 
        saving: responseData["saving"], 
        favoriteImage: responseData["favoriteImage"], 
        favoriteDescription: responseData["favoriteDescription"], 
        groups: groups,
        isVerify: responseData["isVerify"],
        isPay: responseData["isPay"],
        pointCount: responseData["pointCount"], 
        questions: questions, 
        phrases: phrases, 
        deadline: responseData["deadline"], 
        experience: responseData["experience"], 
        createdAt: responseData["createdAt"], 
        updateAt: responseData["updatedAt"]
      );
    }else{
      return UserModel(
        id: 0, 
        name: '', 
        age: 0, 
        gender: 0, 
        introduce: '', 
        prefectureId: 0, 
        height: 0, 
        bodyType: 0, 
        attitude: 0, 
        avatars: [], 
        blood: 0, 
        birth: 0, 
        education: 0, 
        jobType: 0, 
        income: 0, 
        materialHistory: 0, 
        children: 0, 
        housework: 0, 
        hopeMeet: 0, 
        dateCost: 0, 
        holiday: null,
        roomate: null, 
        alcohol: null, 
        smoking: null, 
        saving: null, 
        favoriteImage: '', 
        favoriteDescription: '', 
        groups: [],
        isVerify: false, 
        isPay: false,
        pointCount: 0, 
        questions: null, 
        phrases: [], 
        deadline: '', 
        experience: false, 
        createdAt: '', 
        updateAt: ''
      );
    }
  }

  Future<UserModel> getUserById(int userId) async{
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/auth/getuserById?userId=$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      var responseData = jsonDecode(response.body);
      List<String> avatars = (responseData["avatars"] as List).map((avatar) => avatar.toString()).toList();
      List<int> groups = (responseData["groups"] as List).map((group) => int.parse(group.toString())).toList();
      List<String> questions = (responseData["questions"] as List).map((question) => question.toString()).toList();
      List<String> phrases = (responseData["phrases"] as List).map((phrase) => phrase.toString()).toList();
      return UserModel(
        id: responseData["id"], 
        name: responseData["name"], 
        age: responseData["age"], 
        gender: responseData["gender"], 
        introduce: responseData["introduce"], 
        prefectureId: responseData["prefectureId"], 
        height: responseData["height"], 
        bodyType: responseData["bodyType"], 
        attitude: responseData["attitude"], 
        avatars: avatars, 
        blood: responseData["blood"], 
        birth: responseData["birth"], 
        education: responseData["birth"], 
        jobType: responseData["education"], 
        income: responseData["income"], 
        materialHistory: responseData["materialHistory"], 
        children: responseData["children"], 
        housework: responseData["housework"], 
        hopeMeet: responseData["hopeMeet"], 
        dateCost: responseData["dateCost"], 
        holiday: responseData["holiday"],
        roomate: responseData["roomate"], 
        alcohol: responseData["alcohol"], 
        smoking: responseData["smoking"], 
        saving: responseData["saving"], 
        favoriteImage: responseData["favoriteImage"], 
        favoriteDescription: responseData["favoriteDescription"], 
        groups: groups,
        isVerify: responseData["isVerify"],
        isPay: responseData["isPay"],
        pointCount: responseData["pointCount"], 
        questions: questions, 
        phrases: phrases, 
        deadline: responseData["deadline"], 
        experience: responseData["experience"], 
        createdAt: responseData["createdAt"], 
        updateAt: responseData["updatedAt"]
      );
    }else{
      return UserModel(
        id: 0, 
        name: '', 
        age: 0, 
        gender: 0, 
        introduce: '', 
        prefectureId: 0, 
        height: 0, 
        bodyType: 0, 
        attitude: 0, 
        avatars: [], 
        blood: 0, 
        birth: 0, 
        education: 0, 
        jobType: 0, 
        income: 0, 
        materialHistory: 0, 
        children: 0, 
        housework: 0, 
        hopeMeet: 0, 
        dateCost: 0, 
        holiday: null,
        roomate: null, 
        alcohol: null, 
        smoking: null, 
        saving: null, 
        favoriteImage: '', 
        favoriteDescription: '', 
        groups: [],
        isVerify: false, 
        isPay: false,
        pointCount: 0, 
        questions: null, 
        phrases: [], 
        deadline: '', 
        experience: false,
        createdAt: '', 
        updateAt: ''
      );
    }
  }

  Future<List<LikeModel>> getUsers() async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/auth/get_allusers?userId=$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<LikeModel> array = [];
      var reasonData = jsonDecode(response.body);
      for(var singleItem in reasonData){
        List<String> avatars = (singleItem["avatars"] as List).map((avatar) => avatar.toString()).toList();
        LikeModel item = LikeModel(singleItem["id"], singleItem["name"], singleItem["description"], singleItem["prefectureId"], singleItem["age"], avatars, singleItem["verify"], singleItem["favouriteText"], singleItem["favouriteImage"]);
        array.add(item);
      }
      return array;
    } else {
      return [];
    }
  }

  Future<bool> saveQuestionAnswer(String answer, int index) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/save_answer'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'answer': answer,
        'index': index.toString()
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
  Future<bool> saveFavoriteImage(File image) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final url = Uri.parse('$baseUrl/api/upload/favorite_image');
    final imageUploadRequest = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $accessToken'
      ..fields['userId'] = userId!
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        image.path,
      ));
    final response = await imageUploadRequest.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> saveFavoriteDescription(String description) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/favorite_description'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'description': description
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
  Future<bool> updatePrefecture(int prefectureId) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_prefectureId'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'prefectureId': prefectureId.toString()
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
  Future<bool> updateHeight(int height) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_height'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'height': height.toString()
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
  Future<bool> updateBodyType(int bodyType) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_bodyType'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'bodyType': bodyType.toString()
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
  Future<bool> updateBlood(int blood) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_blood'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'blood': blood.toString()
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
  Future<bool> updateBirth(int birth) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_birth'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'birth': birth.toString()
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
  Future<bool> updateEducation(int education) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_education'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'education': education.toString()
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
  Future<bool> updateJobType(int jobType) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_jobType'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'jobType': jobType.toString()
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
  Future<bool> updateIncome(int income) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_income'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'income': income.toString()
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
  Future<bool> updateMaritalHistory(int materialHistory) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_materialHistory'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'materialHistory': materialHistory.toString()
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
  Future<bool> updateAttitude(int attitude) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_attitude'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'attitude': attitude.toString()
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
  Future<bool> updateChildren(int children) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_children'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'children': children.toString()
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
  Future<bool> updateHousework(int housework) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_housework'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'housework': housework.toString()
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
  Future<bool> updateHopeMeet(int hopeMeet) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_hopeMeet'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'hopeMeet': hopeMeet.toString()
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
  Future<bool> updateDateCost(int dateCost) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_dateCost'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'dateCost': dateCost.toString()
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
  Future<bool> updateHoliday(int holiday) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_holiday'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'holiday': holiday.toString()
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
  Future<bool> updateRoomate(int roomate) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_roomate'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'roomate': roomate.toString()
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
  Future<bool> updateAlcohol(int alcohol) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_alcohol'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'alcohol': alcohol.toString()
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
  Future<bool> updateSmoking(int smoking) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_smoking'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'smoking': smoking.toString()
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
  Future<bool> updateSaving(int saving) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_saving'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'saving': saving.toString()
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

  Future<bool> removeGroups(List<int> removeGroups) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.delete(
      Uri.parse('$baseUrl/api/groups/remove_groups'),
      body: jsonEncode(<String, String>{
        'id': userId!,
        'removeGroups': jsonEncode(removeGroups)
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

  Future<List<MemberModel>> getGroupUsers(int groupId) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/groups/get_groupusers?userId=$userId&groupId=$groupId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<MemberModel> array = [];
      var reasonData = jsonDecode(response.body);
      for(var singleItem in reasonData){
        MemberModel item = MemberModel(singleItem["id"], singleItem["name"], singleItem["introduction"], singleItem["prefectureId"], singleItem["age"], singleItem["avatar"]);
        array.add(item);
      }
      return array;
    } else {
      return [];
    }
  }

  Future<bool> checkMember(int groupId) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/groups/checkmember?userId=$userId&groupId=$groupId'),
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

  Future<bool> enterGroup(int groupId) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/groups/entergroup'),
      body: jsonEncode(<String, String>{
        'userId': userId!,
        'groupId': groupId.toString()
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

  Future<List<LikeModel>> searchSwipeUser(int minAge, int maxAge, int minHeigth, int maxHeight, List<int> prefectureIds, List<int> bodyTypes, List<int> maritalHistories, List<int> attitudes) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/search_swipeusers'),
      body: jsonEncode(<String, String>{
        'userId': userId!,
        'minAge': minAge.toString(),
        'maxAge': maxAge.toString(),
        'minHeight': minHeigth.toString(),
        'maxHeight': maxHeight.toString(),
        'prefectureIds': jsonEncode(prefectureIds),
        'bodyTypes': jsonEncode(bodyTypes),
        'maritalHistories': jsonEncode(maritalHistories),
        'attitues': jsonEncode(attitudes)
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      List<LikeModel> array = [];
      var reasonData = jsonDecode(response.body);
      for(var singleItem in reasonData){
        List<String> avatars = (singleItem["avatars"] as List).map((avatar) => avatar.toString()).toList();
        LikeModel item = LikeModel(singleItem["id"], singleItem["name"], singleItem["description"], singleItem["prefectureId"], singleItem["age"], avatars, singleItem["verify"], singleItem["favouriteText"], singleItem["favouriteImage"]);
        array.add(item);
      }
      return array;
    }else{
      return [];
    }
  }

  Future<List<MemberModel>> searchGroupUser(int groupId, int minAge, int maxAge, int minHeigth, int maxHeight, List<int> prefectureIds, List<int> bodyTypes, List<int> maritalHistories, List<int> attitudes) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/groups/search_groupusers'),
      body: jsonEncode(<String, String>{
        'userId': userId!,
        'groupId': groupId.toString(),
        'minAge': minAge.toString(),
        'maxAge': maxAge.toString(),
        'minHeight': minHeigth.toString(),
        'maxHeight': maxHeight.toString(),
        'prefectureIds': jsonEncode(prefectureIds),
        'bodyTypes': jsonEncode(bodyTypes),
        'maritalHistories': jsonEncode(maritalHistories),
        'attitues': jsonEncode(attitudes)
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      List<MemberModel> array = [];
      var reasonData = jsonDecode(response.body);
      for(var singleItem in reasonData){
        MemberModel item = MemberModel(singleItem["id"], singleItem["name"], singleItem["introduction"], singleItem["prefectureId"], singleItem["age"], singleItem["avatar"]);
        array.add(item);
      }
      return array;
    }else{
      return [];
    }
  }

  Future<List<User>> getMatchedUserList() async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/auth/get_matchedusers?userId=$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      List<User> array = [];
      var reasonData = jsonDecode(response.body);
      for(var singleItem in reasonData){
        User item = User(id: singleItem["id"], name: singleItem["name"], age: singleItem["age"], prefectureId: singleItem["prefectureId"], avatar: singleItem["avatar"], state: "あなたのメッセージを待っています！", time: singleItem["time"]);
        array.add(item);
      }
      return array;
    }else{
      return [];
    }
  }

  Future<List<PhraseModel>> getPhrase() async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/auth/get_phrase?userId=$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      List<PhraseModel> array = [];
      var reasonData = jsonDecode(response.body);
      for(var singleItem in reasonData){
        PhraseModel item = PhraseModel(singleItem["id"], singleItem["text"]);
        array.add(item);
      }
      return array;
    }else{
      return [];
    }
  }

  Future<bool> updatePhrase(int id, String text) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/update_phrase'),
      body: jsonEncode(<String, String>{
        'userId': userId!,
        'id': id.toString(),
        'text': text
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> sendAdviceRequest(int id) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/advice_request'),
      body: jsonEncode(<String, String>{
        'userId': userId!,
        'partnerId': id.toString(),
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<AdviceStateModel?> getAdviceState(int partnerId) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/auth/get_advicestate?userId=$userId&partnerId=$partnerId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      var responseData = jsonDecode(response.body);
      return AdviceStateModel(responseData["state"], responseData["answer"]);
    }else{
      return null;
    }
  }

  Future<bool> sendVerifyCard(File image, String verifyType) async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final url = Uri.parse('$baseUrl/api/upload/send_verifycard');
    final imageUploadRequest = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $accessToken'
      ..fields['userId'] = userId!
      ..fields['verifyType'] = verifyType
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        image.path,
      ));
    final response = await imageUploadRequest.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> getVerifyState() async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/api/auth/get_verifystate?userId=$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      var responseData = jsonDecode(response.body);
      return responseData["state"];
    }else{
      return null;
    }
  }

  Future<bool> verifyChecked() async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/checked_verifystate'),
      body: jsonEncode(<String, String>{
        'userId': userId!,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> deleteAccount() async{
    String? userId = await storage.read(key: 'userId');
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.delete(
      Uri.parse('$baseUrl/api/auth/delete_account'),
      body: jsonEncode(<String, String>{
        'userId': userId!,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      await storage.deleteAll();
      return true;
    }else{
      return false;
    }
  }
  // Future<UserModel> login(String email, String password) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/api/auth/login/'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'email': email, 'password': password}),
  //   );
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     String accessToken = data['access_token'];
  //     String refreshToken = data['refresh_token'];
  //     await storage.write(key: 'accessToken', value: accessToken);
  //     await storage.write(key: 'refreshToken', value: refreshToken);
  //     return UserModel.fromJson(data);
  //   } else {
  //     return UserModel(
  //       id: 0, 
  //       name: '', 
  //       email: '', 
  //       furigana: '', 
  //       birthday: '', 
  //       gender: 0, 
  //       company: '', 
  //       isPilot: null, 
  //       isActivated: null, 
  //       createdAt: '');
  //   }
  // }

  Future<bool> register(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email})
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } 

  Future<void> logout() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
  }

  Future<bool> isAuthenticated() async{
    String? accessToken = await storage.read(key: 'accessToken');
    if(accessToken == null || JwtDecoder.isExpired(accessToken)){
      return await _refreshToken();
    }
    return true;
  }

  Future<bool> _refreshToken() async{
    String? refreshToken = await storage.read(key: 'refreshToken');
    if(refreshToken == null){
      return false;
    } 
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/refresh_token/'),
      body: jsonEncode(<String, String>{
        'refresh_token': refreshToken
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      String newAccessToken = data['accessToken'];
      await storage.write(key: 'accessToken', value: newAccessToken);
      return true;
    }else{
      await logout();
      return false;
    }
  }

  Future<void> scheduleTokenRefresh() async {
    final accessToken = await storage.read(key: 'accessToken');
    if (accessToken != null){
      final experationTime = JwtDecoder.getExpirationDate(accessToken);
      final now = DateTime.now();
      final refreshTime = experationTime.subtract(const Duration(minutes: 5));
      if (now.isBefore(refreshTime)) {
        await Future.delayed(refreshTime.difference(now), () async {
          await _refreshToken();
          await scheduleTokenRefresh();
        });
      }
    }
  }
  
}
