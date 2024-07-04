
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';

class PaymentDetailScreen extends StatefulWidget {

  const PaymentDetailScreen({super.key});

  @override
  State<PaymentDetailScreen> createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  final TextEditingController emailController = TextEditingController();
  final List<String> categories = ["カテゴリー名", "カテゴリー名", "カテゴリー名"];
  var state = "request";

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.only(top: 113),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 2,
                                color: AppColors.secondaryGray.withOpacity(0.25)
                              )
                            )
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "依頼金額", 
                                    fontSize: 13, 
                                    fontWeight: FontWeight.bold, 
                                    lineHeight: 1.5, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: "30000", 
                                        fontSize: 16, 
                                        fontWeight: FontWeight.bold, 
                                        lineHeight: 1.5, 
                                        letterSpacing: 1, 
                                        color: AppColors.primaryBlack
                                      ),
                                      CustomText(
                                        text: "円", 
                                        fontSize: 14, 
                                        fontWeight: FontWeight.bold, 
                                        lineHeight: 1.5, 
                                        letterSpacing: 1, 
                                        color: AppColors.primaryBlack
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "消費税（10％）", 
                                    fontSize: 13, 
                                    fontWeight: FontWeight.bold, 
                                    lineHeight: 1.5, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: "3000", 
                                        fontSize: 16, 
                                        fontWeight: FontWeight.bold, 
                                        lineHeight: 1.5, 
                                        letterSpacing: 1, 
                                        color: AppColors.primaryBlack
                                      ),
                                      CustomText(
                                        text: "円", 
                                        fontSize: 14, 
                                        fontWeight: FontWeight.bold, 
                                        lineHeight: 1.5, 
                                        letterSpacing: 1, 
                                        color: AppColors.primaryBlack
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "サービス利用料", 
                                    fontSize: 13, 
                                    fontWeight: FontWeight.bold, 
                                    lineHeight: 1.5, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: "3000", 
                                        fontSize: 16, 
                                        fontWeight: FontWeight.bold, 
                                        lineHeight: 1.5, 
                                        letterSpacing: 1, 
                                        color: AppColors.primaryBlack
                                      ),
                                      CustomText(
                                        text: "円", 
                                        fontSize: 14, 
                                        fontWeight: FontWeight.bold, 
                                        lineHeight: 1.5, 
                                        letterSpacing: 1, 
                                        color: AppColors.primaryBlack
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomText(
                              text: "支払合計：", 
                              fontSize: 15, 
                              fontWeight: FontWeight.bold, 
                              lineHeight: 1.5, 
                              letterSpacing: 1, 
                              color: AppColors.primaryBlack
                            ),
                            Row(
                              children: [
                                CustomText(
                                  text: "36000", 
                                  fontSize: 20, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1.5, 
                                  letterSpacing: 1, 
                                  color: AppColors.primaryBlack
                                ),
                                CustomText(
                                  text: "円", 
                                  fontSize: 14, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1.5, 
                                  letterSpacing: 1, 
                                  color: AppColors.primaryBlack
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
           ),
           Center(
             child: Padding(
              padding: const EdgeInsets.only(top: 44),
              child: CustomText(
                text: "お支払い",
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
                            Navigator.pushNamed(context, "/findpilot");
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const ImageIcon(
                                  AssetImage("assets/images/bx-search.png"),
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
                                ImageIcon(
                                  const AssetImage("assets/images/bx-wallet.png"),
                                  color: AppColors.secondaryBlue,
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
                                  color: AppColors.secondaryBlue
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
        ],
      )
    );
  }
}
