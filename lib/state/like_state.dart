
import 'package:drone/models/like_model.dart';
import 'package:drone/services/likeapi_service.dart';
import 'package:flutter/material.dart';

class LikeState with ChangeNotifier {
  final LikeApiService likeApiService;
  List<LikeModel> _likes = [];

  LikeState({required this.likeApiService});

  List<LikeModel> get likes => _likes;

  Future<void> sendLike(int userId) async {
    await likeApiService.sendLike(userId);
  }
  
}
