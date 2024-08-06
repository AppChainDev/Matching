import 'dart:convert';
import 'dart:io';
import 'package:drone/models/category_model.dart';
import 'package:drone/models/community_model.dart';
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
      String accessToken = data['accessToken'];
      String refreshToken = data['refreshToken'];
      await storage.write(key: 'userId', value: jsonEncode(userId));
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
    final url = Uri.parse('$baseUrl/api/upload/addavatar1');
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
      var str  = responseData;
      return UserModel(
        id: responseData["id"], 
        name: responseData["name"], 
        age: responseData["age"], 
        gender: responseData["gender"], 
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
        pointCount: responseData["pointCount"], 
        questions: questions, 
        phrases: phrases, 
        deadline: responseData["deadline"], 
        createdAt: responseData["createdAt"], 
        updateAt: responseData["updatedAt"]
      );
    }else{
      return UserModel(
        id: 0, 
        name: '', 
        age: 0, 
        gender: 0, 
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
        pointCount: 0, 
        questions: null, 
        phrases: [], 
        deadline: '', 
        createdAt: '', 
        updateAt: ''
      );
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
