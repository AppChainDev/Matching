import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PostItem extends StatelessWidget{
  const PostItem({
    super.key, required this.id, required this.name, required this.prefectureId, required this.age, required this.description, required this.bgImage, required this.avatarImage, required this.pressProfile, required this.pressMessage
 });

 final int id;
 final String name;
 final int prefectureId;
 final int age;
 final String description;
 final String bgImage;
 final String avatarImage;
 final VoidCallback pressProfile;
 final VoidCallback pressMessage;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top:25),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 440,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage("${dotenv.get('BASE_URL')}/img/$bgImage"),
                fit: BoxFit.cover
              )
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 440,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.primaryBlack.withOpacity(0.5),
                ],
              ),
              
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 43,
                                      height: 43,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: NetworkImage("${dotenv.get('BASE_URL')}/img/$avatarImage"),
                                          fit: BoxFit.cover
                                        )
                                      )
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: name, 
                                          fontSize: 16, 
                                          fontWeight: FontWeight.bold, 
                                          lineHeight: 1.5, 
                                          letterSpacing: 1, 
                                          color: AppColors.primaryWhite
                                        ),
                                        Row(
                                          children: [
                                            CustomText(
                                              text: "$age歳", 
                                              fontSize: 16, 
                                              fontWeight: FontWeight.bold, 
                                              lineHeight: 1.5, 
                                              letterSpacing: 1, 
                                              color: AppColors.primaryWhite
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            CustomText(
                                              text: ConstFile.prefectureItems[prefectureId], 
                                              fontSize: 10, 
                                              fontWeight: FontWeight.normal, 
                                              lineHeight: 1.5, 
                                              letterSpacing: 1, 
                                              color: AppColors.primaryWhite
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CustomText(
                                  text: description, 
                                  fontSize: 14, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1.5, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryWhite
                                )
                              ],
                            ),
                          )
                          
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 440,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 74,
                    height: 174,
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite.withOpacity(0.6),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30)
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.primaryBlack.withOpacity(0.5)
                          ),
                          child: MaterialButton(
                            onPressed: pressProfile,
                            child: Center(
                              child: ImageIcon(
                                const AssetImage("assets/images/profile.png"),
                                color: AppColors.primaryWhite,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.primaryBlack.withOpacity(0.5)
                          ),
                          child: MaterialButton(
                            onPressed: pressMessage,
                            child: Center(
                              child: ImageIcon(
                                const AssetImage("assets/images/message.png"),
                                color: AppColors.primaryWhite
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}