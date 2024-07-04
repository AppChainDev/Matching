
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/components/job/candidate_item.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';

class ClientJobDetailScreen extends StatefulWidget {

  const ClientJobDetailScreen({super.key});

  @override
  State<ClientJobDetailScreen> createState() => _ClientJobDetailScreenState();
}

class _ClientJobDetailScreenState extends State<ClientJobDetailScreen> {
  late final int? salary;
  late final int? minSalary;
  late final int? maxSalary;
  bool isExpanded = false;

  @override
  void initState(){
    setState(() {  
      salary = null;
      minSalary = 30000;
      maxSalary = 50000;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        children: [
           Center(
             child: CustomContainer(
              child: Image.asset(
                "assets/images/jobdeatail_back.png",
                fit: BoxFit.cover
              ),
             ),
           ),
           Center(
            child: CustomContainer(
              child: Padding(
                padding: const EdgeInsets.only(top: 107, bottom: 100),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 5),
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: CustomText(
                                  text: "新潟県", 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.primaryWhite
                                )
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 5),
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: CustomText(
                                  text: "長岡市", 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.primaryWhite
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 50, top: 12),
                        child: CustomText(
                          text: "農地の効果的な管理をするための農薬散布をしていただける方を探しています", 
                          fontSize: 20, 
                          fontWeight: FontWeight.bold, 
                          lineHeight: 1.5, 
                          letterSpacing: -0.5, 
                          color: AppColors.primaryBlack
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Column(
                          children: [
                            if(salary != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: '${salary.toString()}円', 
                                    fontSize: 18, 
                                    fontWeight: FontWeight.bold, 
                                    lineHeight: 1, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  )
                                ],
                              ),
                            if(salary == null && minSalary != null && maxSalary != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: '${minSalary.toString()}円', 
                                    fontSize: 18, 
                                    fontWeight: FontWeight.bold, 
                                    lineHeight: 1, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  ),
                                  CustomText(
                                    text: '~', 
                                    fontSize: 18, 
                                    fontWeight: FontWeight.bold, 
                                    lineHeight: 1, 
                                    letterSpacing: 10, 
                                    color: AppColors.primaryBlack
                                  ),
                                  CustomText(
                                    text: '${maxSalary.toString()}円', 
                                    fontSize: 18, 
                                    fontWeight: FontWeight.bold, 
                                    lineHeight: 1, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  )
                                ],
                              ),
                          ]
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              margin: const EdgeInsets.only(right: 6),
                              child: Image.asset("assets/images/bx-city.png", fit: BoxFit.cover),
                            ),
                            CustomText(
                              text: "依頼カテゴリ", 
                              fontSize: 13, 
                              fontWeight: FontWeight.bold, 
                              lineHeight: 1, 
                              letterSpacing: -1, 
                              color: AppColors.primaryBlack
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomText(
                              text: "農薬散布", 
                              fontSize: 13, 
                              fontWeight: FontWeight.bold, 
                              lineHeight: 1, 
                              letterSpacing: -1, 
                              color: AppColors.primaryBlack
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 15,
                                  height: 15,
                                  margin: const EdgeInsets.only(right: 6),
                                  child: Image.asset("assets/images/bx-calendar-alt.png", fit: BoxFit.cover),
                                ),
                                CustomText(
                                  text: "時期", 
                                  fontSize: 13, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryBlack
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CustomText(
                                  text: "3月下旬", 
                                  fontSize: 13, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryBlack
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 15,
                                  height: 15,
                                  margin: const EdgeInsets.only(right: 6),
                                  child: Image.asset("assets/images/bx-horizontal-right.png", fit: BoxFit.cover),
                                ),
                                CustomText(
                                  text: "期限", 
                                  fontSize: 13, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryBlack
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CustomText(
                                  text: "無し", 
                                  fontSize: 13, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryBlack
                                ),
                              ],
                            )
                            
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:15, left: 20, right: 20),
                        child: Container(
                          padding: const EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: AppColors.primaryGray.withOpacity(0.5),
                                width: 2
                              )
                            )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstrainedBox(
                                constraints: isExpanded?
                                            const BoxConstraints():
                                            const BoxConstraints(maxHeight: 60),
                                child: Text(
                                  ConstFile.jobtext,
                                  style: TextStyle(
                                    color: AppColors.primaryBlack,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: -1,
                                    height: 1.5,
                                    overflow: TextOverflow.fade
                                  ),
                                ),
                              ),
                              Container(
                                width: 110,
                                height: 30,
                                margin: const EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.secondaryGray,
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.primaryWhite,
                                        ),
                                        Text(
                                          "すべて表示",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.primaryWhite,
                                            letterSpacing: -1
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                ),
                              )  
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/bx-smile.png"),
                              color: AppColors.secondaryBlue,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              text: "応募中のパイロット", 
                              fontSize: 14, 
                              fontWeight: FontWeight.bold, 
                              lineHeight: 1, 
                              letterSpacing: 1, 
                              color: AppColors.secondaryBlue
                            )
                          ]
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Column(
                          children: [
                            CandidateItem(
                              name: "パイロットネーム007 ", 
                              text: "貴社が現在募集しているこの案件に関しまして実績と知見がございますので是非ともよろしくお願いいたします。"
                            )
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
             child: Padding(
              padding: const EdgeInsets.only(top: 44),
              child: CustomText(
                text: "依頼詳細",
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
                                  AssetImage("assets/images/bx-search.png")
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
                                ImageIcon(
                                  const AssetImage("assets/images/bx-clipboard.png"),
                                  color: AppColors.secondaryBlue,
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
                                  color: AppColors.secondaryBlue
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
           )
        ],
      )
    );
  }
}


