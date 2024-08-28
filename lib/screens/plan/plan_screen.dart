import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/utils/const_file.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {

  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {

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
          CustomContainer(
            decoration: BoxDecoration(
              color: AppColors.primaryGray.withOpacity(0.5)
            ),
            child: CustomContainer(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    const Center(
                      child: CustomContainer(
                        height: 236,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/plan_back.png"),
                            fit: BoxFit.cover     
                          )
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 210,
                                  height: 33,
                                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: AppColors.primaryWhite,
                                      width: 2
                                    )
                                  ),
                                  child: CustomText(
                                    text: "今だけ無料でお試しできる", 
                                    fontSize: 16, 
                                    fontWeight: FontWeight.normal, 
                                    lineHeight: 1, 
                                    letterSpacing: -0.5, 
                                    color: AppColors.primaryWhite
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CustomText(
                                      text: "70%", 
                                      fontSize: 33, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1, 
                                      letterSpacing: -0.5, 
                                      color: AppColors.primaryWhite
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomText(
                                      text: "の女性は", 
                                      fontSize: 25, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1, 
                                      letterSpacing: -0.5, 
                                      color: AppColors.primaryWhite
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  text: "メッセージを待っています。", 
                                  fontSize: 18, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: -0.5, 
                                  color: AppColors.primaryWhite
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 147, left: 25, right: 25),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 214,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                              decoration: BoxDecoration(
                                color: AppColors.primaryWhite,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 45),
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 8,
                                            color: AppColors.secondaryYellow,
                                          ),
                                          CustomText(
                                            text: "スタンダートプランの特典", 
                                            fontSize: 20, 
                                            fontWeight: FontWeight.normal, 
                                            lineHeight: 1, 
                                            letterSpacing: -2, 
                                            color: AppColors.primaryBlack
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 23,left: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/images/limit.png", fit:BoxFit.cover),
                                            const SizedBox(
                                              width: 22,
                                            ),
                                            CustomText(
                                              text: "無制限", 
                                              fontSize: 15, 
                                              fontWeight: FontWeight.normal, 
                                              lineHeight: 1, 
                                              letterSpacing: 0, 
                                              color: AppColors.thirdRed
                                            ),
                                            CustomText(
                                              text: "のメッセージプラン", 
                                              fontSize: 15, 
                                              fontWeight: FontWeight.normal, 
                                              lineHeight: 1, 
                                              letterSpacing: 0, 
                                              color: AppColors.primaryBlack
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/images/first_profile.png", fit:BoxFit.cover),
                                            const SizedBox(
                                              width: 22,
                                            ),
                                            CustomText(
                                              text: "プロフィールの", 
                                              fontSize: 15, 
                                              fontWeight: FontWeight.normal, 
                                              lineHeight: 1, 
                                              letterSpacing: 0, 
                                              color: AppColors.primaryBlack
                                            ),
                                            CustomText(
                                              text: "優先表示", 
                                              fontSize: 15, 
                                              fontWeight: FontWeight.normal, 
                                              lineHeight: 1, 
                                              letterSpacing: 0, 
                                              color: AppColors.thirdRed
                                            ),
                                            
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/images/gift.png", fit:BoxFit.cover),
                                            const SizedBox(
                                              width: 22,
                                            ),
                                            CustomText(
                                              text: "毎月300ポイントプレゼント", 
                                              fontSize: 15, 
                                              fontWeight: FontWeight.normal, 
                                              lineHeight: 1, 
                                              letterSpacing: 0, 
                                              color: AppColors.primaryBlack
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomText(
                                    text: "お試しプランはいつでも解約手続きすることができ期間内であれば登録料や解約料はかかりません。", 
                                    fontSize: 12, 
                                    fontWeight: FontWeight.normal, 
                                    lineHeight: 2, 
                                    letterSpacing: -1, 
                                    color: AppColors.primaryBlack
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 120,
                                    margin: const EdgeInsets.only(bottom: 17),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryWhite,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.secondaryGray.withOpacity(0.3), // Shadow color
                                          spreadRadius: 0.5, // Spread radius
                                          blurRadius: 8, // Blur radius
                                          offset: const Offset(0, 1), // Shadow position (x, y)
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 106,
                                          decoration: BoxDecoration(
                                            color: AppColors.thirdRed,
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  CustomText(
                                                    text: "12", 
                                                    fontSize: 35, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 1, 
                                                    letterSpacing: -2, 
                                                    color: AppColors.primaryWhite
                                                  ),
                                                  CustomText(
                                                    text: "ヶ月", 
                                                    fontSize: 22, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 0, 
                                                    letterSpacing: -2, 
                                                    color: AppColors.primaryWhite
                                                  ),
                                                ],
                                              ),
                                              CustomText(
                                                text: "プラン", 
                                                fontSize: 20, 
                                                fontWeight: FontWeight.normal, 
                                                lineHeight: 0, 
                                                letterSpacing: -2, 
                                                color: AppColors.primaryWhite
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 36),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      CustomText(
                                                        text: "¥20,000", 
                                                        fontSize: 15, 
                                                        fontWeight: FontWeight.normal, 
                                                        lineHeight: 1, 
                                                        letterSpacing: -1, 
                                                        color: AppColors.primaryBlack
                                                      ),
                                                      CustomText(
                                                        text: "(税込)", 
                                                        fontSize: 10, 
                                                        fontWeight: FontWeight.normal, 
                                                        lineHeight: 0, 
                                                        letterSpacing: -1, 
                                                        color: AppColors.primaryBlack
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: 105,
                                                    height: 2,
                                                    color: AppColors.thirdRed,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  CustomText(
                                                    text: "一括", 
                                                    fontSize: 10, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 0, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.thirdRed
                                                  ),
                                                  const SizedBox(width: 13),
                                                  CustomText(
                                                    text: "18,000", 
                                                    fontSize: 30, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 1, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.thirdRed
                                                  ),
                                                  CustomText(
                                                    text: "(税込)", 
                                                    fontSize: 13, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 0, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.thirdRed
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 102,
                                                height: 27,
                                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                                decoration: BoxDecoration(
                                                  color: AppColors.secondaryGreen,
                                                  borderRadius: BorderRadius.circular(50)
                                                ),
                                                child: Center(
                                                  child: CustomText(
                                                    text: "¥1,500/月", 
                                                    fontSize: 16, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 1, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.primaryWhite
                                                  ),
                                                ),
                                              ),
                                              CustomText(
                                                text: "さらに1000ポイントがボーナス", 
                                                fontSize: 13, 
                                                fontWeight: FontWeight.normal, 
                                                lineHeight: 1, 
                                                letterSpacing: -1, 
                                                color: AppColors.secondaryGreen
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 120,
                                    margin: const EdgeInsets.only(bottom: 17),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryWhite,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.secondaryGray.withOpacity(0.3), // Shadow color
                                          spreadRadius: 0.5, // Spread radius
                                          blurRadius: 8, // Blur radius
                                          offset: const Offset(0, 1), // Shadow position (x, y)
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 106,
                                          decoration: BoxDecoration(
                                            color: AppColors.thirdRed,
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  CustomText(
                                                    text: "6", 
                                                    fontSize: 35, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 1, 
                                                    letterSpacing: -2, 
                                                    color: AppColors.primaryWhite
                                                  ),
                                                  CustomText(
                                                    text: "ヶ月", 
                                                    fontSize: 22, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 0, 
                                                    letterSpacing: -2, 
                                                    color: AppColors.primaryWhite
                                                  ),
                                                ],
                                              ),
                                              CustomText(
                                                text: "プラン", 
                                                fontSize: 20, 
                                                fontWeight: FontWeight.normal, 
                                                lineHeight: 0, 
                                                letterSpacing: -2, 
                                                color: AppColors.primaryWhite
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 36),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      CustomText(
                                                        text: "¥20,000", 
                                                        fontSize: 15, 
                                                        fontWeight: FontWeight.normal, 
                                                        lineHeight: 1, 
                                                        letterSpacing: -1, 
                                                        color: AppColors.primaryBlack
                                                      ),
                                                      CustomText(
                                                        text: "(税込)", 
                                                        fontSize: 10, 
                                                        fontWeight: FontWeight.normal, 
                                                        lineHeight: 0, 
                                                        letterSpacing: -1, 
                                                        color: AppColors.primaryBlack
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: 105,
                                                    height: 2,
                                                    color: AppColors.thirdRed,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  CustomText(
                                                    text: "一括", 
                                                    fontSize: 10, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 0, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.thirdRed
                                                  ),
                                                  const SizedBox(width: 13),
                                                  CustomText(
                                                    text: "10,200", 
                                                    fontSize: 30, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 1, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.thirdRed
                                                  ),
                                                  CustomText(
                                                    text: "(税込)", 
                                                    fontSize: 13, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 0, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.thirdRed
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 102,
                                                height: 27,
                                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                                decoration: BoxDecoration(
                                                  color: AppColors.secondaryGreen,
                                                  borderRadius: BorderRadius.circular(50)
                                                ),
                                                child: Center(
                                                  child: CustomText(
                                                    text: "¥1,700/月", 
                                                    fontSize: 16, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 1, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.primaryWhite
                                                  ),
                                                ),
                                              ),
                                              CustomText(
                                                text: "さらに1000ポイントがボーナス", 
                                                fontSize: 13, 
                                                fontWeight: FontWeight.normal, 
                                                lineHeight: 1, 
                                                letterSpacing: -1, 
                                                color: AppColors.secondaryGreen
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 120,
                                    margin: const EdgeInsets.only(bottom: 17),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryWhite,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.secondaryGray.withOpacity(0.3), // Shadow color
                                          spreadRadius: 0.5, // Spread radius
                                          blurRadius: 8, // Blur radius
                                          offset: const Offset(0, 1), // Shadow position (x, y)
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 106,
                                          decoration: BoxDecoration(
                                            color: AppColors.thirdRed,
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  CustomText(
                                                    text: "3", 
                                                    fontSize: 35, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 1, 
                                                    letterSpacing: -2, 
                                                    color: AppColors.primaryWhite
                                                  ),
                                                  CustomText(
                                                    text: "ヶ月", 
                                                    fontSize: 22, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 0, 
                                                    letterSpacing: -2, 
                                                    color: AppColors.primaryWhite
                                                  ),
                                                ],
                                              ),
                                              CustomText(
                                                text: "プラン", 
                                                fontSize: 20, 
                                                fontWeight: FontWeight.normal, 
                                                lineHeight: 0, 
                                                letterSpacing: -2, 
                                                color: AppColors.primaryWhite
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 36),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      CustomText(
                                                        text: "¥20,000", 
                                                        fontSize: 15, 
                                                        fontWeight: FontWeight.normal, 
                                                        lineHeight: 1, 
                                                        letterSpacing: -1, 
                                                        color: AppColors.primaryBlack
                                                      ),
                                                      CustomText(
                                                        text: "(税込)", 
                                                        fontSize: 10, 
                                                        fontWeight: FontWeight.normal, 
                                                        lineHeight: 0, 
                                                        letterSpacing: -1, 
                                                        color: AppColors.primaryBlack
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: 105,
                                                    height: 2,
                                                    color: AppColors.thirdRed,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  CustomText(
                                                    text: "一括", 
                                                    fontSize: 10, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 0, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.thirdRed
                                                  ),
                                                  const SizedBox(width: 13),
                                                  CustomText(
                                                    text: "6,600", 
                                                    fontSize: 30, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 1, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.thirdRed
                                                  ),
                                                  CustomText(
                                                    text: "(税込)", 
                                                    fontSize: 13, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 0, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.thirdRed
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 102,
                                                height: 27,
                                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                                decoration: BoxDecoration(
                                                  color: AppColors.secondaryGreen,
                                                  borderRadius: BorderRadius.circular(50)
                                                ),
                                                child: Center(
                                                  child: CustomText(
                                                    text: "¥2,300/月", 
                                                    fontSize: 16, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 1, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.primaryWhite
                                                  ),
                                                ),
                                              ),
                                              CustomText(
                                                text: "さらに1000ポイントがボーナス", 
                                                fontSize: 13, 
                                                fontWeight: FontWeight.normal, 
                                                lineHeight: 1, 
                                                letterSpacing: -1, 
                                                color: AppColors.secondaryGreen
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
//------------------------ free--------------------------
                                GestureDetector(
                                  onTap: () {
                                    
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryWhite,
                                      borderRadius: BorderRadius.circular(50)
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 106,
                                          decoration: BoxDecoration(
                                            color: AppColors.secondaryGray,
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(50),
                                              bottomLeft: Radius.circular(50),
                                            )
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  CustomText(
                                                    text: "1ヶ月", 
                                                    fontSize: 22, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 1, 
                                                    letterSpacing: -2, 
                                                    color: AppColors.primaryWhite
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              CustomText(
                                                text: "７日間無料トライアル中!", 
                                                fontSize: 17, 
                                                fontWeight: FontWeight.normal, 
                                                lineHeight: 1, 
                                                letterSpacing: 1, 
                                                color: AppColors.thirdRed
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  
                                                  CustomText(
                                                    text: "¥3,600", 
                                                    fontSize: 24, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 1, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.primaryBlack
                                                  ),
                                                  CustomText(
                                                    text: "(税込)", 
                                                    fontSize: 11, 
                                                    fontWeight: FontWeight.normal, 
                                                    lineHeight: 0, 
                                                    letterSpacing: -1, 
                                                    color: AppColors.primaryBackground
                                                  ),
                                                ],
                                              )
                                              
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 50),
                                  child: CustomText(
                                    text: ConstFile.planPolicy, 
                                    fontSize: 11, 
                                    fontWeight: FontWeight.normal, 
                                    lineHeight: 1.5, 
                                    letterSpacing: 0, 
                                    color: AppColors.secondaryGray
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30, left: 10),
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                }, 
                                icon: Icon(
                                  Icons.close,
                                  color: AppColors.primaryWhite,
                                  size: 30,
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                    )
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

