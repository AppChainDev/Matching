import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionsWidget extends StatelessWidget{
  const QuestionsWidget({
    super.key
 });

  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 16, left: 20, right: 16, bottom: 40),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "3つの質問", 
            fontSize: 17, 
            fontWeight: FontWeight.normal, 
            lineHeight: 1.5, 
            letterSpacing: 1, 
            color: AppColors.primaryBlack
          ),
          CustomText(
            text: "お相手が会話をしやすくなります", 
            fontSize: 12, 
            fontWeight: FontWeight.normal, 
            lineHeight: 1, 
            letterSpacing: 1, 
            color: AppColors.secondaryGray
          ),
          const SizedBox(
            height: 28,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "初めてのデートはどこに行きたい？", 
                fontSize: 14, 
                fontWeight: FontWeight.normal, 
                lineHeight: 2, 
                letterSpacing: -1, 
                color: AppColors.secondaryGray
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/question1");
                },
                child: QuestionsItem(text:Provider.of<UserState>(context, listen: false).user!.questions![0])
              ),
              CustomText(
                text: "連絡先の交換はどのタイミング？", 
                fontSize: 14, 
                fontWeight: FontWeight.normal, 
                lineHeight: 2, 
                letterSpacing: -1, 
                color: AppColors.secondaryGray
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/question2");
                },
                child: QuestionsItem(text:Provider.of<UserState>(context, listen: false).user!.questions![1])
              ),
              CustomText(
                text: "パートナーとしてみたいことは？", 
                fontSize: 14, 
                fontWeight: FontWeight.normal, 
                lineHeight: 2, 
                letterSpacing: -1, 
                color: AppColors.secondaryGray
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/question3");
                },
                child: QuestionsItem(text:Provider.of<UserState>(context, listen: false).user!.questions![2])
              ),
            ],
          )  
        ],
      ),
    );
  }
}


class QuestionsItem extends StatelessWidget{
  final String text;
  const QuestionsItem({
    super.key, required this.text
 });

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 14, left: 10, right: 10, bottom: 14),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.secondaryGray,
        ),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.secondaryGreen,
                borderRadius: BorderRadius.circular(50)
              ),
              child: Icon(
                Icons.add,
                color: AppColors.primaryWhite,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            text == "null" || text == ""? Row(
              children: [
                CustomText(
                  text: "設定して5ポイントゲット！", 
                  fontSize: 14, 
                  fontWeight: FontWeight.normal, 
                  lineHeight: 1, 
                  letterSpacing: -1, 
                  color: AppColors.secondaryGray
                ),
                const SizedBox(
                  width: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: AppColors.secondaryBlue,
                      size: 20,
                    ),
                    CustomText(
                      text: "5P", 
                      fontSize: 14, 
                      fontWeight: FontWeight.bold, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color: AppColors.secondaryBlue
                    ),
                  ],
                )
              ],
            ):Text(
                text,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  height: 1,
                  letterSpacing: -1,
                  color: AppColors.secondaryGray
                ),
              )
          ],
        ),
      ),
    );
  }
}