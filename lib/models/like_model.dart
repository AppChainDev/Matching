class LikeModel {
  final int id;
  final String name;
  final String? description;
  final int prefectureId;
  final int age;
  final List<String> avatars;
  final bool verify;
  final String? favouriteText;
  final String? favouriteImage;

  LikeModel(this.id, this.name, this.description, this.prefectureId, this.age, this.avatars, this.verify, this.favouriteText, this.favouriteImage);
}
