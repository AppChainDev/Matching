
import 'package:rinlin/models/record_model.dart';
import 'package:rinlin/services/recordapi_service.dart';
import 'package:flutter/material.dart';

class RecordState with ChangeNotifier {
  final RecordApiService recordApiService;
  List<RecordModel> _records = [];

  RecordState({required this.recordApiService});

  List<RecordModel> get records => _records;

  Future<void> saveRecord(int userId) async {
    await recordApiService.saveRecord(userId);
  }

  Future<void> getRecord() async {
    _records = await recordApiService.getRecord();
    notifyListeners();
  }
  
}
