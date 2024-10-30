import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ReplyListItem extends StatelessWidget{
  const ReplyListItem({
    super.key, required this.id, required this.name, required this.prefectureId, required this.age, required this.avatar, required this.date, required this.onClick
 });

 final int id;
 final String name;
 final int prefectureId;
 final int age;
 final String avatar;
 final String date;
 final VoidCallback onClick;

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(right: 26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onClick,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: NetworkImage("${dotenv.get('BASE_URL')}/img/$avatar"),
                  fit: BoxFit.cover
                )
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomText(
            text: "${ConstFile.prefectureItems[prefectureId]} $age歳", 
            fontSize: 10, 
            fontWeight: FontWeight.normal, 
            lineHeight: 1, 
            letterSpacing: 1, 
            color: AppColors.primaryBlack
          )
          
        ],
      ),
    );
  }
}