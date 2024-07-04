class UserModel {
  final int id;
  final String name;
  final String email;
  final String furigana;
  final String birthday;
  final int gender;
  final String company;
  final bool? isPilot;
  final bool? isActivated;
  final String createdAt;

  UserModel({required this.id, required this.name, required this.email, required this.furigana, required this.birthday, required this.gender, required this.company, required this.isPilot, required this.isActivated, required this.createdAt,});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'], 
      furigana: json['user']['furigana'], 
      birthday: json['user']['birthday'], 
      gender: json['user']['gender'], 
      company: json['user']['company'], 
      isPilot: json['user']['is_pilot'], 
      isActivated: json['user']['is_activated'], 
      createdAt: json['user']['created_at']
    );
  }
}
