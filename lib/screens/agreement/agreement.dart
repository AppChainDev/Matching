import 'package:drone/components/agreement/agreement_card.dart';
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';

class AgreementScreen extends StatefulWidget {

  const AgreementScreen({super.key});

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {

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
                color: AppColors.primaryWhite
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
                          children: [
                            MaterialButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Padding(
                                      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                                      child:Text(
                                        "この投稿には\nまだメッセージがありません", 
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18, 
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.primaryBlack,
                                          letterSpacing: -1
                                        ),
                                      )
                                    ),
                                    actions: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              width: 2,
                                              color: AppColors.primaryGray
                                            )
                                          )
                                        ),
                                        child: Center(
                                          child: TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: TextButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              }, 
                                              child: CustomText(
                                                text: "OK", 
                                                fontSize: 20, 
                                                fontWeight: FontWeight.bold, 
                                                lineHeight: 1, 
                                                letterSpacing: 1, 
                                                color: AppColors.primaryBlue
                                              )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const AgreementItem(
                                name: "ゆうた", 
                                prefectureId: 12, 
                                age: 55, 
                                description: "とっても楽しかったまた行きたい", 
                                bgImage: "agreement_image1.png", 
                                avatarImage: "avatar1.png"
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/agreenment_chatlist");
                              },
                              child: const AgreementItem(
                                name: "ゆうた", 
                                prefectureId: 12, 
                                age: 55, 
                                description: "栗拾いに行きました", 
                                bgImage: "agreement_image2.png", 
                                avatarImage: "avatar1.png"
                              ),
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
