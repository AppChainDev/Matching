import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/chatting/chattinglist_card.dart';
import 'package:drone/components/chatting/replylist_card.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/chatting_model.dart';
import 'package:drone/models/chattingtransfer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChattingListScreen extends StatefulWidget {

  const ChattingListScreen({super.key});

  @override
  State<ChattingListScreen> createState() => _ChattingListScreenState();
}

class _ChattingListScreenState extends State<ChattingListScreen> {

  List<ChattingModel> allLists = [
    ChattingModel(1, "WomanK1", 12, 55, "avatar1.png", "", "あなたのメッセージを待っています！", "2024-02-26 03:58:48"),
    ChattingModel(2, "WomanK2", 12, 65, "avatar1.png", "", "あなたのメッセージを待っています！", "2024-02-26 03:58:48"),
    ChattingModel(3, "WomanK3", 12, 55, "avatar1.png", "send", "メッセージが届いています。", "2024-02-26 03:58:48"),
    ChattingModel(4, "WomanK4", 12, 65, "avatar1.png", "receive", "メッセージが届いています。", "2024-02-26 03:58:48"),
    ChattingModel(5, "WomanK3", 13, 57, "avatar1.png", "send", "メッセージが届いています。", "2024-02-26 03:58:48"),

  ];

  late List<ChattingModel> displayLists;
  late List<ChattingModel> replyLists;

  String filterText = "matching";

  @override
  void initState() {
    setState(() {
      replyLists = allLists.where((list)=>list.state == "send").toList();
      if (filterText == "matching") {
        displayLists = allLists.where((list)=>list.state == "").toList();
      } else {
        displayLists = allLists.where((list)=>list.state != "").toList();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future moveProfile() async{
    const storage = FlutterSecureStorage();
    String? gender =  await storage.read(key: 'gender');
    if (gender != null) {
      // ignore: unrelated_type_equality_checks
      if (int.parse(gender) == 1) {
        Navigator.pushNamed(context, "/malemypage");
      } else {
        Navigator.pushNamed(context, "/femalemypage");
      }
    }
  }
  
  Widget bottomBar(){
    return 
      Center(
        child: CustomContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite
                ),
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/postpage");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/agreement.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              '共感',
                              style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/swipe");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/detection.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              '発見',
                              style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/likelist");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/like.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              'いいね',
                              style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/message.png"),
                              color: AppColors.secondaryGreen
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              'メッセージ',
                              style: TextStyle(
                                color: AppColors.secondaryGreen,
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      child: MaterialButton(
                        onPressed: () {
                          moveProfile();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/profile.png"),
                              color: AppColors.secondaryGray.withOpacity(0.5)
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              'マイページ',
                              style: TextStyle(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }

  void handleChange(String text) {
    if (text == "matching") {
      setState(() {
        filterText = text;
        displayLists = allLists.where((list)=>list.state == "").toList();
      });
    } else {
      setState(() {
        filterText = text;
        displayLists = allLists.where((list)=>list.state != "").toList();
      });
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 160, bottom: 100),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "いま、返信が返ってきやすい会員", 
                              fontSize: 14, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 2, 
                              letterSpacing: -1, 
                              color: AppColors.secondaryGreen
                            ),
                            Expanded(
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: replyLists.map((item){
                                  return ReplyListItem(
                                    id: item.id, 
                                    name: item.name, 
                                    prefectureId: item.id, 
                                    age: item.age, 
                                    avatar: item.avatar, 
                                    date: item.date,
                                    onClick: () {
                                      Navigator.pushNamed(context, "/chatting_detail", arguments: ChattingTransferModel(item.id, item.name, item.avatar, item.prefectureId, item.age));
                                    },
                                  );
                                }).toList(),
                              )
                            )

                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: displayLists.map((item){
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/chatting_detail", arguments: ChattingTransferModel(item.id, item.name, item.avatar, item.prefectureId, item.age));  
                            },
                            child: ChattingListItem(
                              id: item.id, 
                              name: item.name, 
                              prefectureId: item.prefectureId, 
                              age: item.age, 
                              stateText: item.stateText, 
                              avatar: item.avatar, 
                              date: item.date, 
                              state: item.state
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
           
           Center(
            child: Column(
              children: [
                CustomContainer(
                  height: 84,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryGreen
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          text: "メッセージ", 
                          fontSize: 16, 
                          fontWeight: FontWeight.bold, 
                          lineHeight: 1, 
                          letterSpacing: 1, 
                          color: AppColors.primaryWhite
                        ),
                      ],
                    ),
                  ),
                ),
                CustomContainer(
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.primaryWhite
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 320,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            SelectItem(
                              text: "マッチング中", 
                              keyText: "matching",
                              inChecked: filterText == "matching", 
                              onCartChanged: handleChange
                            ),
                            SelectItem(
                              text: "お話中", 
                              keyText: "chatting",
                              inChecked: filterText == "chatting", 
                              onCartChanged: handleChange
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomBar()
          
        ],
      )
    );
  }
}

typedef CartChangedCallback = Function(String text);

class SelectItem extends StatelessWidget {
  const SelectItem(
    {required this.text,
    required this.keyText,
    required this.inChecked,
    required this.onCartChanged,
    super.key});

  final String text;
  final String keyText;
  final bool inChecked;
  final CartChangedCallback onCartChanged;

  Color backColor(BuildContext context) {
    return inChecked
      ? AppColors.secondaryGreen
      : AppColors.primaryBackground;
  }
  Color textColor(BuildContext context) {
    return inChecked
      ? AppColors.primaryWhite
      : AppColors.secondaryGreen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 42,
      decoration: BoxDecoration(
        color: backColor(context),
        borderRadius: BorderRadius.circular(10)
      ),
      child: MaterialButton(
        onPressed: () {
          onCartChanged(keyText);
        },
        child: Center(
          child: CustomText(
            text: text, 
            fontSize: 13, 
            fontWeight: FontWeight.normal, 
            lineHeight: 1, 
            letterSpacing: -1, 
            color: textColor(context)
          ),
        ),
      ),
    );
  }
}