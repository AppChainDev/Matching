class UserModel {
  final int id;
  final String name;
  final int age;
  final int gender;
  final String introduce;
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
  final bool isPay;
  final int pointCount;
  final List<String>? questions;
  final List<String> phrases;
  final String? deadline;
  final bool experience;
  final int? viewUsers;
  final String createdAt;
  final String updateAt;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.introduce,
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
    this.holiday,
    this.roomate,
    this.alcohol,
    this.smoking,
    this.saving,
    this.favoriteImage,
    this.favoriteDescription,
    required this.groups,
    required this.isVerify,
    required this.isPay,
    required this.pointCount,
    this.questions,
    required this.phrases,
    this.deadline,
    required this.experience,
    this.viewUsers,
    required this.createdAt,
    required this.updateAt,
  });

  // fromJson method to handle nulls from the database
  factory UserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('UserModel cannot be created from null data');
    }

    return UserModel(
      id: json['id'] ?? 0, // Default to 0 if null
      name: json['name'] ?? '', // Default to empty string if null
      age: json['age'] ?? 0,
      gender: json['gender'] ?? 0,
      introduce: json['introduce'] ?? '',
      prefectureId: json['prefectureId'] ?? 0,
      height: json['height'] ?? 0,
      bodyType: json['bodyType'] ?? 0,
      attitude: json['attitude'] ?? 0,
      avatars: List<String>.from(json['avatars'] ?? []),
      blood: json['blood'] ?? 0,
      birth: json['birth'] ?? 0,
      education: json['education'] ?? 0,
      jobType: json['jobType'] ?? 0,
      income: json['income'] ?? 0,
      materialHistory: json['materialHistory'] ?? 0,
      children: json['children'] ?? 0,
      housework: json['housework'] ?? 0,
      hopeMeet: json['hopeMeet'] ?? 0,
      dateCost: json['dateCost'] ?? 0,
      holiday: json['holiday'], // Can be null
      roomate: json['roomate'], // Can be null
      alcohol: json['alcohol'], // Can be null
      smoking: json['smoking'], // Can be null
      saving: json['saving'], // Can be null
      favoriteImage: json['favoriteImage'], // Can be null
      favoriteDescription: json['favoriteDescription'], // Can be null
      groups: List<int>.from(json['groups'] ?? []),
      isVerify: json['isVerify'] ?? false,
      isPay: json['isPay'] ?? false,
      pointCount: json['pointCount'] ?? 0,
      questions: (json['questions'] != null)
          ? List<String>.from(json['questions'])
          : null, // Can be null
      phrases: List<String>.from(json['phrases'] ?? []),
      deadline: json['deadline'], // Can be null
      experience: json['experience'] ?? false,
      viewUsers: json['viewUsers'], // Can be null
      createdAt: json['createdAt'] ?? '',
      updateAt: json['updateAt'] ?? '',
    );
  }
}
