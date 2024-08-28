
import 'package:rinlin/models/like_model.dart';
import 'package:rinlin/services/likeapi_service.dart';
import 'package:flutter/material.dart';

class LikeState with ChangeNotifier {
  final LikeApiService likeApiService;
  List<LikeModel> _likes = [];

  LikeState({required this.likeApiService});

  List<LikeModel> get likes => _likes;

  Future<bool> sendLike(int userId) async {
    return await likeApiService.sendLike(userId);
  }
  Future<bool> skipSwipe() async {
    return await likeApiService.skipSwipe();
  }
  Future<bool> sendMessageLike(int id, String text) async {
    return await likeApiService.sendMessageLike(id, text);
  }

  Future<void> getLikeList() async {
    _likes = await likeApiService.getLikeList();
    notifyListeners();
  }

  Future<bool> skipLike(int id) async {
    return await likeApiService.skipLike(id);
  }
  Future<bool> createMatching(int id) async {
    return await likeApiService.createMatching(id);
  }
  
}
