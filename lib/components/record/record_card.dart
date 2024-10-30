import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RecordItem extends StatelessWidget{
  const RecordItem({
    super.key, required this.name, required this.prefectureId, required this.age, required this.avatarImage, required this.id, required this.onPressed
 });

 final int id;
 final String name;
 final int prefectureId;
 final int age;
 final String avatarImage;
 final VoidCallback onPressed;

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left:15, right: 15),
        child: Container(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.primaryGray.withOpacity(0.5),
                width: 1
              ),
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: NetworkImage("${dotenv.get('BASE_URL')}/img/$avatarImage"),
                        fit: BoxFit.cover
                      )
                    )
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: name, 
                        fontSize: 16, 
                        fontWeight: FontWeight.bold, 
                        lineHeight: 2, 
                        letterSpacing: 1, 
                        color: AppColors.primaryBlack
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: ConstFile.prefectureItems[prefectureId], 
                            fontSize: 12, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: 1, 
                            color: AppColors.secondaryGray
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomText(
                            text: "$age歳", 
                            fontSize: 12, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: 1, 
                            color: AppColors.secondaryGray
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryGreen,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: MaterialButton(
                  onPressed: onPressed,
                  child: Center(
                    child: CustomText(
                      text: "いいねを送る", 
                      fontSize: 13, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color: AppColors.primaryWhite
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}