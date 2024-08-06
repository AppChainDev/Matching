import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/category_model.dart';
import 'package:drone/models/community_model.dart';
import 'package:drone/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class RegisterProfileGroupScreen extends StatefulWidget {

  const RegisterProfileGroupScreen({super.key});

  @override
  State<RegisterProfileGroupScreen> createState() => _RegisterProfileGroupScreenState();
}

class _RegisterProfileGroupScreenState extends State<RegisterProfileGroupScreen> {
  final List<int> community = [];
  List<CommunityModel> groupsArray = [];
  List<Category> categoryList = [];
  @override
  void initState() {
    super.initState();
    getGroupList();
    getCategoryList();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  void handleCommunityChanged(int id) {
    setState(() {
      if(community.contains(id)){
        community.remove(id);
      }else{
        community.add(id);
      }
    });
  }
  bool isCompleted(){
    if(community.length >= 3 ){
      return true;
    }else{
      return false;
    }
  }

  Future<void> getGroupList() async{
    await Provider.of<UserState>(context, listen: false).getGroupList();
    setState(() {
      groupsArray = Provider.of<UserState>(context, listen: false).groups;
    });                                 
  }

  Future<void> getCategoryList() async{
    await Provider.of<UserState>(context, listen: false).getCategoryList();
    setState(() {
      categoryList = Provider.of<UserState>(context, listen: false).categories;
    });                                 
  }

  Future<void> saveGroups() async{
    final result = await Provider.of<UserState>(context, listen: false).saveGroups(community);
    if (result) {
      community.clear();
      Navigator.pushNamed(context, "/preference");
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
                  "グループ登録に失敗しました。",
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
                          saveGroups();
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
               child: groupsArray.isNotEmpty ? SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.only(top:227, bottom: 50),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: categoryList.map((item){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:20, left: 30, right: 30, bottom: 10),
                            child: CustomText(
                              text: item.label, 
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
                                  children: groupsArray.where((groupItem){
                                    return groupItem.categoryId == item.id;
                                  }).map((data){
                                    return GestureDetector(
                                      onTap: () {
                                        handleCommunityChanged(data.id);
                                      },
                                      child: GroupItem(
                                        inChecked: community.contains(data.id), 
                                        id: data.id, 
                                        text: data.name, 
                                        image: data.image
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                     }).toList()
                   )
                 ),
               ):const Center(
                  child: CircularProgressIndicator()
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage("${dotenv.get('BASE_URL')}/img/$image"),
                    fit: BoxFit.cover,
                    )
                  ),
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
