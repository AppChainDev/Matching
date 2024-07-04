
// ignore_for_file: unnecessary_null_comparison
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/requestjop_model.dart';
import 'package:drone/models/requestjopsuccess_model.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class RequestConfirmScreen extends StatefulWidget {

  const RequestConfirmScreen({super.key});

  @override
  State<RequestConfirmScreen> createState() => _RequestConfirmScreenState();
}

class _RequestConfirmScreenState extends State<RequestConfirmScreen> {
  final TextEditingController emailController = TextEditingController();
  final List<String> prefectureItems = ConstFile.prefectureItems;
  final List<String> categories = ["なし", "カテゴリー名1", "カテゴリー名2", "カテゴリー名3"];
  int selectedPrefectureValue = 0;
  int selectedCategoryValue = 0;
  bool selectedrequestDeadline = false;
  int selectedstartDate = 1;
  final List<int> yearItems = List<int>.generate(101, (index) => 1950 + index);
  final List<int> monthItems = List<int>.generate(12, (index) => 1 + index);
  final List<int> dayItems = List<int>.generate(31, (index) => 1 + index);
  int selectedYearValue = DateTime.now().year;
  int selectedMonthValue = DateTime.now().month;
  int selectedDayValue = DateTime.now().day;

  final TextEditingController bugetController = TextEditingController();
  final TextEditingController salaryMinController = TextEditingController();
  final TextEditingController salaryMaxController = TextEditingController();
  final TextEditingController introduceController = TextEditingController();
  
  DateTime? startMinDate;
  DateTime? startMaxDate;

  Widget renderCagetory(List<ValueItem> selectedCategoryList) {
    if(selectedCategoryList.isNotEmpty){
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 6.6,
        children: selectedCategoryList.map((category){
          return Padding(
            padding: const EdgeInsets.only(right: 5),
            child: CustomText(
              text: category.label, 
              fontSize: 14, 
              fontWeight: FontWeight.bold, 
              lineHeight: 1, 
              letterSpacing: 1, 
              color: AppColors.primaryBlack
            ),
          );
        }).toList(),
      );
    }else{
      return(
        CustomText(
          text: "なし", 
          fontSize: 14, 
          fontWeight: FontWeight.bold, 
          lineHeight: 1, 
          letterSpacing: 1, 
          color: AppColors.primaryBlack
        )
      );
    }
  }

   Widget renderDeadline(bool requestDeadline, int deadlineYear, int deadlineMonth, int deadlineDay){
    if(requestDeadline){
      return(
        CustomText(
          text: "期限あり($deadlineYear年$deadlineMonth月$deadlineDay日)", 
          fontSize: 14, 
          fontWeight: FontWeight.bold, 
          lineHeight: 1, 
          letterSpacing: 1, 
          color: AppColors.primaryBlack
        )
      );
    }else{
      return CustomText(
          text: "期限なし", 
          fontSize: 14, 
          fontWeight: FontWeight.bold, 
          lineHeight: 1, 
          letterSpacing: 1, 
          color: AppColors.primaryBlack
      );
    }
   }

  Widget renderSalary(int salaryType, int salary, int salaryMin, int salaryMax){
    if(salaryType==1){
      return CustomText(
        text: "$salary円", 
        fontSize: 14, 
        fontWeight: FontWeight.bold, 
        lineHeight: 1, 
        letterSpacing: 1, 
        color: AppColors.primaryBlack
      );
    }else{
      return CustomText(
        text: "$salaryMin円 ~ $salaryMax円", 
        fontSize: 14, 
        fontWeight: FontWeight.bold, 
        lineHeight: 1, 
        letterSpacing: 1, 
        color: AppColors.primaryBlack
      );
    }
  }

  Widget renderStartDate(int selectedstartDate, String startMinDate, String startMaxDate){
    if(selectedstartDate == 1){
      if(startMinDate != 'null'){
        return CustomText(
          text: "日付指定(${DateTime.parse(startMinDate).year}年${DateTime.parse(startMinDate).month}月${DateTime.parse(startMinDate).day}日)", 
          // text: "startMinDate",
          fontSize: 14, 
          fontWeight: FontWeight.bold, 
          lineHeight: 1, 
          letterSpacing: 1, 
          color: AppColors.primaryBlack
        );
      }else{
        return CustomText(
          text: "未定", 
          fontSize: 14, 
          fontWeight: FontWeight.bold, 
          lineHeight: 1, 
          letterSpacing: 1, 
          color: AppColors.primaryBlack
        );
      }
    } else if(selectedstartDate == 2){
      if(startMinDate!='null' && startMaxDate!='null'){
        return CustomText(
          text: "(${DateTime.parse(startMinDate).year}年${DateTime.parse(startMinDate).month}月${DateTime.parse(startMinDate).day}日 ~ ${DateTime.parse(startMaxDate).year}年${DateTime.parse(startMaxDate).month}月${DateTime.parse(startMaxDate).day}日)",
          fontSize: 14, 
          fontWeight: FontWeight.bold, 
          lineHeight: 1, 
          letterSpacing: 1, 
          color: AppColors.primaryBlack
        );
      }else{
        return CustomText(
          text: "未定", 
          fontSize: 14, 
          fontWeight: FontWeight.bold, 
          lineHeight: 1, 
          letterSpacing: 1, 
          color: AppColors.primaryBlack
        );
      }
    } else {
      return CustomText(
        text: "未定", 
        fontSize: 14, 
        fontWeight: FontWeight.bold, 
        lineHeight: 1, 
        letterSpacing: 1, 
        color: AppColors.primaryBlack
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RequestJobModel;
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
                        child: SizedBox(
                          width: 375,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 103, left: 20, right: 20, bottom: 81),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: "カテゴリ", 
                                          fontSize: 13, 
                                          fontWeight: FontWeight.bold, 
                                          lineHeight: 1, 
                                          color: AppColors.secondaryGray,
                                          letterSpacing: 1,
                                        ),
                                        const SizedBox(
                                          height: 9,
                                        ),
                                        renderCagetory(args.selectedCategoryList),
                                        // 
                                      ]
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 21.6,
                                ),
                                //----------- address --------------
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "エリア", 
                                      fontSize: 13, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      color: AppColors.secondaryGray,
                                      letterSpacing: 1,
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: prefectureItems[args.prefectureValue]+args.city!, 
                                          fontSize: 13, 
                                          fontWeight: FontWeight.bold, 
                                          lineHeight: 1, 
                                          letterSpacing: 1, 
                                          color: AppColors.primaryBlack
                                        )
                                      ],
                                    )
                                  ]
                                ),
                                const SizedBox(
                                  height: 21.6,
                                ),
                                //----------- request deadline --------------
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "募集期限", 
                                      fontSize: 13, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      color: AppColors.secondaryGray,
                                      letterSpacing: 1,
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        renderDeadline(args.requestDeadline, args.deadlineYear, args.deadlineMonth, args.deadlineDay)
                                      ],
                                    ),
                                  ]
                                ),
                                const SizedBox(
                                  height: 21.6,
                                ),
