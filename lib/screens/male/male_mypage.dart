
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
class MaleMyPage extends StatefulWidget {

  const MaleMyPage({super.key});

  @override
  State<MaleMyPage> createState() => _MaleMyPageState();
}

class _MaleMyPageState extends State<MaleMyPage> {
  final TextEditingController questionController= TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationAlert();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void notificationAlert() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
            ),
            height: MediaQuery.of(context).copyWith().size.height * (2/3),
            child: Container(
              padding: const EdgeInsets.only(top: 32, left: 26, right: 26, bottom: 15),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "すぐに通知を受け取るには", 
                    fontSize: 22, 
                    fontWeight: FontWeight.normal, 
                    lineHeight: 1, 
                    letterSpacing: -1, 
                    color: AppColors.primaryBlack
                  ),
                  Image.asset("assets/images/allow_notification.png", fit: BoxFit.cover),
                  CustomText(
                    text: "アプリの通知を許可することで、他のユーザーからの通知をすぐに確認できスムーズなコミュニケーションを取ることが可能です。", 
                    fontSize: 16, 
                    fontWeight: FontWeight.normal, 
                    lineHeight: 1.5, 
                    letterSpacing: -2, 
                    color: AppColors.primaryBlack
                  ),
                  Container(
                    width: 316,
                    height: 97,
                    padding: const EdgeInsets.only(top: 10, left: 17),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGray.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "いいねを受け取った時\nマッチング成立時\n他のユーザーからのメッセージ", 
                          fontSize: 16, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1.5, 
                          letterSpacing: -1, 
                          color: AppColors.primaryBlack
                        )
                      ],
                    ),
                  ),
                  CustomButton(
                      title: "次へ",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () async{ 
                        Navigator.pop(context);
                        allowNotification(context);
                      }
                    ),
                ],
              ),
            )
        );
      });
  }

  Widget bottomBar(){
    return 
      Center(
        child: CustomContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite
                ),
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/agreement.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              '共感',
                              style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/detection.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              '発見',
                              style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/like.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              'いいね',
                              style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/message.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              'メッセージ',
                              style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/profile.png"),
                              color: AppColors.secondaryGreen
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              'マイページ',
                              style: TextStyle(
                                color: AppColors.secondaryGreen,
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }

  allowNotification(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Center( // Aligns the container to center
        child: Container( // A simplified version of dialog. 
          width: 270,
          height: 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            // color: AppColors.primaryWhite.withOpacity(0.9)
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryYellow.withOpacity(0.9),
                AppColors.primaryYellow.withOpacity(0.7)
              ],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:12),
                child: Center(
                  child: Text(
                    "通知を送信します\n許可しますか？",
                    textAlign:TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.normal,
                      fontSize:15,
                      decoration: TextDecoration.none
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:24, bottom: 30),
                child: Center(
                  child: Text(
                    "通知方法は、テキスト、サウンド、アイコンが\n利用できる可能性を含みます。\n通知方法は「設定」で設定できます。",
                    textAlign:TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.normal,
                      fontSize:10,
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
                            color: AppColors.primaryBlack.withOpacity(0.4),
                            width: 1.5
                          ),
                          right: BorderSide(
                            color: AppColors.primaryBlack.withOpacity(0.4),
                            width: 1.5
                          )
                        )
                      ),
                      child: TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text(
                          '許可しない',
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
                            color: AppColors.primaryBlack.withOpacity(0.4),
                            width: 1.5
                          )
                        )
                      ),
                      child: TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text(
                          '許可',
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

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return BaseScreen(
      child: Stack(
        children: [
          Center(
             child: CustomContainer(
              decoration: BoxDecoration(
                color: AppColors.primaryWhite
              ),
               child: SingleChildScrollView(
                 child: Column(
                   children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 76, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 90,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 90,
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 7),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50)
                                          ),
                                          child: Image.asset("assets/images/avatar1.png", fit:BoxFit.cover),
                                        ),
                                      ),
                                      Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryGreen,
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(
                                            color: AppColors.primaryWhite,
                                            width: 2
                                          )
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 15,
                                            color: AppColors.primaryWhite,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: "ゆうた", 
                                          fontSize: 17, 
                                          fontWeight: FontWeight.bold, 
                                          lineHeight: 1.5, 
                                          letterSpacing: -1, 
                                          color: AppColors.primaryBlack
                                        ),
                                        Row(
                                          children: [
                                            CustomText(
                                              text: "55歳", 
                                              fontSize: 10, 
                                              fontWeight: FontWeight.normal, 
                                              lineHeight: 1, 
                                              letterSpacing: 1, 
                                              color: AppColors.primaryBlack
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CustomText(
                                              text: "東京都", 
                                              fontSize: 10, 
                                              fontWeight: FontWeight.normal, 
                                              lineHeight: 1, 
                                              letterSpacing: 1, 
                                              color: AppColors.primaryBlack
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        
                                      },
                                      child: Container(
                                        width: 221,
                                        height: 42,
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryGreen.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(
                                            color: AppColors.secondaryGreen,
                                            width: 2
                                          )
                                        ),
                                        child: Center(
                                          child: CustomText(
                                            text: "プロフィール編集", 
                                            fontSize: 13, 
                                            fontWeight: FontWeight.bold, 
                                            lineHeight: 1, 
                                            letterSpacing: 1, 
                                            color: AppColors.secondaryGreen
                                          ),
                                        ),
                                      
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:22, left: 10, right: 10, bottom: 22 ),
                            child: SizedBox(
                              height: 66,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 99,
                                    height: 66,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryGreen.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: "本人確認", 
                                          fontSize: 10, 
                                          fontWeight: FontWeight.normal, 
                                          lineHeight: 2, 
                                          letterSpacing: 1, 
                                          color: AppColors.primaryBlack
                                        ),
                                        CustomText(
                                          text: "未確認", 
                                          fontSize: 17, 
                                          fontWeight: FontWeight.normal, 
                                          lineHeight: 1, 
                                          letterSpacing: 1, 
                                          color: AppColors.primaryBlack
                                        )
                                      ],
                                    )
                                  ),
                                  Container(
                                    width: 99,
                                    height: 66,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryGreen.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: "ステータス", 
                                          fontSize: 10, 
                                          fontWeight: FontWeight.normal, 
                                          lineHeight: 2, 
                                          letterSpacing: 1, 
                                          color: AppColors.primaryBlack
                                        ),
                                        CustomText(
                                          text: "無料", 
                                          fontSize: 17, 
                                          fontWeight: FontWeight.normal, 
                                          lineHeight: 1, 
                                          letterSpacing: 1, 
                                          color: AppColors.primaryBlack
                                        )
                                      ],
                                    )
                                  ),
                                  Container(
                                    width: 99,
                                    height: 66,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryGreen.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: "ポイント", 
                                          fontSize: 10, 
                                          fontWeight: FontWeight.normal, 
                                          lineHeight: 2, 
                                          letterSpacing: 1, 
                                          color: AppColors.primaryBlack
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/images/p_icon.png", fit: BoxFit.cover),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            CustomText(
                                              text: "50", 
                                              fontSize: 17, 
                                              fontWeight: FontWeight.normal, 
                                              lineHeight: 1, 
                                              letterSpacing: 1, 
                                              color: AppColors.primaryBlack
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              height: 350,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/sale_card.png")
                                )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 23),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 36.5),
                            width: MediaQuery.of(context).size.width/3,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/record_list');
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 43,
                                    height: 43,
                                    child: Image.asset("assets/images/record.png", fit: BoxFit.contain,)
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Text(
                                    'あしあと',
                                    style: TextStyle(
                                      color: AppColors.primaryBlack.withOpacity(0.6),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 36.5),
                            width: MediaQuery.of(context).size.width/3,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/agreement");
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 43,
                                    height: 43,
                                    child: Image.asset("assets/images/bog_agreement.png", fit: BoxFit.contain,)
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Text(
                                    '共感',
                                    style: TextStyle(
                                      color: AppColors.primaryBlack.withOpacity(0.6),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 36.5),
                            width: MediaQuery.of(context).size.width/3,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/support");
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 43,
                                    height: 43,
                                    child: Image.asset("assets/images/consultation.png", fit: BoxFit.contain,)
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Text(
                                    '相談',
                                    style: TextStyle(
                                      color: AppColors.primaryBlack.withOpacity(0.6),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 36.5),
                            width: MediaQuery.of(context).size.width/3,
                            child: MaterialButton(
                              onPressed: () {
                                
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 43,
                                    height: 43,
                                    child: Image.asset("assets/images/setting.png", fit: BoxFit.contain,)
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Text(
                                    '各種設定',
                                    style: TextStyle(
                                      color: AppColors.primaryBlack.withOpacity(0.6),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 36.5),
                            width: MediaQuery.of(context).size.width/3,
                            child: MaterialButton(
                              onPressed: () {
                                
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 43,
                                    height: 43,
                                    child: Image.asset("assets/images/help.png", fit: BoxFit.contain,)
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Text(
                                    'ヘルプ',
                                    style: TextStyle(
                                      color: AppColors.primaryBlack.withOpacity(0.6),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 36.5),
                            width: MediaQuery.of(context).size.width/3,
                            child: MaterialButton(
                              onPressed: () {
                                
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 43,
                                    height: 43,
                                    child: Image.asset("assets/images/notification.png", fit: BoxFit.contain,)
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Text(
                                    'お知らせ',
                                    style: TextStyle(
                                      color: AppColors.primaryBlack.withOpacity(0.6),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 106,
                      margin: const EdgeInsets.only(bottom: 100),
                      child: ListView(
                         scrollDirection: Axis.horizontal,
                         children: <Widget>[
                           Container(
                             width: 204,
                             height: 87,
                             margin: const EdgeInsets.only(left: 20),
                             decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryGray
                             ),
                             child: const Center(
                               child: Text(
                                "広告A",
                                style: TextStyle(
                                  fontSize: 17
                                ),
                               ),
                             ),
                           ),
                           Container(
                             width: 204,
                             height: 87,
                             margin: const EdgeInsets.only(left: 20),
                             decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryGray
                             ),
                             child: const Center(
                               child: Text(
                                "広告8",
                                style: TextStyle(
                                  fontSize: 17
                                ),
                               ),
                             ),
                           ),
                         ],
                       ),
                    ),
                   ],
                 ),
               ),
             ),
          ),
          bottomBar()
        ],
      )
    );
  }
}
