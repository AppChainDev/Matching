import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';

class NotificationSettingScreen extends StatefulWidget {

  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool recordNotification = true;
  bool likeNotification = true;
  bool matchingNotification = false;
  bool messageNotification = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future<void> setNotifiaction() async {
  //   const storage = FlutterSecureStorage();
  //   await storage.write(key: 'notification', value: light.toString());  
  // }
  
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
                          padding: const EdgeInsets.only(top: 15, bottom: 20),
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: 
                            Column(
                              children: [
                                Text(
                                  "プッシュ通知が許可されていません。\nプッシュ通知を有効にするには\n「設定」から通知設定を有効にしてください。", 
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10, 
                                    fontWeight: FontWeight.normal, 
                                    height: 2, 
                                    letterSpacing: -0.5, 
                                    color: AppColors.primaryBlack
                                  ),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Container(
                                  width: 114,
                                  height: 27,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryGreen,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      
                                    },
                                    child: Center(
                                      child: CustomText(
                                        text: "通知設定", 
                                        fontSize: 10, 
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 17, right: 17),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 15, bottom: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.primaryGray,
                                    width: 2
                                  )
                                )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "足跡がついた時", 
                                    fontSize: 14, 
                                    fontWeight: FontWeight.normal, 
                                    lineHeight: 1, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right:13),
                                    width: 42,
                                    height: 25,
                                    child:  Switch(
                                      value: recordNotification, 
                                      activeColor: AppColors.primaryGreen,
                                      thumbColor: WidgetStateColor.transparent,
                                      onChanged: (bool value){
                                        setState((){
                                          recordNotification = value;
                                        });
                                        // setNotifiaction();
                                      }
                                    ) 
                                  ), 
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 15, bottom: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.primaryGray,
                                    width: 2
                                  )
                                )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "いいねをされた時", 
                                    fontSize: 14, 
                                    fontWeight: FontWeight.normal, 
                                    lineHeight: 1, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right:13),
                                    width: 42,
                                    height: 25,
                                    child:  Switch(
                                      value: likeNotification, 
                                      activeColor: AppColors.primaryGreen,
                                      thumbColor: WidgetStateColor.transparent,
                                      onChanged: (bool value){
                                        setState((){
                                          likeNotification = value;
                                        });
                                        // setNotifiaction();
                                      }
                                    ) 
                                  ), 
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 15, bottom: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.primaryGray,
                                    width: 2
                                  )
                                )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "マッチング成立時", 
                                    fontSize: 14, 
                                    fontWeight: FontWeight.normal, 
                                    lineHeight: 1, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right:13),
                                    width: 42,
                                    height: 25,
                                    child:  Switch(
                                      value: matchingNotification, 
                                      activeColor: AppColors.primaryGreen,
                                      thumbColor: WidgetStateColor.transparent,
                                      onChanged: (bool value){
                                        setState((){
                                          matchingNotification = value;
                                        });
                                        // setNotifiaction();
                                      }
                                    ) 
                                  ), 
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 15, bottom: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.primaryGray,
                                    width: 2
                                  )
                                )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "メッセージを受信した時", 
                                    fontSize: 14, 
                                    fontWeight: FontWeight.normal, 
                                    lineHeight: 1, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right:13),
                                    width: 42,
                                    height: 25,
                                    child:  Switch(
                                      value: messageNotification, 
                                      activeColor: AppColors.primaryGreen,
                                      thumbColor: WidgetStateColor.transparent,
                                      onChanged: (bool value){
                                        setState((){
                                          messageNotification = value;
                                        });
                                        // setNotifiaction();
                                      }
                                    ) 
                                  ), 
                                ],
                              ),
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
