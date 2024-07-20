import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/chattingtransfer_model.dart';
import 'package:drone/models/usertransfer_model.dart';
import 'package:drone/screens/register/registerprofile_group.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';

class ViewProfileScreen extends StatefulWidget {

  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {

  final TextEditingController messageController = TextEditingController();
  final int community1 = 1;
  final int community2 = 1;
  final int community3 = 1;
  final int community4 = 1;
  
  final int id = 1;
  final String name = "ゆうた";
  late  String currentAvatar;
  final List<String> avatars = ["gfd.png", "aaa.png", "post_backimage1.png"];
  // final String currentAvatar = "gfd.png";
  final int prefectureId = 12;
  final int age = 50;

  final String? memoryImage = "memory_image.png";
  final String? memoryDescription = "ゲームが大好きなんです";


  @override
  void initState() {
    setState(() {
      currentAvatar = avatars[0];
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
      child: Stack(
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
                            image: AssetImage("assets/images/$currentAvatar"),
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
                                    text: name, 
                                    fontSize: 17, 
                                    fontWeight: FontWeight.bold, 
                                    lineHeight: 1.5, 
                                    letterSpacing: -1, 
                                    color: AppColors.primaryWhite
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        ConstFile.prefectureItems[prefectureId],
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
                                        "$age歳",
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
                                children: avatars.map( (avatar){
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentAvatar = avatar;            
                                      });
                                    },
                                    child: Container(
                                      width: 61,
                                      height: 61,
                                      margin: const EdgeInsets.only(top: 5, right: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/$avatar"),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
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
                                        text: "私は、日本に住んでいる男性です。初めてアプリを利用しました。\n好きなことは登山と釣りをすることです。休日はよくキャンプに出かけます。いつもは一人ですが、いい人がいたら一緒に行きたいです。他には、仕事はIT系です。土日が休みなので同じ休みの日の人がいたら嬉しいです。\nとにかく素敵な人と出会いって結婚をスタートしたいです。", 
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
                                  const Column(
                                    children: [
                                      ProfileItem(
                                        label: "居住地", text: "東京都"
                                      ),
                                      ProfileItem(
                                        label: "身長", text: "150cm"
                                      ),
                                      ProfileItem(
                                        label: "体型", text: "普通"
                                      ),
                                      ProfileItem(
                                        label: "血液型", text: "A型"
                                      ),
                                      ProfileItem(
                                        label: "出身地", text: "東京都"
                                      ),
                                      ProfileItem(
                                        label: "学歴", text: "短大・専門卒"
                                      ),
                                      ProfileItem(
                                        label: "職種", text: "教育関連"
                                      ),
                                      ProfileItem(
                                        label: "年収", text: "400万円〜600万円"
                                      ),
                                      ProfileItem(
                                        label: "結婚歴", text: "独身(離婚)"
                                      ),
                                      ProfileItem(
                                        label: "結婚に対する意思", text: "2〜3年以内にしたい"
                                      ),
                                      ProfileItem(
                                        label: "子供の有無", text: "同居中"
                                      ),
                                      ProfileItem(
                                        label: "家事や育児", text: "参加したい"
                                      ),
                                      ProfileItem(
                                        label: "出会うまでの希望", text: "まずは会って話したい"
                                      ),
                                      ProfileItem(
                                        label: "初回デート費用", text: "割り勘"
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
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
                                            image: AssetImage("assets/images/$memoryImage"),
                                            fit: BoxFit.cover
                                          )
                                        ),
                                      )
                                    ],
                                  ),
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
                                      text: "ゲームが大好きなんです", 
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
                            sendMessage(id, name, currentAvatar, age, prefectureId);
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
                                  Navigator.pushNamed(context, "/messagescreen", arguments: ChattingTransferModel(id, name, avatars[0], prefectureId, age));
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
