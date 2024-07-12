import 'package:drone/components/agreement/agreement_chatcard.dart';
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';

class AgreementChatListScreen extends StatefulWidget {

  const AgreementChatListScreen({super.key});

  @override
  State<AgreementChatListScreen> createState() => _AgreementChatListScreenState();
}

class _AgreementChatListScreenState extends State<AgreementChatListScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
               child: const SingleChildScrollView(
                 child: Padding(
                   padding: EdgeInsets.only(top: 10, bottom: 50),
                   child: Column(
                     children: [
                      Padding(
                        padding: EdgeInsets.only(top: 94),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AgreementChatItem(
                              id:1,
                              name: "Woman30", 
                              prefectureId: 13, 
                              age: 49, 
                              description: "こんにちは！ \nよかったら私もその予定に参加したいです。", 
                              avatarImage: "avatar1.png"
                            ),
                            AgreementChatItem(
                              id:2,
                              name: "Woman31", 
                              prefectureId: 12, 
                              age: 54, 
                              description: "あなたの投稿しているメッセージをみて私も一緒に参加したくなったのでメッセージしました。 よかったら私の愛を受け取ってください。 予定日以外でも調整することができます。 よろしくおねがいします。", 
                              avatarImage: "avatar1.png"
                            ),
                            AgreementChatItem(
                              id:3,
                              name: "Woman32", 
                              prefectureId: 12, 
                              age: 43, 
                              description: "こんにちは！ 一緒にあなたの予定をこなしたい！",
                              avatarImage: "avatar1.png"
                            ),
                            AgreementChatItem(
                              id:4,
                              name: "Woman33", 
                              prefectureId: 12, 
                              age: 41, 
                              description: "こんにちは！ 一緒にあなたの予定をこなしたい！", 
                              avatarImage: "avatar1.png"
                            )
                          ],
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
                      text: "投稿管理", 
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
