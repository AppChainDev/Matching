
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/pilotid_model.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:pod_player/pod_player.dart';

class PilotProfileScreen extends StatefulWidget {

  const PilotProfileScreen({super.key});

  @override
  State<PilotProfileScreen> createState() => _PilotProfileScreenState();
}

class _PilotProfileScreenState extends State<PilotProfileScreen> {
  final TextEditingController emailController = TextEditingController();
  final List<String> categories = ["カテゴリー名", "カテゴリー名", "カテゴリー名"];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PilotidIdModel;
    return BaseScreen(
      child: Stack(
        children: [
           Center(
             child: CustomContainer(
              child: Image.asset(
                "assets/images/white_commonback.png",
                fit: BoxFit.cover
              ),
             ),
           ),
           Center(
             child: CustomContainer(
               child: Padding(
                padding: const EdgeInsets.only(bottom: 81),
                 child: SingleChildScrollView(
                   child: Stack(
                    children: [
                      Center(
                        child: CustomContainer(
                          height: 254.0,
                          child: Image.asset(
                            "assets/images/female_profileback.png",
                            fit: BoxFit.cover
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 375,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 103, left: 20, right: 20, bottom: 81),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.primaryGreen
                                      ),
                                      child: Center(
                                        child: Text(
                                          "新潟県",
                                          style: TextStyle(
                                            color: AppColors.primaryWhite,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 54,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: AppColors.primaryWhite
                                          ),
                                          child: Center(
                                            child: Text(
                                              "女性",
                                              style: TextStyle(
                                                color: AppColors.primaryBlack,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Container(
                                          width: 54,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: AppColors.primaryWhite
                                          ),
                                          child: Center(
                                            child: Text(
                                              "30代",
                                              style: TextStyle(
                                                color: AppColors.primaryBlack,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: args.name, 
                                      fontSize: 20, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryBlack
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 335,
                                  margin: const EdgeInsets.only(top:16),
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    spacing: 6.6,
                                    children: categories.map((category){
                                      return Container(
                                        width: 90,
                                        height: 29,
                                        margin: const EdgeInsets.only(right: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.primaryBlack,
                                            width: 1
                                          )
                                        ),
                                        child: Center(
                                          child: CustomText(
                                            text: category, 
                                            fontSize: 12, 
                                            fontWeight: FontWeight.bold, 
                                            lineHeight: 1, 
                                            letterSpacing: 1, 
                                            color: AppColors.primaryBlack
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const ImageIcon(
                                      AssetImage("assets/images/bx-credit-card-front.png")
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    CustomText(
                                      text: "保有資格", 
                                      fontSize: 12, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.secondaryGray
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    CustomText(
                                      text: "一等無人航空機操縦士",
                                      fontSize: 13, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryBlack
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                     const ImageIcon(
                                      AssetImage("assets/images/bx-receipt.png")
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    CustomText(
                                      text: "単価目安", 
                                      fontSize: 12, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.secondaryGray
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    CustomText(
                                      text: "10,000円(1時間)",
                                      fontSize: 13, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryBlack
                                    ),
                                  ],
                                ),
                                // ----------videoList-----------
                                Container(
                                  width: 335,
                                  margin: const EdgeInsets.only(top:19),
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    spacing: 6.6,
                                    children: [
                                      Container(
                                        width: 160,
                                        height: 109,
                                        margin: const EdgeInsets.only(bottom: 3),                                      
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: PodVideoPlayer(
                                            controller: PodPlayerController(
                                              playVideoFrom: PlayVideoFrom.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
                                              podPlayerConfig: const PodPlayerConfig(
                                                autoPlay: false,
                                                isLooping: true,
                                                videoQualityPriority: [720, 360]
                                              )
                                            )..initialise()
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 160,
                                        height: 109,
                                        margin: const EdgeInsets.only(right: 5, bottom: 5),                                      
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: PodVideoPlayer(
                                            controller: PodPlayerController(
                                              playVideoFrom: PlayVideoFrom.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
                                              podPlayerConfig: const PodPlayerConfig(
                                                autoPlay: false,
                                                isLooping: true
                                              )
                                            )..initialise()
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 19,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: "実績", 
                                          fontSize: 15, 
                                          fontWeight: FontWeight.bold, 
                                          lineHeight: 1, 
                                          letterSpacing: 1, 
                                          color: AppColors.primaryBlack
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      text: ConstFile.trackRecord, 
                                      fontSize: 13, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1.5, 
                                      letterSpacing: -0.8, 
                                      color: AppColors.primaryBlack
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 19,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 13, bottom: 30),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        width: 1,
                                        color: AppColors.secondaryGray
                                      )
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: "略歴", 
                                            fontSize: 15, 
                                            fontWeight: FontWeight.bold, 
                                            lineHeight: 1, 
                                            letterSpacing: 1, 
                                            color: AppColors.primaryBlack
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        text: ConstFile.biography, 
                                        fontSize: 13, 
                                        fontWeight: FontWeight.normal, 
                                        lineHeight: 1.5, 
                                        letterSpacing: -0.8, 
                                        color: AppColors.primaryBlack
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
             child: Padding(
              padding: const EdgeInsets.only(top: 44),
              child: CustomText(
                text: "パイロットを探す",
                fontSize: 16, 
                fontWeight: FontWeight.bold, 
                color: AppColors.primaryBlack,
                lineHeight: 1.5,
                letterSpacing: 1,
              )
             ),
           ),
           Center(
            child: CustomContainer(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(top:30, left:20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        icon: Image.asset("assets/images/black_backmark.png", fit: BoxFit.cover,)
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        onPressed: (){
                          Navigator.pushNamed(context, "/settingpilot");
                        }, 
                        icon: Image.asset("assets/images/back_settingicon.png", fit: BoxFit.cover,)
                      ),
                    ),
                  ],
                ),
              ),
            ),
           ),
           Center(
             child: CustomContainer(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                  height: 81,
                  color: AppColors.primaryWhite,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 94,
                        child: MaterialButton(
                          onPressed: () {
                            
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  const AssetImage("assets/images/bx-search.png"),
                                  color: AppColors.secondaryBlue,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                CustomText(
                                  text: "探す", 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.secondaryBlue
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 94,
                        child: MaterialButton(
                          onPressed: () {
                            
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const ImageIcon(
                                  AssetImage("assets/images/bx-clipboard.png")
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                CustomText(
                                  text: "依頼一覧", 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.secondaryGray
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  const AssetImage("assets/images/bx-message-detail.png"),
                                  color: AppColors.secondaryGray,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                CustomText(
                                  text: "メッセージ", 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.secondaryGray
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 94,
                        child: MaterialButton(
                          onPressed: () {
                            
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const ImageIcon(
                                  AssetImage("assets/images/bx-wallet.png")
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                CustomText(
                                  text: "支払履歴", 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.secondaryGray
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  )
                ],
              )
             ),
           ),
           Center(
            child: CustomContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 88,
                    margin: const EdgeInsets.only(bottom: 81),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.secondaryGray.withOpacity(0.5),
                          width: 1
                        )
                      ),
                      color: AppColors.primaryWhite
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 47,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryBlue,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/request", arguments: PilotidIdModel(id: args.id, name: args.name));
                            },
                            child: CustomText(
                              text: "直接依頼", 
                              fontSize: 16, 
                              fontWeight: FontWeight.bold, 
                              lineHeight: 1, 
                              letterSpacing: 1, 
                              color: AppColors.primaryWhite
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ),
           ),
        ],
      )
    );
  }
}
