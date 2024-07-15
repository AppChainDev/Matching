import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:flutter/material.dart';

class IntroduceScreen extends StatefulWidget {
  const IntroduceScreen({super.key});

  @override
  State<IntroduceScreen> createState() => _IntroduceScreenState();
}

class _IntroduceScreenState extends State<IntroduceScreen> {
  final TextEditingController introduceController = TextEditingController();
  int textCount = 0;

  @override
  void initState() {
    super.initState();
    introduceController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    introduceController.removeListener(_updateButtonColor);
    introduceController.dispose();
    super.dispose();
  }

  void _updateButtonColor() {
    setState(() {
      textCount = introduceController.text.length;
    });
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
                color: AppColors.primaryWhite,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 122),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhite,
                      ),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: introduceController,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            cursorColor: AppColors.primaryBlack,
                            style: TextStyle(color: AppColors.primaryBlack),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsets.all(15),
                              fillColor: AppColors.primaryWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: bottomInset),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 20,
                        bottom: bottomInset!=0?bottomInset+10:20
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                            text: "$textCount/150文字", 
                            fontSize: 12, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: 1, 
                            color: AppColors.primaryBlack.withOpacity(0.5)
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          Center(
            child: CustomContainer(
              height: 94,
              decoration: BoxDecoration(
                color: AppColors.secondaryGreen,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                            text: "自己紹介入力",
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            lineHeight: 1,
                            letterSpacing: 1,
                            color: AppColors.primaryWhite,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Container(
                                  width: 93,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryWhite,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      // if(textCount < 150){
                                      //   showDialog(
                                      //     context: context,
                                      //     builder: (context) => AlertDialog(
                                      //       content: Padding(
                                      //         padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                                      //         child:Text(
                                      //           "150文字以上の\n自己紹介文を書いてください。", 
                                      //           textAlign: TextAlign.center,
                                      //           style: TextStyle(
                                      //             fontSize: 18, 
                                      //             fontWeight: FontWeight.normal,
                                      //             color: AppColors.primaryBlack,
                                      //             letterSpacing: -1
                                      //           ),
                                      //         )
                                      //       ),
                                      //       actions: [
                                      //         Container(
                                      //           decoration: BoxDecoration(
                                      //             border: Border(
                                      //               top: BorderSide(
                                      //                 width: 2,
                                      //                 color: AppColors.primaryGray
                                      //               )
                                      //             )
                                      //           ),
                                      //           child: Center(
                                      //             child: TextButton(
                                      //               onPressed: () => Navigator.pop(context),
                                      //               child: TextButton(
                                      //                 onPressed: (){
                                      //                   Navigator.pop(context);
                                      //                 }, 
                                      //                 child: CustomText(
                                      //                   text: "OK", 
                                      //                   fontSize: 20, 
                                      //                   fontWeight: FontWeight.bold, 
                                      //                   lineHeight: 1, 
                                      //                   letterSpacing: 1, 
                                      //                   color: AppColors.primaryBlue
                                      //                 )
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   );
                                      // }else{
                                      //   Navigator.pushNamed(context, "/malemypage");
                                      // }
                                        // Navigator.pop(context);
                                        
                                        Navigator.pushNamed(context, "/malemypage");
                                    },
                                    child: Center(
                                      child: Text(
                                        "保 存",
                                        style: TextStyle(
                                          color: AppColors.secondaryGreen,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}