import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';

class GroupEditScreen extends StatefulWidget {

  const GroupEditScreen({super.key});

  @override
  State<GroupEditScreen> createState() => _GroupEditScreenState();
}

class _GroupEditScreenState extends State<GroupEditScreen> {
  final List<int> community1 = [1];
  final List<int> community2 = [1];
  final List<int> community3 = [1];
  final List<int> community4 = [1];
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
      if(community1.contains(id)){
        community1.clear();
      }else{
         community1.add(id);
      }
    });
  }
  void handleCommunityChanged2(int id) {
    setState(() {
      if(community2.contains(id)){
        community2.clear();
      }else{
         community2.add(id);
      }
    });
  }
  void handleCommunityChanged3(int id) {
    setState(() {
      if(community3.contains(id)){
        community3.clear();
      }else{
         community3.add(id);
      }
    });
  }
  void handleCommunityChanged4(int id) {
    setState(() {
      if(community4.contains(id)){
        community4.clear();
      }else{
         community4.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        children: [
           Center(
            child: CustomContainer(
              decoration: BoxDecoration(
                color: AppColors.primaryBackground
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
                          text: "参加コミュニティー", 
                          fontSize: 17, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1.5, 
                          letterSpacing: -1, 
                          color: AppColors.primaryBlack
                        ),
                        CustomText(
                          text: "設定するほど、マッチング率が向上します", 
                          fontSize: 12, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: 1, 
                          color: AppColors.secondaryGray
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
              decoration: const BoxDecoration(
                color: Colors.transparent
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: CustomButton(
                      title: "保存",
                      width: 343,
                      height: 45,
                      fontSize: 17, 
                      fontWeight: FontWeight.normal, 
                      color: AppColors.secondaryGreen, 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () { 
                          Navigator.pop(context);     
                      }
                    ),
                  ),
                ],
              ),
            ),
           ),
           Center(
             child: CustomContainer(
               child: Padding(
                 padding: const EdgeInsets.only(top:200, bottom: 50),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 20, right: 38),
                        child: Column(
                          children: [
                            // Wrap(
                            //   crossAxisAlignment: WrapCrossAlignment.start,
                            //   spacing: 13,
                            //   children: [
                            //     GestureDetector(
                            //       onTap: () {
                            //         handleCommunityChanged1(1);
                            //       },
                            //       child: DeleteGroupItem(
                            //         inChecked: community1.contains(1), 
                            //         id: 1, 
                            //         text: ConstFile.sportsGroupDatas[1].name, 
                            //         image: ConstFile.sportsGroupDatas[1].image
                            //       ),
                            //     ),
                            //     GestureDetector(
                            //       onTap: () {
                            //         handleCommunityChanged2(1);
                            //       },
                            //       child: DeleteGroupItem(
                            //         inChecked: community2.contains(1), 
                            //         id: 1, 
                            //         text: ConstFile.personalityGroupDatas[1].name, 
                            //         image: ConstFile.personalityGroupDatas[1].image
                            //       ),
                            //     ),
                            //     GestureDetector(
                            //       onTap: () {
                            //         handleCommunityChanged3(1);
                            //       },
                            //       child: DeleteGroupItem(
                            //         inChecked: community3.contains(1), 
                            //         id: 1, 
                            //         text: ConstFile.outingDetailDatas[1].name, 
                            //         image: ConstFile.outingDetailDatas[1].image
                            //       ),
                            //     ),
                            //     GestureDetector(
                            //       onTap: () {
                            //         handleCommunityChanged4(1);
                            //       },
                            //       child: DeleteGroupItem(
                            //         inChecked: community4.contains(1), 
                            //         id: 1, 
                            //         text: ConstFile.lifeStyleDatas[1].name, 
                            //         image: ConstFile.lifeStyleDatas[1].image
                            //       ),
                            //     ),
                            //   ],
                            // ),
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
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CustomContainer(
                height: 94,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
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

class DeleteGroupItem extends StatelessWidget {
  const DeleteGroupItem({super.key, required this.inChecked, required this.id, required this.text, required this.image});
  
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
                if(!inChecked)
                  Container(
                    width: 95,
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.secondaryGreen.withOpacity(0.8)
                    ),
                    child: Center(
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.primaryWhite
                        ),
                        child: Icon(
                          Icons.close,
                          color: AppColors.secondaryGreen,
                        )
                      ),
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
