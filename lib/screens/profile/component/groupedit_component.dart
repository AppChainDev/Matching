import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/models/community_model.dart';
import 'package:rinlin/screens/register/registerprofile_group.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupEditWidget extends StatefulWidget{
  const GroupEditWidget({
    super.key
 });

  @override
  State<GroupEditWidget> createState() => _GroupEditWidgetState();
}

class _GroupEditWidgetState extends State<GroupEditWidget> {
  late List<int> userGroups;
  List<CommunityModel> groups = [];
  bool isLoding = false;

  @override
  void initState() {
    getGroup();
    super.initState();
  }

  Future getGroup() async{
    await Provider.of<UserState>(context, listen: false).getGroupList();
    setState(() {
      userGroups = Provider.of<UserState>(context, listen: false).user!.groups;
      groups = Provider.of<UserState>(context, listen: false).groups;
      isLoding = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 100),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(20)
      ),
      child: isLoding? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "参加グループ", 
            fontSize: 15, 
            fontWeight: FontWeight.normal, 
            lineHeight: 1.5, 
            letterSpacing: 1, 
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
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: userGroups.map((groupId){
                return GroupItem(
                  inChecked: false, 
                  id: groupId, 
                  text: (groups.where((e) => e.id == groupId).toList())[0].name, 
                  image: (groups.where((e) => e.id == groupId).toList())[0].image
                );
              }).toList()
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Container(
                width: 170,
                height: 47,
                decoration: BoxDecoration(
                  color: AppColors.secondaryGreen,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/edit_group");
                  },
                  child: Center(
                    child: CustomText(
                      text: "編集", 
                      fontSize: 14, 
                      fontWeight: FontWeight.normal, 
                      lineHeight: 1, 
                      letterSpacing: 1, 
                      color: AppColors.primaryWhite
                    ),
                  ),
                ),
              ),
            ),
          )
          
        ],
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

