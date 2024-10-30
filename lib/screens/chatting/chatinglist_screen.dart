import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/chatting/chattinglist_card.dart';
import 'package:rinlin/components/chatting/replylist_card.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/models/block_model.dart';
import 'package:rinlin/models/user.dart';
import 'package:rinlin/screens/chatting/chattingdetail_screen.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:rinlin/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChattingListScreen extends StatefulWidget {

  const ChattingListScreen({super.key});

  @override
  State<ChattingListScreen> createState() => _ChattingListScreenState();
}

class _ChattingListScreenState extends State<ChattingListScreen> {

  final DatabaseHelper _dbHelper = DatabaseHelper();

  late List<BlockModel> blocks;
  late List<User> replayLists;
  late List<User> chattingLists;
  late List<User> chattingPossibleLists;
  List<User> displayLists = [];
  bool isLoding = false;

  String filterText = "matching";

  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadUsers() async {
    List<Map<String, dynamic>> loadedUsers = await _dbHelper.getUsers();
    List<User> userList = loadedUsers.map((json) => User.fromJson(json)).toList();
    List<User> filteredUsers = await _dbHelper.getUsersWithLastMessageSentByMe();
    for (var user in userList) {
      final lastMessage = await _dbHelper.getLastMessageForUser(user.id);
      if (lastMessage != null) {
        user.state = lastMessage['text']?.split(' ').first ?? 'No message'; // Show first sentence
        user.time = DateFormat('MM/dd HH:mm').format(DateTime.parse(lastMessage['timestamp']));
      } else {
        user.state = 'あなたのメッセージを待っています！'; // Default message
        user.time = '';
      }
    }
    await Provider.of<UserState>(context, listen: false).getMatchedUserList();
    setState(() {
      chattingLists = userList;
      replayLists = filteredUsers;
      chattingPossibleLists = Provider.of<UserState>(context, listen: false).matchedUserList;
      final chattingListIds = chattingLists.map((user) => user.id).toSet();
      chattingPossibleLists.removeWhere((user) => chattingListIds.contains(user.id));
      displayLists = chattingPossibleLists;
      isLoding = true;
    });
  }

  Future<void> _addUser(int id, String name, int age, int prefectureId, String avatar) async {
    User newUser = User(
      id: id,
      name: name,
      age: age,
      prefectureId: prefectureId,
      avatar: avatar,
      state: 'あなたのメッセージを待っています！', // Default state
      time: DateFormat('MM/dd HH:mm').format(DateTime.now()),  // Current time
    );
    await _dbHelper.insertUser(newUser.toJson());
    _loadUsers();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChattingDetailScreen(user: newUser),
      ),
    );  
    
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
        displayLists = chattingPossibleLists;
      });
    } else {
      setState(() {
        filterText = text;
        displayLists = chattingLists;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async{
        const storage = FlutterSecureStorage();
        String? gender =  await storage.read(key: 'gender');
        if (gender != null) {
          if (int.parse(gender) == 1) {
            Navigator.pushNamed(context, "/malemypage");
          } else {
            Navigator.pushNamed(context, "/femalemypage");
          }
        }
        return true;
      },
      child: BaseScreen(
        child: isLoding? Stack(
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
                                  children: replayLists.map((item){
                                    return ReplyListItem(
                                      id: item.id, 
                                      name: item.name, 
                                      prefectureId: item.id, 
                                      age: item.age, 
                                      avatar: item.avatar, 
                                      date: item.time,
                                      onClick: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChattingDetailScreen(user: item),
                                          ),
                                        );
                                        // Navigator.pushNamed(context, "/chatting_detail", arguments: ChattingTransferModel(item.id, item.name, item.avatar, item.prefectureId, item.age));
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
                                if(filterText == "matching"){
                                  _addUser(item.id, item.name, item.age, item.prefectureId, item.avatar);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChattingDetailScreen(user: item),
                                    ),
                                  );
                                }
                              },
                              child: ChattingListItem(
                                id: item.id, 
                                name: item.name, 
                                prefectureId: item.prefectureId, 
                                age: item.age, 
                                stateText: item.state, 
                                avatar: item.avatar, 
                                date: item.time, 
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
        ):const CustomContainer(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ),
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