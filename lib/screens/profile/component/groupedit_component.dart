import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/screens/register/registerprofile_group.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';

class GroupEditWidget extends StatefulWidget{
  const GroupEditWidget({
    super.key
 });

  @override
  State<GroupEditWidget> createState() => _GroupEditWidgetState();
}

class _GroupEditWidgetState extends State<GroupEditWidget> {
  final int community1 = 1;
  final int community2 = 1;
  final int community3 = 1;
  final int community4 = 1;

  @override
  void initState() {
    super.initState();
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
      child: Column(
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
              children: [
                GroupItem(
                  inChecked: false, 
                  id: community1, 
                  text: ConstFile.sportsGroupDatas[community1].text, 
                  image: ConstFile.sportsGroupDatas[community1].image
                ),
                GroupItem(
                  inChecked: false, 
                  id: community2, 
                  text: ConstFile.personalityGroupDatas[community2].text, 
                  image: ConstFile.personalityGroupDatas[community2].image
                ),
                GroupItem(
                  inChecked: false, 
                  id: community3, 
                  text: ConstFile.outingDetailDatas[community3].text, 
                  image: ConstFile.outingDetailDatas[community3].image
                ),
                GroupItem(
                  inChecked: false, 
                  id: community4, 
                  text: ConstFile.lifeStyleDatas[community4].text, 
                  image: ConstFile.lifeStyleDatas[community4].image
                )
              ],
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
      ),
    );
  }
}

class MemoriesImageDescriptionItem extends StatelessWidget{
  const MemoriesImageDescriptionItem({
    super.key
 });

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 14, left: 10, right: 10, bottom: 14),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.secondaryGray,
        ),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.secondaryGreen,
                borderRadius: BorderRadius.circular(50)
              ),
              child: Icon(
                Icons.add,
                color: AppColors.primaryWhite,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            CustomText(
              text: "写真に対して一言追加してみよう", 
              fontSize: 14, 
              fontWeight: FontWeight.normal, 
              lineHeight: 1, 
              letterSpacing: -1, 
              color: AppColors.secondaryGray
            ),
            const SizedBox(
              width: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: AppColors.secondaryBlue,
                  size: 20,
                ),
                CustomText(
                  text: "100P", 
                  fontSize: 14, 
                  fontWeight: FontWeight.bold, 
                  lineHeight: 1, 
                  letterSpacing: 1, 
                  color: AppColors.secondaryBlue
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
