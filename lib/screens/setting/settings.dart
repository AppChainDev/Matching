import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {

  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

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
                  padding: const EdgeInsets.only(top: 118, left: 17, right: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "アカウント設定", 
                        fontSize: 11, 
                        fontWeight: FontWeight.normal, 
                        lineHeight: 2, 
                        letterSpacing: 1, 
                        color: AppColors.secondaryGray
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 15, bottom: 15, right: 18),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.secondaryGray
                            )
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "アカウントID", 
                              fontSize: 14, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1, 
                              letterSpacing: 1, 
                              color: AppColors.primaryBlack
                            ),
                            CustomText(
                              text: "ID:${Provider.of<UserState>(context, listen: false).user!.id}", 
                              fontSize: 14, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1, 
                              letterSpacing: 1, 
                              color: AppColors.secondaryGray
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/block_list");
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15, right: 18),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.secondaryGray
                              )
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "ブロックしたユーザー", 
                                fontSize: 14, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/notification_setting");
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15, right: 18),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.secondaryGray
                              )
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "通知設定", 
                                fontSize: 14, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomText(
                        text: "その他", 
                        fontSize: 11, 
                        fontWeight: FontWeight.normal, 
                        lineHeight: 2, 
                        letterSpacing: 1, 
                        color: AppColors.secondaryGray
                      ),
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15, right: 18),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.secondaryGray
                              )
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "ヘルプ", 
                                fontSize: 14, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15, right: 18),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.secondaryGray
                              )
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "お問い合せ", 
                                fontSize: 14, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15, right: 18),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.secondaryGray
                              )
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "利用規約", 
                                fontSize: 14, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15, right: 18),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.secondaryGray
                              )
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "特定商取引法に基づく表示", 
                                fontSize: 14, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/delete_account");
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15, right: 18),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.secondaryGray
                              )
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "退会", 
                                fontSize: 14, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          logoutAlert(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15, right: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "ログアウト", 
                                fontSize: 14, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              )
                            ],
                          ),
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
                      text: "設定", 
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

logoutAlert(BuildContext context){
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => Center( // Aligns the container to center
      child: Container( // A simplified version of dialog. 
        width: 270,
        height: 142,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.primaryWhite
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:43, bottom: 33),
              child: Center(
                child: Text(
                  "ログアウトしますか？",
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontWeight: FontWeight.bold,
                    fontSize:17,
                    decoration: TextDecoration.none
                  ),
                ),
              )
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 135,
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
                      onPressed: () async {
                        await Provider.of<UserState>(context, listen: false).logout();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/");
                      },
                      child: Text(
                        'ログアウト',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:AppColors.alertBlue,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                  ),
                  Container(
                    width: 135,
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
                        Navigator.pop(context);
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
                ],
              ),
            )
          ],
        ),
        )
      )
  );
}
