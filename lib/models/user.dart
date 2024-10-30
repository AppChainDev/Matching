class User {
  final int id;
  final String name;
  final int age;       // New property
  final int prefectureId; // New property
  final String avatar; // New property
  late String state;     // New property to indicate last message state
  late String time;      // New property to indicate last chat time

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.prefectureId,
    required this.avatar,
    required this.state,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'prefecture_id': prefectureId,
        'avatar': avatar,
        'state': state,
        'time': time,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      prefectureId: json['prefecture_id'],
      avatar: json['avatar'],
      state: json['state'],
      time: json['time'],
    );
  }
}
