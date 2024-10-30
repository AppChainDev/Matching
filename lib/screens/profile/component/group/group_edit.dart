import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/models/community_model.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupEditScreen extends StatefulWidget {

  const GroupEditScreen({super.key});

  @override
  State<GroupEditScreen> createState() => _GroupEditScreenState();
}

class _GroupEditScreenState extends State<GroupEditScreen> {
  List<int> userGroups = [];
  List<CommunityModel> groups = [];
  bool isLoding = false;

  List<int> removeGroups = [];

  @override
  void initState() {
    getGroup();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getGroup() async{
    setState(() {
      userGroups = Provider.of<UserState>(context, listen: false).user!.groups;
      groups = Provider.of<UserState>(context, listen: false).groups;
      isLoding = true;
    });
  }
  
  void handleCommunityChanged(int id) {
    setState(() {
      if(removeGroups.contains(id)){
        removeGroups.remove(id);
      }else{
        removeGroups.add(id);
      }
    });
  }

  Future removeGroup() async{
    final result = await Provider.of<UserState>(context, listen: false).removeGroups(removeGroups);
    if(result){
      await Provider.of<UserState>(context, listen: false).getUserInformation();
      Navigator.pushNamed(context, "/edit_profile");
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => Center( // Aligns the container to center
          child: Container( // A simplified version of dialog. 
            width: 300,
            height: 150,
            padding: const EdgeInsets.only(top:35),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryWhite
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "グループ情報の削除に失敗しました。",
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontWeight: FontWeight.normal,
                    fontSize:15,
                    letterSpacing: -1,
                    decoration: TextDecoration.none
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 343,
                    height: 42,
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: AppColors.secondaryGray.withOpacity(0.5)
                        )
                      )
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: CustomText(
                          text: "OK", 
                          fontSize: 15, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: -1, 
                          color: AppColors.alertBlue
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            )
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: isLoding? Stack(
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
                        removeGroup();
                          // Navigator.pop(context);     
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
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 13,
                              children: userGroups.map((groupId){
                                return  GestureDetector(
                                  onTap: () {
                                    handleCommunityChanged(groupId);
                                  },
                                  child: DeleteGroupItem(
                                    inChecked: removeGroups.contains(groupId), 
                                    id: 1, 
                                    text: (groups.where((e) => e.id == groupId).toList())[0].name, 
                                    image: (groups.where((e) => e.id == groupId).toList())[0].image
                                  ),
                                );
                              }).toList()
                            ),
                          ]
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
      ):const CustomContainer(
        child: Center(
          child: CircularProgressIndicator(),
        ),
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
                if(inChecked)
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
