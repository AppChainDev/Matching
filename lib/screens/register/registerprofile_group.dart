import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';

class RegisterProfileGroupScreen extends StatefulWidget {

  const RegisterProfileGroupScreen({super.key});

  @override
  State<RegisterProfileGroupScreen> createState() => _RegisterProfileGroupScreenState();
}

class _RegisterProfileGroupScreenState extends State<RegisterProfileGroupScreen> {
  final List<int> community1 = [];
  final List<int> community2 = [];
  final List<int> community3 = [];
  final List<int> community4 = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  void handleCommunityChanged1(int id) {
    setState(() {
      community1.clear();
      community1.add(id);
    });
  }
  void handleCommunityChanged2(int id) {
    setState(() {
      community2.clear();
      community2.add(id);
    });
  }
  void handleCommunityChanged3(int id) {
    setState(() {
      community3.clear();
      community3.add(id);
    });
  }
  void handleCommunityChanged4(int id) {
    setState(() {
      community4.clear();
      community4.add(id);
    });
  }
  bool isCompleted(){
    if(community1.isNotEmpty && community2.isNotEmpty && community3.isNotEmpty && community4.isNotEmpty){
      return true;
    }else{
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
                      color: isCompleted()?AppColors.secondaryGreen : AppColors.secondaryGreen.withOpacity(0.5), 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () { 
                        if(isCompleted()){
                          Navigator.pushNamed(context, "/preference");
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
              height: MediaQuery.of(context).size.height - 70,
               child: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.only(top:227, bottom: 50),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
// ---------sport-------------
                      Padding(
                        padding: const EdgeInsets.only(top:20, left: 30, right: 30, bottom: 10),
                        child: CustomText(
                          text: "趣味", 
                          fontSize: 12, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: 1, 
                          color: AppColors.primaryBlack
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 38, right: 38),
                        child: Column(
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 13,
                              children: ConstFile.sportsGroupDatas.map((data){
                                return GestureDetector(
                                  onTap: () {
                                    handleCommunityChanged1(data.id);
                                  },
                                  child: GroupItem(
                                    inChecked: community1.contains(data.id), 
                                    id: data.id, 
                                    text: data.text, 
                                    image: data.image
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
// ---------personality-------------
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                        child: CustomText(
                          text: "性格", 
                          fontSize: 12, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: 1, 
                          color: AppColors.primaryBlack
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 38, right: 38),
                        child: Column(
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 13,
                              children: ConstFile.personalityGroupDatas.map((data){
                                return GestureDetector(
                                  onTap: () {
                                    handleCommunityChanged2(data.id);
                                  },
                                  child: GroupItem(
                                    inChecked: community2.contains(data.id), 
                                    id: data.id, 
                                    text: data.text, 
                                    image: data.image
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
// ---------outing detail-------------
                      Padding(
                        padding: const EdgeInsets.only(top:20, left: 30, right: 30, bottom: 10),
                        child: CustomText(
                          text: "おでかけ内容", 
                          fontSize: 12, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: 1, 
                          color: AppColors.primaryBlack
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 38, right: 38),
                        child: Column(
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 13,
                              children: ConstFile.outingDetailDatas.map((data){
                                return GestureDetector(
                                  onTap: () {
                                    handleCommunityChanged3(data.id);
                                  },
                                  child: GroupItem(
                                    inChecked: community3.contains(data.id), 
                                    id: data.id, 
                                    text: data.text, 
                                    image: data.image
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
// ---------lifeStyle-------------
                      Padding(
                        padding: const EdgeInsets.only(top:20, left: 30, right: 30, bottom: 10),
                        child: CustomText(
                          text: "ライフスタイル", 
                          fontSize: 12, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: 1, 
                          color: AppColors.primaryBlack
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 38, right: 38),
                        child: Column(
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 13,
                              children: ConstFile.lifeStyleDatas.map((data){
                                return GestureDetector(
                                  onTap: () {
                                    handleCommunityChanged4(data.id);
                                  },
                                  child: GroupItem(
                                    inChecked: community4.contains(data.id), 
                                    id: data.id, 
                                    text: data.text, 
                                    image: data.image
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                     ],
                   ),
                 ),
               ),
             ),
           ),

           Center(
            child: CustomContainer(
              height: 227,
              decoration: BoxDecoration(
                color: AppColors.primaryWhite
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 108, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [                       
                        CustomText(
                          text: "興味のあるコミュニティーを\n3つ選んでください", 
                          fontSize: 24, 
                          fontWeight: FontWeight.bold, 
                          lineHeight: 1.5, 
                          letterSpacing: -1, 
                          color: AppColors.primaryBlack
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: "同じコミュニティに所属する気の合う人が見つかります", 
                          fontSize: 12, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: -1, 
                          color: AppColors.primaryBlack
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
                      text: "コミュニティー", 
                      fontSize: 17, 
                      fontWeight: FontWeight.bold, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color:AppColors.primaryWhite
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

typedef CartChangedCallback = Function(int id);

class GroupItem extends StatelessWidget {
  const GroupItem({super.key, required this.inChecked, required this.id, required this.text, required this.image});
  
  final int id;
  final String image;
  final String text;
  final bool inChecked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            width: 95,
            height: 65,
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/$image",
                  fit: BoxFit.cover
                ),
                if(inChecked)
                  Center(
                    child: SizedBox(
                      width: 34,
                      height: 34,
                      child: Image.asset(
                        "assets/images/select.png",
                        fit: BoxFit.cover
                      )
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomText(
            text: text, 
            fontSize: 9, 
            fontWeight: FontWeight.normal, 
            lineHeight: 1, 
            letterSpacing: 1, 
            color: AppColors.primaryBlack
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
