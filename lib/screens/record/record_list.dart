import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/components/record/record_card.dart';
import 'package:drone/models/pilotid_model.dart';
import 'package:drone/models/record_model.dart';
import 'package:flutter/material.dart';

class RecordListScreen extends StatefulWidget {

  const RecordListScreen({super.key});

  @override
  State<RecordListScreen> createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<RecordListScreen> {
  final List<RecordModel> records = [
    RecordModel(id: 1, avatar: "avatar1.png", name: 'Test1', age: 50, prefectureId: 12),
    RecordModel(id: 2, avatar: "avatar1.png", name: 'Test2', age: 48, prefectureId: 13),
    RecordModel(id: 3, avatar: "avatar1.png", name: 'Test3', age: 53, prefectureId: 14),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void processLike(int id){
    setState(() {
      records.removeWhere((record)=>record.id==id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        children: [
          Center(
            child: CustomContainer(
              decoration: BoxDecoration(
                color: AppColors.primaryBackground
              ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 50),
                    child: Column(
                      children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 94),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: records.map((item){
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/view_profile", arguments: UserTransforIdModel(id: item.id, beforePage: 'record_list'));
                              },
                              child: RecordItem(
                                name: item.name, 
                                prefectureId: item.prefectureId, 
                                age: item.age, 
                                avatarImage: item.avatar, 
                                id: item.id, 
                                onPressed:(){
                                  processLike(item.id);
                                } 
                              ),
                            );
                          }).toList()
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
           Center(
            child: CustomContainer(
              height: 94,
              decoration: BoxDecoration(
                color: AppColors.secondaryGreen
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      text: "足跡", 
                      fontSize: 17, 
                      fontWeight: FontWeight.bold, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color: AppColors.primaryWhite
                    ),
                  ],
                ),
              ),
            ),
          ),
           Center(
            child: CustomContainer(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(top:46),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColors.primaryWhite,
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
          
        ],
      )
    );
  }
}
