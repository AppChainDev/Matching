import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/blockaccount/block_card.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/block_model.dart';
import 'package:drone/state/block_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlockListScreen extends StatefulWidget {

  const BlockListScreen({super.key});

  @override
  State<BlockListScreen> createState() => _BlockListScreenState();
}

class _BlockListScreenState extends State<BlockListScreen> {
  // final List<BlockModel> blocks = [
  //   BlockModel(id: 1, avatar: "avatar1.png", name: 'Test1', age: 50, prefectureId: 12),
  //   BlockModel(id: 2, avatar: "avatar1.png", name: 'Test2', age: 48, prefectureId: 13),
  //   BlockModel(id: 3, avatar: "avatar1.png", name: 'Test3', age: 53, prefectureId: 14),
  // ];
  late List<BlockModel> blocks;
  bool isLoding = false;

  @override
  void initState() {
    getBlockList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getBlockList() async{
    await Provider.of<BlockState>(context, listen: false).getBlockList();
    setState(() {
      blocks = Provider.of<BlockState>(context, listen: false).blocks;
      isLoding = true;
    });
  }

  Future removeBlock(int id) async{
    final result = await Provider.of<BlockState>(context, listen: false).removeBlock(id);
    if (result) {
      Navigator.pop(context);
    }
    await Provider.of<BlockState>(context, listen: false).getBlockList();
    setState(() {
      blocks = Provider.of<BlockState>(context, listen: false).blocks;
    });
  }

  void processUnblock(int id){
    showDialog( 
      barrierDismissible: false,
      context: context,
      builder: (_) => Center( // Aligns the container to center
        child: Container( // A simplified version of dialog. 
          width: 325,
          height: 177,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.primaryWhite
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:47, bottom: 34),
                child: Center(
                  child: Text(
                    "ブロックを解除しても\nよろしいですか？",
                    textAlign:TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.normal,
                      fontSize:16,
                      decoration: TextDecoration.none
                    ),
                  ),
                )
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 163,
                      decoration: BoxDecoration(
                        border:Border(
                          top: BorderSide(
                            color: AppColors.primaryGray,
                            width: 1.5
                          ),
                          right: BorderSide(
                            color: AppColors.primaryGray,
                            width: 1.5
                          )
                        )
                      ),
                      child: TextButton(
                        onPressed: (){
                          removeBlock(id);
                        },
                        child: Text(
                          'キャンセル',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:AppColors.alertBlue,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ),
                    ),
                    Container(
                      width: 162,
                      decoration: BoxDecoration(
                        border:Border(
                          top: BorderSide(
                            color: AppColors.primaryGray,
                            width: 1.5
                          )
                        )
                      ),
                      child: TextButton(
                        onPressed: (){
                          setState(() {
                            blocks.removeWhere((record)=>record.id==id);
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:AppColors.alertBlue,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: isLoding? Stack(
        children: [
          if(blocks.isNotEmpty)
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
                          children: blocks.map((item){
                            return BlockItem(
                              name: item.name, 
                              prefectureId: item.prefectureId, 
                              age: item.age, 
                              avatarImage: item.avatar, 
                              id: 1, 
                              onPressed:(){
                                // print(item.id);
                                processUnblock(item.id);
                              } 
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
          if(blocks.isEmpty)
            Center(
              child: CustomContainer(
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground
                ),
                child: Center(
                  child: CustomText(
                    text: "ブロックされたユーザーがいません。", 
                    fontSize: 16, 
                    fontWeight: FontWeight.normal, 
                    lineHeight: 1, 
                    letterSpacing: -1, 
                    color: AppColors.secondaryGreen
                  ),
                )
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
                      text: "ブロックユーザー", 
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
