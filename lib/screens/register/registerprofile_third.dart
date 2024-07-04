import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/components/picker/cupertinopicker.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';

class RegisterProfileThirdScreen extends StatefulWidget {

  const RegisterProfileThirdScreen({super.key});

  @override
  State<RegisterProfileThirdScreen> createState() => _RegisterProfileThirdScreenState();
}

class _RegisterProfileThirdScreenState extends State<RegisterProfileThirdScreen> {

  final TextEditingController prefectureController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController bodyTypeController = TextEditingController();
  final TextEditingController attitudeController = TextEditingController();
  int gender = 0;
  int prefecture = 0;
  int height = 0;
  int bodyType = 0;
  int attitude = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleCartChanged(int id) {
    setState(() {
      gender = id;
    });
  }
  void changePrefecture(int index) {
    setState(() {
      prefecture = index;
      prefectureController.text = ConstFile.prefectureItems[index]; 
    });
  }

  void changeHeight(int index) {
    setState(() {
      height = 100 + index;
      heightController.text = '${100 + index}cm'; 
    });
  }
  
  void changebodyType(int index) {
    setState(() {
      bodyType = index;
      bodyTypeController.text = ConstFile.bodyTypes[index];
    });
  }

  void attitudeChange(int index) {
    setState(() {
      attitude = index;
      attitudeController.text = ConstFile.attitudes[index];
    });
  }

  bool isCompleted(){
    if(gender != 0 && prefectureController.text.isNotEmpty && heightController.text.isNotEmpty && bodyTypeController.text.isNotEmpty && attitudeController.text.isNotEmpty){
      return true;
    } else {
      return false;
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
                  Padding(
                    padding: const EdgeInsets.only(top: 120, left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
// ------------------gender---------------------------
                            CustomText(
                              text: "性別", 
                              fontSize: 13, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1, 
                              letterSpacing: 1, 
                              color: AppColors.primaryBlack
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _handleCartChanged(1);
                                  },
                                  child: GenderItem(
                                    inChecked: gender == 1? true : false, 
                                    id: 1, 
                                    text: "男性"
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _handleCartChanged(2);
                                  },
                                  child: GenderItem(
                                    inChecked: gender == 2? true : false, 
                                    id: 2, 
                                    text: "女性"
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
// ------------------prefecture---------------------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "居住地", 
                              fontSize: 13, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1, 
                              letterSpacing: 1, 
                              color: AppColors.primaryBlack
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                readOnly: true,
                                controller: prefectureController,
                                style: TextStyle(
                                  color: AppColors.secondaryGreen
                                ),
                                decoration: InputDecoration(
                                  hintText: "選択してください",
                                  focusColor: AppColors.secondaryGreen,
                                  contentPadding: const EdgeInsets.all(10),
                                  suffixIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                                
                                onTap: () async {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext builder) {
                                        return Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryWhite,
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                                            ),
                                            height: MediaQuery.of(context).copyWith().size.height / 3,
                                            child: CustomCupertinoPicker(
                                              items: ConstFile.prefectureItems, 
                                              onSelectedItemChanged: (int index){
                                                changePrefecture(index);
                                              },
                                            )
                                          );
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
// ------------------height---------------------------
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "身長", 
                              fontSize: 13, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1, 
                              letterSpacing: 1, 
                              color: AppColors.primaryBlack
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                readOnly: true,
                                controller: heightController,
                                style: TextStyle(
                                  color: AppColors.secondaryGreen
                                ),
                                decoration: InputDecoration(
                                  hintText: "選択してください",
                                  contentPadding: const EdgeInsets.all(10),
                                  suffixIcon: const Icon(
                                    Icons.keyboard_arrow_down_rounded
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),                              
                                onTap: () async {
                                  List<String> values = List.generate(80, (index) => '${130 + index}cm');
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext builder) {
                                        return Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryWhite,
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                                            ),
                                            height: MediaQuery.of(context).copyWith().size.height / 3,
                                            child: CustomCupertinoPicker(
                                              items: values, 
                                              onSelectedItemChanged: (int index){
                                                changeHeight(index);
                                              }
                                            )
                                          );
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
// ------------------bodyType---------------------------                       
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "体型", 
                              fontSize: 13, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1, 
                              letterSpacing: 1, 
                              color: AppColors.primaryBlack
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                readOnly: true,
                                controller: bodyTypeController,
                                style: TextStyle(
                                  color: AppColors.secondaryGreen
                                ),
                                decoration: InputDecoration(
                                  hintText: "選択してください",
                                  contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),                              
                                onTap: () async {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext builder) {
                                        return Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryWhite,
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                                            ),
                                            height: MediaQuery.of(context).copyWith().size.height / 3,
                                            child: CustomCupertinoPicker(
                                              items: ConstFile.bodyTypes, 
                                              onSelectedItemChanged: (int index){
                                                changebodyType(index);
                                              }
                                            )
                                          );
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
// ------------------attitude---------------------------                       
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "結婚に対する意識", 
                              fontSize: 13, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1, 
                              letterSpacing: 1, 
                              color: AppColors.primaryBlack
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            SizedBox(
                              height: 40,
                              child: TextField(
                                readOnly: true,
                                controller: attitudeController,
                                style: TextStyle(
                                  color: AppColors.secondaryGreen
                                ),
                                decoration: InputDecoration(
                                  hintText: "選択してください",
                                  contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),                              
                                onTap: () async {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext builder) {
                                        return Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryWhite,
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                                            ),
                                            height: MediaQuery.of(context).copyWith().size.height / 3,
                                            child: CustomCupertinoPicker(
                                              items: ConstFile.attitudes, 
                                              onSelectedItemChanged: (int index){
                                                attitudeChange(index);
                                              }
                                            )
                                          );
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                 ],
               ),
             ),
           ),
           
           Center(
            child: CustomContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22),
                    child: CustomButton(
                      title: "つぎへ",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: isCompleted()?AppColors.secondaryGreen:AppColors.secondaryGreen.withOpacity(0.5), 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () async{ 
                        if(isCompleted()){
                          Navigator.pushNamed(context, "/registerprofile_photo");
                        }     
                      }
                    ),
                  ),
                ],
              ),
            ),
           ),
           Center(
            child: CustomContainer(
              height: 94,
              decoration: BoxDecoration(
                color: AppColors.secondaryGreen
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      text: "プロフィール登録", 
                      fontSize: 17, 
                      fontWeight: FontWeight.bold, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color: AppColors.primaryWhite
                    ),
                  ],
                ),
              ),
            ),
          ),
           Center(
            child: CustomContainer(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(top:46),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColors.primaryWhite,
                      )
                    ),
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


class GenderItem extends StatelessWidget {
  const GenderItem({super.key, required this.inChecked, required this.id, required this.text});
  
  final int id;
  final String text;
  final bool inChecked;

  Color getBackColor(BuildContext context) {
    return inChecked ? AppColors.secondaryGreen : AppColors.primaryWhite;
  }
  Color getBorderColor(BuildContext context) {
    return inChecked ? Colors.transparent : AppColors.secondaryGray;
  }
  Color getTextColor(BuildContext context) {
    return inChecked ? AppColors.primaryWhite : AppColors.secondaryGray;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: getBorderColor(context)
        ),
        color: getBackColor(context)
      ),
      width: 93,
      height: 35,
      child: Center(
        child: CustomText(
          text: text, 
          fontSize: 13, 
          fontWeight: FontWeight.normal, 
          lineHeight: 1, 
          letterSpacing: 1, 
          color: getTextColor(context)
        ),
      ),
    );
  }
}
