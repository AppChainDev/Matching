import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomAlert extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color? okButtonColor;
  final Color? cancelButtonColor;
  final VoidCallback onOkClicked;
  final VoidCallback onCancelClicked;
  final VoidCallback onClose;

  const CustomAlert({super.key, required this.text, required this.textColor, required this.onClose, this.okButtonColor, required this.onOkClicked, required this.onCancelClicked, this.cancelButtonColor});

  @override
  Widget build(BuildContext context) {
      
    if(kIsWeb){
      return Center(
        child: Container(
          width: 375,
          height: 812,
          decoration: BoxDecoration(
            color: AppColors.primaryWhite.withOpacity(0.5)
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:10, top: 10),
                  child: Container(
                    width: 256,
                    height: 256,
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      border: Border.all(
                        color: AppColors.primaryWhite
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 23),
                            child: Text(
                              text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                                color: textColor
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                onPressed: onOkClicked,
                                child: Container(
                                  width: 100,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: okButtonColor ?? AppColors.secondaryBlue,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child:Center(
                                    child: CustomText(
                                      text: "はい", 
                                      fontSize: 16, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryWhite
                                    )
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: onCancelClicked,
                                child: Container(
                                  width: 100,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: cancelButtonColor ?? AppColors.secondaryGray,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child:Center(
                                    child: CustomText(
                                      text: "いいえ", 
                                      fontSize: 16, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryWhite
                                    )
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    width: 28,
                    height: 28,
                    // margin: const EdgeInsets.only(top: -10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: 15,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    if (Platform.isAndroid) {   
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: AppColors.primaryWhite.withOpacity(0.5)
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:10, top: 10),
                  child: Container(
                    width: 256,
                    height: 256,
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      border: Border.all(
                        color: AppColors.primaryWhite
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 23),
                            child: Text(
                              text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                                color: textColor
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                onPressed: onOkClicked,
                                child: Container(
                                  width: 100,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: okButtonColor ?? AppColors.secondaryBlue,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child:Center(
                                    child: CustomText(
                                      text: "はい", 
                                      fontSize: 16, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryWhite
                                    )
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: onCancelClicked,
                                child: Container(
                                  width: 100,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: cancelButtonColor ?? AppColors.secondaryGray,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child:Center(
                                    child: CustomText(
                                      text: "いいえ", 
                                      fontSize: 16, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryWhite
                                    )
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    width: 28,
                    height: 28,
                    // margin: const EdgeInsets.only(top: -10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: 15,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }else if(Platform.isIOS){
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: AppColors.primaryWhite.withOpacity(0.5)
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:10, top: 10),
                  child: Container(
                    width: 256,
                    height: 256,
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      border: Border.all(
                        color: AppColors.primaryWhite
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 23),
                            child: Text(
                              text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                                color: textColor
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                onPressed: onOkClicked,
                                child: Container(
                                  width: 100,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: okButtonColor ?? AppColors.secondaryBlue,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child:Center(
                                    child: CustomText(
                                      text: "はい", 
                                      fontSize: 16, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryWhite
                                    )
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: onCancelClicked,
                                child: Container(
                                  width: 100,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: cancelButtonColor ?? AppColors.secondaryGray,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child:Center(
                                    child: CustomText(
                                      text: "いいえ", 
                                      fontSize: 16, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryWhite
                                    )
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    width: 28,
                    height: 28,
                    // margin: const EdgeInsets.only(top: -10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: 15,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: Container(
          width: 375,
          height: 812,
          decoration: BoxDecoration(
            color: AppColors.primaryWhite.withOpacity(0.5)
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:10, top: 10),
                  child: Container(
                    width: 256,
                    height: 256,
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      border: Border.all(
                        color: AppColors.primaryWhite
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 23),
                            child: Text(
                              text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                                color: textColor
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                onPressed: onOkClicked,
                                child: Container(
                                  width: 100,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: okButtonColor ?? AppColors.secondaryBlue,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child:Center(
                                    child: CustomText(
                                      text: "はい", 
                                      fontSize: 16, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryWhite
                                    )
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: onCancelClicked,
                                child: Container(
                                  width: 100,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: cancelButtonColor ?? AppColors.secondaryGray,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child:Center(
                                    child: CustomText(
                                      text: "いいえ", 
                                      fontSize: 16, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryWhite
                                    )
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    width: 28,
                    height: 28,
                    // margin: const EdgeInsets.only(top: -10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: 15,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}