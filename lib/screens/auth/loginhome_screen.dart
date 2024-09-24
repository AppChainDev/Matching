import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rinlin/state/user_state.dart';

class LoginHomeScreen extends StatefulWidget {

  const LoginHomeScreen({super.key});

  @override
  State<LoginHomeScreen> createState() => _LoginHomeScreenState();
}

class _LoginHomeScreenState extends State<LoginHomeScreen> {
  final List<int> _agreeCard = [];

  @override
  void initState() {
    saveOnesignalId();
    // moveMypage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleCartChanged(int id, bool inChecked) {
    setState(() {
      if (!inChecked) {
        _agreeCard.add(id);
      } else {
        _agreeCard.remove(id);
      }
    });
  }

  Future<void> saveOnesignalId() async{
    // const storage = FlutterSecureStorage();
    // String? userId = await storage.read(key: 'userId');
    // if (userId != null) {   
    //   OneSignal.login(userId);
    //   print(await OneSignal.User.getExternalId());
    // }
    String? onesignalId = await OneSignal.User.getOnesignalId();
    if (onesignalId != null) {
      final result  = await Provider.of<UserState>(context, listen: false).saveOnesignalId(onesignalId);
      if (result) {
        print(onesignalId);
      }
    }
  }

  Future moveMypage() async{
    const storage = FlutterSecureStorage();
    String? gender = await storage.read(key: 'gender');
    String? accessToken = await storage.read(key: 'accessToken');
    if (accessToken != null && gender != null) {
      if (int.parse(gender)==1) {
        Navigator.pushNamed(context, "/malemypage");
      }
      if (int.parse(gender)==2) {
        Navigator.pushNamed(context, "/femalemypage");
      }
    }
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
               child: Column(
                 children: [
                   Container(
                    margin: const EdgeInsets.only(top: 102),
                    height: 106,
                     child: ListView(
                       scrollDirection: Axis.horizontal,
                       children: <Widget>[
                         SizedBox(
                           width: 175,
                           child: Image.asset("assets/images/loginimage_1.png", fit: BoxFit.cover),
                         ),
                         SizedBox(
                           width: 175,
                           child: Image.asset("assets/images/loginimage_2.png", fit: BoxFit.cover),
                         ),
                         SizedBox(
                           width: 175,
                           child: Image.asset("assets/images/loginimage_3.png", fit: BoxFit.cover),
                         )
                       ],
                     ),
                   ),
                   SizedBox(
                    height: 106,
                     child: ListView(
                       scrollDirection: Axis.horizontal,
                       children: <Widget>[
                         SizedBox(
                           width: 175,
                           child: Image.asset("assets/images/loginimage_4.png", fit: BoxFit.cover),
                         ),
                         SizedBox(
                           width: 175,
                           child: Image.asset("assets/images/loginimage_5.png", fit: BoxFit.cover),
                         ),
                         SizedBox(
                           width: 175,
                           child: Image.asset("assets/images/loginimage_6.png", fit: BoxFit.cover),
                         )
                       ],
                     ),
                   ),
                   SizedBox(
                    height: 106,
                     child: ListView(
                       scrollDirection: Axis.horizontal,
                       children: <Widget>[
                         SizedBox(
                           width: 175,
                           child: Image.asset("assets/images/loginimage_7.png", fit: BoxFit.cover),
                         ),
                         SizedBox(
                           width: 175,
                           child: Image.asset("assets/images/loginimage_8.png", fit: BoxFit.cover),
                         ),
                         SizedBox(
                           width: 175,
                           child: Image.asset("assets/images/loginimage_9.png", fit: BoxFit.cover),
                         )
                       ],
                     ),
                   ),
                  Padding(
                    padding: const EdgeInsets.only(top: 44, left: 48, right: 85),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "プロフィールを設定してあと一歩！", 
                          fontSize: 12, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: -1, 
                          color: AppColors.primaryBlack
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          text: "安心してご利用いただけるように、お客様には利用規約に同意していただくようにお願いしております。", 
                          fontSize: 12, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1.5, 
                          letterSpacing: -1, 
                          color: AppColors.primaryBlack
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28, left: 48),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AgreeListItem(
                              id: 1, 
                              inChecked: _agreeCard.contains(1), 
                              onCartChanged: _handleCartChanged
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomText(
                              text: "私は35歳以上で独身です。", 
                              fontSize: 12, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1, 
                              letterSpacing: -0.5, 
                              color: AppColors.primaryBlack
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AgreeListItem(
                              id: 2, 
                              inChecked: _agreeCard.contains(2), 
                              onCartChanged: _handleCartChanged
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                children: <TextSpan> [
                                  TextSpan(
                                    text: "利用規約",
                                    style: TextStyle(
                                      color: AppColors.primaryBlue,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                      letterSpacing: -0.5
                                    )
                                  ),
                                  TextSpan(
                                    text: "および",
                                    style: TextStyle(
                                      color: AppColors.primaryBlack,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                      letterSpacing: -0.5
                                    )
                                  ),
                                  TextSpan(
                                    text: "プライバシーポリシー",
                                    style: TextStyle(
                                      color: AppColors.primaryBlue,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                      letterSpacing: -0.5
                                    )
                                  ),
                                  TextSpan(
                                    text: "に同意します。",
                                    style: TextStyle(
                                      color: AppColors.primaryBlack,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                      letterSpacing: -0.5
                                    )
                                  ),
                                ]
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:56),
                    child: Column(
                      children: [
                        CustomButton(
                          title: "つぎへ",
                          width: 343,
                          height: 45,
                          fontSize: 17, 
                          fontWeight: FontWeight.normal, 
                          color: _agreeCard.length != 2?AppColors.secondaryGreen.withOpacity(0.5):AppColors.secondaryGreen, 
                          titleColor: AppColors.primaryWhite, 
                          onTap: () async{ 
                            if(_agreeCard.length == 2){
                              Navigator.pushNamed(context, "/registerprofile_first");
                            }
                          }
                        ),
                      ],
                    ),
                  ),
                 ],
               ),
             ),
           ),
          
        ],
      )
    );
  }
}

typedef CartChangedCallback = Function(int id, bool inChecked);

class AgreeListItem extends StatelessWidget {
  const AgreeListItem(
      {required this.id,
      required this.inChecked,
      required this.onCartChanged,
      super.key});

  final int id;
  final bool inChecked;
  final CartChangedCallback onCartChanged;

  Color _getbackColor(BuildContext context) {

    return inChecked ? AppColors.secondaryGreen : AppColors.secondaryGray;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onCartChanged(id, inChecked);
        },
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircleAvatar(
            radius: 10,
            foregroundColor: AppColors.primaryWhite,
            backgroundColor: _getbackColor(context),
            child: ImageIcon(
              const AssetImage("assets/images/tick.png"),
              color: AppColors.primaryWhite,
            )
          ),
        ));
  }
}