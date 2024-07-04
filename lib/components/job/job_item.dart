import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';

class JobItem extends StatelessWidget{
  const JobItem({
    super.key, required this.prefecture, this.city, required this.isContract, required this.isReported, required this.suggestNum, required this.title, this.salary, this.minSalary, this.maxSalary, required this.time, required this.certification, this.pilotName
  });
  final String title;
  final String prefecture;
  final String? city;
  final bool isContract;
  final bool isReported;
  final int suggestNum;
  final int? salary;
  final int? minSalary;
  final int? maxSalary;
  final String time;
  final String certification;
  final String? pilotName;

  @override
  Widget build(BuildContext context){
    return Container(
      width: 375,
      padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryGray,
            width: 1
          )
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGray,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: CustomText(
                        text: prefecture, 
                        fontSize: 12, 
                        fontWeight: FontWeight.bold, 
                        lineHeight: 1, 
                        letterSpacing: 1, 
                        color: AppColors.primaryBlack
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if(city != null)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGray,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: CustomText(
                          text: city ?? '', 
                          fontSize: 12, 
                          fontWeight: FontWeight.bold, 
                          lineHeight: 1, 
                          letterSpacing: 1, 
                          color: AppColors.primaryBlack
                        ),
                      )
                  ],
                ),
                if(!isContract && suggestNum != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryRed,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: CustomText(
                      text: '応募$suggestNum件', 
                      fontSize: 13, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color: AppColors.primaryWhite
                    ),
                  ),
                if(!isContract && suggestNum == 0)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryGray,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: CustomText(
                      text: '応募なし', 
                      fontSize: 13, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color: AppColors.primaryWhite
                    ),
                  ),
                if(isContract && isReported)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryRed,
                        width: 1
                      )
                    ),
                    child: CustomText(
                      text: '納品報告あり', 
                      fontSize: 13, 
                      fontWeight: FontWeight.bold, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color: AppColors.primaryRed
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:5, top:17, right: 20, bottom: 6),
            child: TextButton(
              onPressed:() {
                Navigator.pushNamed(context, "/clientjobdetail");
              },
              child: Text(
                title,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.secondaryBlue,
                  fontSize: 16,
                  color: AppColors.secondaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
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
                        color: AppColors.secondaryGray
                      )
                    ],
                  ),
                if(minSalary != null && maxSalary != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: '${minSalary.toString()}円', 
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                        lineHeight: 1, 
                        letterSpacing: 1, 
                        color: AppColors.secondaryGray
                      ),
                      CustomText(
                        text: '~', 
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                        lineHeight: 1, 
                        letterSpacing: 10, 
                        color: AppColors.secondaryGray
                      ),
                      CustomText(
                        text: '${maxSalary.toString()}円', 
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                        lineHeight: 1, 
                        letterSpacing: 1, 
                        color: AppColors.secondaryGray
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: '時期：$time', 
                        fontSize: 13, 
                        fontWeight: FontWeight.bold, 
                        lineHeight: 1, 
                        letterSpacing: 2.5, 
                        color: AppColors.primaryBlack
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: '期限：$certification', 
                        fontSize: 13, 
                        fontWeight: FontWeight.bold, 
                        lineHeight: 1, 
                        letterSpacing: 2.5, 
                        color: AppColors.primaryBlack
                      )
                    ],
                  ),
                  if(isContract && pilotName != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ImageIcon(
                          const AssetImage("assets/images/bx-smile.png"),
                          color: AppColors.primaryBlack,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          '依頼先',
                          style: TextStyle(
                            color: AppColors.primaryBlack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          pilotName ?? '',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryBlack,
                            color: AppColors.primaryBlack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  if(isContract)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 105,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.secondaryGray.withOpacity(0.5), // Shadow color
                                  spreadRadius: 0.5, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset: const Offset(0, 1), // Shadow position (x, y)
                                ),
                              ],
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                
                              },
                              child: Center(
                                child: CustomText(
                                  text: 'メッセージ', 
                                  fontSize: 13, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.primaryBlack
                                ),
                              ),
                            ),
                          ),
                          if(isContract && isReported)
                            Row(
                              children: [
                                Container(
                                  width: 105,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryBlue,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.secondaryGray.withOpacity(0.5), // Shadow color
                                        spreadRadius: 0.5, // Spread radius
                                        blurRadius: 5, // Blur radius
                                        offset: const Offset(0, 1), // Shadow position (x, y)
                                      ),
                                    ],
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      
                                    },
                                    child: Center(
                                      child: CustomText(
                                        text: '検収', 
                                        fontSize: 13, 
                                        fontWeight: FontWeight.bold, 
                                        lineHeight: 1, 
                                        letterSpacing: 1, 
                                        color: AppColors.primaryWhite
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 9,
                                ),
                                Container(
                                  width: 105,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryRed,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.secondaryGray.withOpacity(0.5), // Shadow color
                                        spreadRadius: 0.5, // Spread radius
                                        blurRadius: 5, // Blur radius
                                        offset: const Offset(0, 1), // Shadow position (x, y)
                                      ),
                                    ],
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      
                                    },
                                    child: Center(
                                      child: CustomText(
                                        text: '支払', 
                                        fontSize: 13, 
                                        fontWeight: FontWeight.bold, 
                                        lineHeight: 1, 
                                        letterSpacing: 1, 
                                        color: AppColors.primaryWhite
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                            
                        ],
                      ),
                    )
              ],
            ),
          )
        ],
      ),
    );
  }
}