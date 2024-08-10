import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/chattingtransfer_model.dart';
import 'package:drone/models/community_model.dart';
import 'package:drone/models/user_model.dart';
import 'package:drone/models/usertransfer_model.dart';
import 'package:drone/state/record_state.dart';
import 'package:drone/state/user_state.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:drone/screens/register/registerprofile_group.dart';

class ViewProfileScreen extends StatefulWidget {

  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {

  late UserModel userById;
  bool isLoding = false;
  final TextEditingController messageController = TextEditingController();
  late String currentAvatar;
  List<CommunityModel> groups = [];

  @override
  void initState() {
    getUserById();
    saveRecord();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getUserById() async{
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final args = ModalRoute.of(context)!.settings.arguments as UserTransforIdModel;
      await Provider.of<UserState>(context, listen: false).getUserById(args.id);
      await Provider.of<UserState>(context, listen: false).getGroupList();
      setState(() {
        userById = Provider.of<UserState>(context, listen: false).userById!;
        groups = Provider.of<UserState>(context, listen: false).groups;
        currentAvatar = userById.avatars[0];
        isLoding = true;
      });
    });
  }

  Future saveRecord() async{
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final args = ModalRoute.of(context)!.settings.arguments as UserTransforIdModel;
      await Provider.of<RecordState>(context, listen: false).saveRecord(args.id);
    });
  }

  void saveMessage(){
    Navigator.pop(context);
  }

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        messageController.clear();
      });
      Navigator.pop(context);
    }
  }

  Future<void> sendMessage(int id, String name, String avatar, int age, int prefectureId) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
            ),
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 25),
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: CustomText(
                          text: "すぐに通知を受け取るには", 
                          fontSize: 13, 
                          fontWeight: FontWeight.normal, 
                          lineHeight: 1, 
                          letterSpacing: -1, 
                          color: AppColors.primaryBlack
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Image.asset("assets/images/$avatar", fit:BoxFit.cover),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: name, 
                                fontSize: 10, 
                                fontWeight: FontWeight.bold, 
                                lineHeight: 1.5, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    text: "$age歳", 
                                    fontSize: 16, 
                                    fontWeight: FontWeight.bold, 
                                    lineHeight: 1.5, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CustomText(
                                    text: ConstFile.prefectureItems[prefectureId], 
                                    fontSize: 10, 
                                    fontWeight: FontWeight.normal, 
                                    lineHeight: 1.5, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Stack(
                            children: [
                              TextField(
                                controller: messageController,
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                cursorColor: AppColors.primaryBlack,
                                style: TextStyle(color: AppColors.primaryBlack),
                                decoration: InputDecoration(
                                  hintText: "共感へのメッセージで、個人を特定できる連絡先(LINEやInstagram）を記載することは禁止されています。\nお相手のプロフィール内容で共感したところや、仲良くなったら一緒にしたいことを入力するとマッチング率が向上します",
                                  hintMaxLines: 7,
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
                      ),
                      CustomButton(
                        title: "送信",
                        width: 343,
                        height: 45,
                        fontSize: 17, 
                        fontWeight: FontWeight.normal, 
                        color: AppColors.secondaryGreen, 
                        titleColor: AppColors.primaryWhite, 
                        onTap: () async{
                          Navigator.pop(context);
                          saveMessage(); 
                        }
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                  Container(
                    height: 21,
                    margin: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: ImageIcon(
                            const AssetImage("assets/images/close_button.png"),
                            color: AppColors.primaryBlack
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserTransforIdModel;
    return BaseScreen(
      child: isLoding? Stack(
        children: [
          CustomContainer(
            decoration: BoxDecoration(
              color: AppColors.primaryGray.withOpacity(0.5)
            ),
            child: CustomContainer(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Center(
                      child: CustomContainer(
                        height: 424,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("${dotenv.get('BASE_URL')}/img/$currentAvatar"),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 280, left: 20, right: 20),
                        child: CustomContainer(
                          height: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: userById.name, 
                                    fontSize: 17, 
                                    fontWeight: FontWeight.bold, 
                                    lineHeight: 1.5, 
                                    letterSpacing: -1, 
                                    color: AppColors.primaryWhite
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        ConstFile.prefectureItems[userById.prefectureId],
                                        style: TextStyle(  
                                          fontSize: 12, 
                                          fontWeight: FontWeight.bold, 
                                          height: 1.5, 
                                          letterSpacing: 1, 
                                          color: AppColors.primaryWhite,
                                          shadows: [
                                            Shadow(
                                              offset: const Offset(2.0, 2.0),
                                              blurRadius: 3.0,
                                              color:AppColors.primaryBlack.withOpacity(0.5),
                                            ),
                                          ], 
                                        ), 
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${userById.age}歳",
                                        style: TextStyle(  
                                          fontSize: 12, 
                                          fontWeight: FontWeight.bold, 
                                          height: 1.5, 
                                          letterSpacing: 1, 
                                          color: AppColors.primaryWhite,
                                          shadows: [
                                            Shadow(
                                              offset: const Offset(2.0, 2.0),
                                              blurRadius: 3.0,
                                              color:AppColors.primaryBlack.withOpacity(0.5),
                                            ),
                                          ], 
                                        ), 
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: userById.avatars.map((avatar){
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentAvatar = avatar;            
                                      });
                                    },
                                    child: avatar!=""? Container(
                                      width: 61,
                                      height: 61,
                                      margin: const EdgeInsets.only(top: 5, right: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage("${dotenv.get('BASE_URL')}/img/$avatar"),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ):Container(),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 407),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
                              decoration: BoxDecoration(
                                color: AppColors.primaryWhite,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "自己PR", 
                                    fontSize: 15, 
                                    fontWeight: FontWeight.normal, 
                                    lineHeight: 1, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: CustomText(
                                        text: userById.introduce, 
                                        fontSize: 14, 
                                        fontWeight: FontWeight.normal, 
                                        lineHeight: 1.5, 
                                        letterSpacing: -1, 
                                        color: AppColors.primaryBlack
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                              decoration: BoxDecoration(
                                color: AppColors.primaryWhite,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "プロフィール", 
                                    fontSize: 15, 
                                    fontWeight: FontWeight.normal, 
                                    lineHeight: 1, 
                                    letterSpacing: 1, 
                                    color: AppColors.primaryBlack
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    children: [
                                      ProfileItem(
                                        label: "居住地", text: ConstFile.prefectureItems[userById.prefectureId]
                                      ),
                                      ProfileItem(
                                        label: "身長", text: "${userById.height}cm"
                                      ),
                                      ProfileItem(
                                        label: "体型", text: ConstFile.bodyTypes[userById.bodyType]
                                      ),
                                      ProfileItem(
                                        label: "血液型", text: ConstFile.bloodItems[userById.blood]
                                      ),
                                      ProfileItem(
                                        label: "出身地", text: ConstFile.prefectureItems[userById.birth]
                                      ),
                                      ProfileItem(
                                        label: "学歴", text: ConstFile.educationItems[userById.education]
                                      ),
                                      ProfileItem(
                                        label: "職種", text: ConstFile.jobTypes[userById.jobType]
                                      ),
                                      ProfileItem(
                                        label: "年収", text: ConstFile.incomes[userById.income]
                                      ),
                                      if(userById.holiday != null)
                                        ProfileItem(
                                          label: "休日", text: ConstFile.holidayItem[userById.holiday!]
                                        ),
                                      if(userById.roomate != null)
                                        ProfileItem(
                                          label: "同居人", text: ConstFile.roomateItem[userById.roomate!]
                                        ),
                                      if(userById.alcohol != null)
                                        ProfileItem(
                                          label: "お酒", text: ConstFile.alcoholItem[userById.alcohol!]
                                        ),
                                      if(userById.smoking != null)
                                        ProfileItem(
                                          label: "タバコ", text: ConstFile.smokingItem[userById.smoking!]
                                        ),
                                      ProfileItem(
                                        label: "結婚歴", text: ConstFile.maritalHistories[userById.materialHistory]
                                      ),
                                      ProfileItem(
                                        label: "結婚に対する意思", text: ConstFile.attitudes[userById.attitude]
                                      ),
                                      ProfileItem(
                                        label: "子供の有無", text: ConstFile.childrenItems[userById.children]
                                      ),
                                      ProfileItem(
                                        label: "家事や育児", text: ConstFile.houseworkItems[userById.housework]
                                      ),
                                      ProfileItem(
                                        label: "出会うまでの希望", text: ConstFile.hopeMeetItems[userById.hopeMeet]
                                      ),
                                      ProfileItem(
                                        label: "初回デート費用", text: ConstFile.dateCostItems[userById.dateCost]
                                      ),
                                      if(userById.saving != null)
                                        ProfileItem(
                                          label: "貯蓄", text: ConstFile.savingsItem[userById.saving!]
                                        ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            if(userById.favoriteImage != null)
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                margin: const EdgeInsets.only(top: 17),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryWhite,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "ともへこさん の思い出の1枚", 
                                      fontSize: 15, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1, 
                                      letterSpacing: -1, 
                                      color: AppColors.primaryBlack
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 176,
                                          height: 162,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage("${dotenv.get('BASE_URL')}/img/${userById.favoriteImage}"),
                                              fit: BoxFit.cover
                                            )
                                          ),
                                        )
                                      ],
                                    ),
                                    if(userById.favoriteDescription != null)
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.only(top: 20),
                                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryWhite,
                                          borderRadius: BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.secondaryGray.withOpacity(0.5), // Shadow color
                                              spreadRadius: 0.5, // Spread radius
                                              blurRadius: 5, // Blur radius
                                              offset: const Offset(0, 1), // Shadow position (x, y)
                                            ),
                                          ],
                                        ),
                                        child: CustomText(
                                          text: userById.favoriteDescription!, 
                                          fontSize: 14, 
                                          fontWeight: FontWeight.normal, 
                                          lineHeight: 1, 
                                          letterSpacing: -1, 
                                          color: AppColors.secondaryGreen
                                        ),
                                      )
                                    
                                  ],
                                ),
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            if(userById.groups.isNotEmpty)
                              Container(
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
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryBlack
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.start,
                                      spacing: 13,
                                      children: userById.groups.map((groupId) {
                                        return GroupItem(
                                          inChecked: false, 
                                          id: groupId, 
                                          text: (groups.where((e) => e.id == groupId).toList())[0].name, 
                                          image: (groups.where((e) => e.id == groupId).toList())[0].image
                                        );
                                      }).toList() 
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 32, left: 10),
                        child: SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                }, 
                                icon: Icon(
                                  Icons.close,
                                  color: AppColors.primaryWhite,
                                  size: 30,
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          if(args.beforePage == "postpage" )
            Center(
              child: CustomContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 66,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryGreen
                      ),
                      child: Center(
                        child: CustomButton(
                          title: "共感する",
                          width: 343,
                          height: 45,
                          fontSize: 17, 
                          fontWeight: FontWeight.normal, 
                          color: AppColors.primaryWhite, 
                          titleColor: AppColors.secondaryGreen, 
                          onTap: () async{ 
                            sendMessage(userById.id, userById.name, userById.avatars[0], userById.age, userById.prefectureId);
                          }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if(args.beforePage == "likepage" )
            Center(
              child: CustomContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 132,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryGray,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: MaterialButton(
                              onPressed: (){
                      
                              },
                              child: Center(
                                child: CustomText(
                                  text: "スキップ", 
                                  fontSize: 16, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryWhite
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 132,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryGreen,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: MaterialButton(
                              onPressed: (){
                      
                              },
                              child: Center(
                                child: CustomText(
                                  text: "ありがとう", 
                                  fontSize: 16, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryWhite
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          if(args.beforePage == "chattingpage" )
            Center(
              child: CustomContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhite,
                        border: Border(
                          top: BorderSide(
                            color: AppColors.secondaryGray.withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 317,
                            height: 65,
                            child: TextField(
                              controller: messageController,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              cursorColor: AppColors.primaryBlack,
                              style: TextStyle(
                                color: AppColors.primaryBlack,
                              ),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.secondaryGray.withOpacity(0.5),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.secondaryGray.withOpacity(0.5),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          IconButton(
                            onPressed: _sendMessage,
                            icon: Icon(
                              Icons.send,
                              color: AppColors.secondaryGreen,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if(args.beforePage == "swipepage" )
            Center(
              child: CustomContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryGray.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: (){
                      
                                }, 
                                icon: ImageIcon(
                                  const AssetImage("assets/images/close_button.png"),
                                  color: AppColors.primaryWhite
                                )
                              )
                            ),
                          ),
                          const SizedBox(
                            width: 28.6,
                          ),
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryRed,
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, "/messagescreen", arguments: ChattingTransferModel(userById.id, userById.name, userById.avatars[0], userById.prefectureId, userById.age));
                                }, 
                                icon: ImageIcon(
                                  const AssetImage("assets/images/like.png"),
                                  color: AppColors.primaryWhite
                                )
                              )
                            ),
                          ),
                          const SizedBox(
                            width: 28.6,
                          ),
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryGreen,
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: (){
                                  
                                }, 
                                icon: ImageIcon(
                                  const AssetImage("assets/images/heart.png"),
                                  color: AppColors.primaryWhite
                                )
                              )
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
        ],
      ): const CustomContainer(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
    );
  }
}

class ProfileItem extends StatelessWidget{
  const ProfileItem({
    super.key, required this.label, required this.text
 });

 final String label;
 final String text;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top:20, right: 15),
      child: Container(
        padding: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.primaryGray,
              width: 1
            )
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: label, 
              fontSize: 13, 
              fontWeight: FontWeight.normal, 
              lineHeight: 1, 
              letterSpacing: 1, 
              color: AppColors.primaryBlack
            ),
            CustomText(
              text: text, 
              fontSize: 13, 
              fontWeight: FontWeight.normal, 
              lineHeight: 1, 
              letterSpacing: 1, 
              color: AppColors.secondaryGreen
            )
          ],
        ),
      ),
    );
  }
}
