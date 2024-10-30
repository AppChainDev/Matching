import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/models/usertransfer_model.dart';
import 'package:rinlin/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MemberItem extends StatelessWidget{
 const MemberItem({super.key, required this.id, required this.name, required this.prefectureId, required this.age, required this.introduction, required this.avatar});
 final int id;
 final String name;
 final int prefectureId;
 final int age;
 final String introduction;
 final String avatar;
 
  @override
  Widget build(BuildContext context){
    return Container(
      width: 163,
      margin: const EdgeInsets.only(right: 16, bottom: 26),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Container(
            width: 163,
            height: 193,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("${dotenv.get('BASE_URL')}/img/$avatar"),
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            child: MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, "/view_profile", arguments: UserTransforIdModel(null, id: id, beforePage: 'swipepage'));
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "$age歳", 
                            fontSize: 15, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: 1, 
                            color: AppColors.primaryWhite
                          ),
                          const SizedBox(width: 14,),
                          CustomText(
                            text: ConstFile.prefectureItems[prefectureId], 
                            fontSize: 15, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: 1, 
                            color: AppColors.primaryWhite
                          ),
                        ],
                      ),
                    )
                  ],  
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 7, left: 11, right: 11),
            child: Text(
              introduction,
              maxLines: 2,
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontSize: 10,
                fontWeight: FontWeight.normal,
                height: 1.5,
                letterSpacing: -1
              ),
            ),
          )
        ],
      ),
    );
  }
}