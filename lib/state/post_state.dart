
import 'dart:io';

import 'package:drone/models/post_model.dart';
import 'package:drone/services/postapi_service.dart';
import 'package:flutter/material.dart';

class PostState with ChangeNotifier {
  final PostApiService postApiService;
  List<PostModel> _posts = [];
  List<PostModel> _myPosts = [];

  PostState({required this.postApiService});

  List<PostModel> get posts => _posts;
  List<PostModel> get myPosts => _myPosts;

  Future<bool> createPost(File image, String description) async {
    return await postApiService.createPost(image, description);
  }
  Future<void> getMyPost() async {
    _myPosts = await postApiService.getMyPost();
    notifyListeners();
  }
  Future<void> getPosts() async {
    _posts = await postApiService.getPosts();
    notifyListeners();
  }
  
}
