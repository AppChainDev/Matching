
import 'package:drone/models/block_model.dart';
import 'package:drone/services/blockapi_service.dart';
import 'package:flutter/material.dart';

class BlockState with ChangeNotifier {
  final BlockApiService blockApiService;
  List<BlockModel> _blocks = [];

  BlockState({required this.blockApiService});

  List<BlockModel> get blocks => _blocks;

  Future<void> getBlockList() async {
    _blocks = await blockApiService.getBlockList();
    notifyListeners();
  }
  Future<bool> removeBlock(int id) async {
    return await blockApiService.removeBlock(id);
  }

  
}
