class UserModel {
  final int id;
  final String name;
  final int age;
  final int gender;
  final int prefectureId;
  final int height;
  final int bodyType;
  final int attitude;
  final List<String> avatars;
  final int blood;
  final int birth;
  final int education;
  final int jobType;
  final int income;
  final int materialHistory;
  final int children;
  final int housework;
  final int hopeMeet;
  final int dateCost;
  final int? holiday;
  final int? roomate;
  final int? alcohol;
  final int? smoking;
  final int? saving;
  final String? favoriteImage;
  final String? favoriteDescription;
  final List<int> groups;
  final bool isVerify;
  final int pointCount;
  final List<String>? questions;
  final List<String> phrases;
  final String? deadline;
  final String createdAt;
  final String updateAt;

  UserModel({
    required this.id, 
    required this.name, 
    required this.age, 
    required this.gender, 
    required this.prefectureId, 
    required this.height, 
    required this.bodyType, 
    required this.attitude, 
    required this.avatars, 
    required this.blood, 
    required this.birth, 
    required this.education, 
    required this.jobType, 
    required this.income, 
    required this.materialHistory, 
    required this.children, 
    required this.housework, 
    required this.hopeMeet, 
    required this.dateCost, 
    required this.roomate,
    required this.holiday, 
    required this.alcohol, 
    required this.smoking, 
    required this.saving, 
    required this.favoriteImage, 
    required this.favoriteDescription, 
    required this.groups, 
    required this.isVerify, 
    required this.pointCount, 
    required this.questions, 
    required this.phrases, 
    required this.deadline, 
    required this.createdAt, 
    required this.updateAt
  });
}
