class LikeModel {
  final int id;
  final String name;
  final String? description;
  final int prefectureId;
  final int age;
  final List<String> avatars;
  final bool verify;
  final bool favourite;
  final String? favouriteTitle;
  final String? favouriteText;
  final String? favouriteImage;

  LikeModel(this.id, this.name, this.description, this.prefectureId, this.age, this.avatars, this.verify, this.favourite, this.favouriteTitle, this.favouriteText, this.favouriteImage);
}