// ---------ammount---------------
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "依頼金額", 
                                      fontSize: 13, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      color: AppColors.secondaryGray,
                                      letterSpacing: 1,
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        renderSalary(args.salaryType, args.salary!, args.salaryMin!, args.salaryMax!)
                                      ],
                                    ),
                                  ]
                                ),
                                const SizedBox(
                                  height: 21.6,
                                ), 
                            //----------- start date --------------
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "募集期限", 
                                      fontSize: 13, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      color: AppColors.secondaryGray,
                                      letterSpacing: 1,
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        renderStartDate(args.selectedstartDate, args.startMinDate!, args.startMaxDate!)
                                      ],
                                    ),
                                  ]
                                ),
                                const SizedBox(
                                  height: 22.7,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "紹介文", 
                                        fontSize: 13, 
                                        fontWeight: FontWeight.bold, 
                                        lineHeight: 1, 
                                        color: AppColors.secondaryGray,
                                        letterSpacing: 1,
                                      ),
                                      const SizedBox(
                                        height: 9,
                                      ),
                                      CustomText(
                                        text: args.introduce, 
                                        fontSize: 13, 
                                        fontWeight: FontWeight.bold, 
                                        lineHeight: 1.5, 
                                        letterSpacing: 1, 
                                        color: AppColors.primaryBlack
                                      )
                                    ]
                                  ),
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 36.5
                                    ),
                                    CustomButton(
                                      title: "依頼する", 
                                      width: 296, 
                                      fontSize: 16, 
                                      fontWeight: FontWeight.bold, 
                                      color: AppColors.secondaryBlue, 
                                      borderColor: AppColors.secondaryBlue, 
                                      titleColor: AppColors.primaryWhite, 
                                      onTap: (){
                                        Navigator.pushNamed(context, "/requestsuccess", arguments: RequestJobSuccessModel(args.name, args.introduce, id: args.id));
                                      }
                                    ),
                                    const SizedBox(
                                      height: 20
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: Container(
                                        width: 296,
                                        transformAlignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(width: 2, color:AppColors.secondaryGray)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 50.0,
                                            right: 50.0,
                                            top: 20.0,
                                            bottom: 20.0,
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.arrow_back_ios,
                                                  color: AppColors.secondaryGray,
                                                ),
                                                Text(
                                                  "戻る",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.secondaryGray
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // CustomButton(
                                    //   title: "< 戻る", 
                                    //   width: 296, 
                                    //   fontSize: 16, 
                                    //   fontWeight: FontWeight.bold, 
                                    //   color: AppColors.secondaryGray.withOpacity(0), 
                                    //   borderColor: AppColors.secondaryGray, 
                                    //   titleColor: AppColors.secondaryGray, 
                                    //   onTap: (){
                                        
                                    //   }
                                    // ),
                                  ],
                                )
                                
                                
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
                text: "案件依頼",
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
        ],
      )
    );
  }
}
