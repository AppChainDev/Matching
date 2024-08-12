import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/components/record/record_card.dart';
import 'package:drone/models/usertransfer_model.dart';
import 'package:drone/models/record_model.dart';
import 'package:drone/state/like_state.dart';
import 'package:drone/state/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordListScreen extends StatefulWidget {

  const RecordListScreen({super.key});

  @override
  State<RecordListScreen> createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<RecordListScreen> {
  late List<RecordModel> records;
  bool isLoding = false;

  @override
  void initState() {
    super.initState();
    getRecord();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getRecord() async{
    await Provider.of<RecordState>(context, listen: false).getRecord();
    setState(() {
      records = Provider.of<RecordState>(context, listen: false).records;
      isLoding = true;
    });
  }

  Future processLike(int id) async{
    await Provider.of<LikeState>(context, listen: false).sendLike(id);
    await Provider.of<RecordState>(context, listen: false).getRecord();
    setState(() {
      records = Provider.of<RecordState>(context, listen: false).records;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: isLoding? Stack(
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
                                Navigator.pushNamed(context, "/view_profile", arguments: UserTransforIdModel(null, id: item.id, beforePage: 'record_list'));
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
      ): const CustomContainer(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
    );
  }
}
