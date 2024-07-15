import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';

class DeleteAccountScreen extends StatefulWidget {

  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {

  bool isAgree = false;

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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 105),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          padding: const EdgeInsets.only(top: 18, bottom: 25),
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.secondaryGray.withOpacity(0.5), // Shadow color
                                spreadRadius: 0.5, // Spread radius
                                blurRadius: 5, // Blur radius
                                offset: const Offset(0, 1), // Shadow position (x, y)
                              ),
                            ],
                          ),
                          child: Center(
                            child: 
                            Column(
                              children: [
                                Text(
                                  "退会の前に以下の\n注意事項に同意する必要があります。", 
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14, 
                                    fontWeight: FontWeight.normal, 
                                    height: 2, 
                                    letterSpacing: -0.5, 
                                    color: AppColors.secondaryRed
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 65,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 23, right: 23),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "1.退会することで以下の情報が削除されるこ\nとになります。", 
                              fontSize: 16, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1.5, 
                              letterSpacing: -1, 
                              color: AppColors.primaryBlack
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            CustomText(
                              text: "・会員情報\n・マッチング情報\n・メッセージ履歴\n・その他のすべてのデータ", 
                              fontSize: 13, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1.5, 
                              letterSpacing: -1, 
                              color: AppColors.primaryBlack
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            CustomText(
                              text: "2.再度登録時に前回のデータを引き継ぐこ\nとはできません。", 
                              fontSize: 16, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1.5, 
                              letterSpacing: -1, 
                              color: AppColors.primaryBlack
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CustomText(
                              text: "引き継ぎたい場合は、ログアウトを選択してください。", 
                              fontSize: 12, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1.5, 
                              letterSpacing: -1, 
                              color: AppColors.secondaryRed
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isAgree = !isAgree;
                                    });
                                  },
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircleAvatar(
                                      radius: 10,
                                      foregroundColor: AppColors.primaryWhite,
                                      backgroundColor: isAgree?AppColors.secondaryGreen:AppColors.secondaryGray,
                                      child: ImageIcon(
                                        const AssetImage("assets/images/tick.png"),
                                        color: AppColors.primaryWhite,
                                      )
                                    ),
                                  )
                                ),
                                const SizedBox(
                                  width: 32,
                                ),
                                CustomText(
                                  text: "上記に同意します。", 
                                  fontSize: 13, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryBlack
                                )
                              ],
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
           ),
           Center(
            child: CustomContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22),
                    child: CustomButton(
                      title: "退会する",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: !isAgree?AppColors.secondaryGreen.withOpacity(0.5):AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () async{ 
                        if(isAgree){
                          Navigator.pushNamed(context, "/");
                        }          
                      }
                    ),
                  ),
                ],
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
                      text: "退会", 
                      fontSize: 17, 
                      fontWeight: FontWeight.bold, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color:AppColors.primaryWhite
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CustomContainer(
                height: 94,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
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
