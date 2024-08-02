import 'dart:convert';
import 'dart:io';
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
  
  Future<UserModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String accessToken = data['access_token'];
      String refreshToken = data['refresh_token'];
      await storage.write(key: 'accessToken', value: accessToken);
      await storage.write(key: 'refreshToken', value: refreshToken);
      return UserModel.fromJson(data);
    } else {
      return UserModel(
        id: 0, 
        name: '', 
        email: '', 
        furigana: '', 
        birthday: '', 
        gender: 0, 
        company: '', 
        isPilot: null, 
        isActivated: null, 
        createdAt: '');
    }
  }

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
