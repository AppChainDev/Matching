import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';

class IntroductionWidget extends StatelessWidget{
  const IntroductionWidget({
    super.key
 });

  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 470,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "自己PR", 
            fontSize: 15, 
            fontWeight: FontWeight.normal, 
            lineHeight: 1, 
            letterSpacing: 1, 
            color: AppColors.primaryBlack
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: CustomText(
                text: "私は、日本に住んでいる男性です。初めてアプリを利用しました。\n好きなことは登山と釣りをすることです。休日はよくキャンプに出かけます。いつもは一人ですが、いい人がいたら一緒に行きたいです。他には、仕事はIT系です。土日が休みなので同じ休みの日の人がいたら嬉しいです。\nとにかく素敵な人と出会いって結婚をスタートしたいです。", 
                fontSize: 14, 
                fontWeight: FontWeight.normal, 
                lineHeight: 1.5, 
                letterSpacing: -1, 
                color: AppColors.primaryBlack
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Container(
                width: 170,
                height: 47,
                decoration: BoxDecoration(
                  color: AppColors.secondaryGreen,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/edit_introduce");
                  },
                  child: Center(
                    child: CustomText(
                      text: "編集", 
                      fontSize: 14, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color: AppColors.primaryWhite
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}