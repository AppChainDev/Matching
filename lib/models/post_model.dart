class PostModel {
  final int id;
  final int userId; 
  final String name;
  final String description;
  final int prefectureId;
  final int age;
  final String avatar;
  final String backImage;
  final int messageCount;
  final int? newNessageCount;

  PostModel(this.id, this.userId, this.name, this.description, this.prefectureId, this.age, this.avatar, this.backImage, this.messageCount, this.newNessageCount);
}
