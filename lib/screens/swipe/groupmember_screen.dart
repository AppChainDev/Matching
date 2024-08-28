import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_button.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/components/swipe/circle_thumbshape.dart';
import 'package:rinlin/components/swipe/group_other_card.dart';
import 'package:rinlin/components/swipe/group_prefecture_card.dart';
import 'package:rinlin/components/swipe/member_card.dart';
import 'package:rinlin/models/member_model.dart';
import 'package:rinlin/models/swipegroup_model.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:rinlin/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
class GroupMemberScreen extends StatefulWidget {
  const GroupMemberScreen({super.key});

  @override
  State<GroupMemberScreen> createState() => _GroupMemberScreenState();
}

class _GroupMemberScreenState extends State<GroupMemberScreen> {
  final List<MemberModel> users = [
    MemberModel(1, "TONBOさんから", "初めまして、都内で事務職をしております。高橋と申します。得意なことはたくさんあります。", 12, 34, "gfd.png"),
    MemberModel(2, "ゆうじ1", "サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章", 13, 40, "gfd.png"),
    MemberModel(3, "ゆうじ2", "サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章", 13, 40, "gfd.png"),
    MemberModel(4, "ゆうじ3", "サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章", 13, 40, "gfd.png"),
    MemberModel(5, "ゆうじ4", "サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章サンプル文章", 13, 40, "gfd.png"),
  ];
  late List<MemberModel> groupUsers;
  bool isLoding = false;
  bool clickedSearch = false;
  bool isMember = false;
  List<int> prefectureIds = [];
  List<int> bodyTypes= [];
  List<int> maritalHistories = [];
  List<int> attitudes = [];
  RangeValues ageRangeValues = const RangeValues(40, 40);
  RangeValues heightRangeValues = const RangeValues(130, 130);

  @override
  void initState() {
    getGroupUsers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  Future getGroupUsers() async{
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final args = ModalRoute.of(context)!.settings.arguments as SwipeGroupModel;
      await Provider.of<UserState>(context, listen: false).getGroupUsers(args.id);
      final result = await Provider.of<UserState>(context, listen: false).checkMember(args.id);
      setState(() {
        groupUsers = Provider.of<UserState>(context, listen: false).groupUsers;
        isMember = result;
        isLoding = true;
      });
    });
  }

  Future enterGroup(int groupId) async{
    final result = await Provider.of<UserState>(context, listen: false).enterGroup(groupId);
    if (result) {
      final newIsMember = await Provider.of<UserState>(context, listen: false).checkMember(groupId);
      setState(() {
        isMember = newIsMember;
      });
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
                  "グループへの参加に失敗しました。",
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

  Future searchSwipeUser(int groupId) async{
    await Provider.of<UserState>(context, listen: false).searchGroupUser(
      groupId,
      ageRangeValues.start.ceil(), 
      ageRangeValues.end.ceil(),
      heightRangeValues.start.ceil(),
      heightRangeValues.end.ceil(),
      prefectureIds,
      bodyTypes,
      maritalHistories,
      attitudes 
    );
    setState(() {
      groupUsers = Provider.of<UserState>(context, listen: false).groupSearchUsers;
      clickedSearch = false;
      ageRangeValues = const RangeValues(40, 40);
      heightRangeValues = const RangeValues(130, 130);
      prefectureIds = [];
      bodyTypes = [];
      maritalHistories = [];
      attitudes = [];
    });
  }

  void handlePrefecture(String text) {
    setState(() {
      if (prefectureIds.contains(ConstFile.prefectureItems.indexOf(text))) {
        prefectureIds.remove(ConstFile.prefectureItems.indexOf(text));
      } else {
        prefectureIds.add(ConstFile.prefectureItems.indexOf(text));
      }
    });
  }
  void handleBodyTypes(String text) {
    setState(() {
      if (bodyTypes.contains(ConstFile.bodyTypes.indexOf(text))) {
        bodyTypes.remove(ConstFile.bodyTypes.indexOf(text));
      } else {
        bodyTypes.add(ConstFile.bodyTypes.indexOf(text));
      }
    });
  }
  void handleMaritalHistories(String text) {
    setState(() {
      if (maritalHistories.contains(ConstFile.maritalHistories.indexOf(text))) {
        maritalHistories.remove(ConstFile.maritalHistories.indexOf(text));
      } else {
        maritalHistories.add(ConstFile.maritalHistories.indexOf(text));
      }
    });
  }
  void handleAttitudes(String text) {
    setState(() {
      if (attitudes.contains(ConstFile.attitudes.indexOf(text))) {
        attitudes.remove(ConstFile.attitudes.indexOf(text));
      } else {
        attitudes.add(ConstFile.attitudes.indexOf(text));
      }
    });
  }

  Widget searchWidget(){
    final args = ModalRoute.of(context)!.settings.arguments as SwipeGroupModel;
    return 
      Center(
        child: CustomContainer(
          decoration: BoxDecoration(
            color: AppColors.primaryBlack.withOpacity(0.3)
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:130),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-118,
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
                )
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 60),
                        child: Center(
                          child: CustomText(
                            text: "検索条件", 
                            fontSize: 14, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: 1, 
                            color: AppColors.primaryBlack
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: "年齢", 
                                      fontSize: 14, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryBlack
                                    ),
                                    CustomText(
                                      text: (ageRangeValues.start == 40 && ageRangeValues.end == 40)?"問わない":"${(ageRangeValues.start).toInt()}~${(ageRangeValues.end).toInt()}", 
                                      fontSize: 14, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryBlack
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    rangeThumbShape: const CircleThumbShape(),
                                    inactiveTrackColor: AppColors.primaryGray
                                  ),
                                  child: RangeSlider(
                                    values: ageRangeValues,
                                    max: 110,
                                    min: 40,
                                    divisions: 70,
                                    activeColor: AppColors.secondaryGreen,
                                    labels: RangeLabels(
                                      ageRangeValues.start.round().toString(),
                                      ageRangeValues.end.round().toString(),
                                    ),
                                    onChanged: (RangeValues values) {
                                      setState(() {
                                        ageRangeValues = values;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: "身長", 
                                      fontSize: 14, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryBlack
                                    ),
                                    CustomText(
                                      text: (heightRangeValues.start == 130 && heightRangeValues.end == 130)?"問わない":"${(heightRangeValues.start).toInt()}cm~${(heightRangeValues.end).toInt()}cm", 
                                      fontSize: 14, 
                                      fontWeight: FontWeight.normal, 
                                      lineHeight: 1, 
                                      letterSpacing: 1, 
                                      color: AppColors.primaryBlack
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    rangeThumbShape: const CircleThumbShape(),
                                    inactiveTrackColor: AppColors.primaryGray
                                  ),
                                  child: RangeSlider(
                                    values: heightRangeValues,
                                    max: 210,
                                    min: 130,
                                    divisions: 80,
                                    activeColor: AppColors.secondaryGreen,
                                    
                                    labels: RangeLabels(
                                      heightRangeValues.start.round().toString(),
                                      heightRangeValues.end.round().toString(),
                                    ),
                                    onChanged: (RangeValues values) {
                                      setState(() {
                                        heightRangeValues = values;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: CustomText(
                                  text: "居住地(右にスクロール)", 
                                  fontSize: 14, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryBlack
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Container(
                                height: 150,
                                padding: const EdgeInsets.only(left: 20),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: ConstFile.prefectureItems.sublist(0,16).map((item){
                                            return GestureDetector(
                                              onTap: () {
                                                handlePrefecture(item);
                                              },
                                              child: GroupPrefectureItem(
                                                id: ConstFile.prefectureItems.indexOf(item), 
                                                text: item.replaceAll(RegExp(r'[県]'), ''), 
                                                inChecked: prefectureIds.contains(ConstFile.prefectureItems.indexOf(item))
                                              ),
                                            );
                      
                                          }).toList(),
                                        ),
                                        Row(
                                          children: ConstFile.prefectureItems.sublist(16,32).map((item){
                                            return GestureDetector(
                                              onTap: () {
                                                handlePrefecture(item);
                                              },
                                              child: GroupPrefectureItem(
                                                id: ConstFile.prefectureItems.indexOf(item), 
                                                text: item.replaceAll(RegExp(r'[県]'), ''), 
                                                inChecked: prefectureIds.contains(ConstFile.prefectureItems.indexOf(item))
                                              ),
                                            );
                      
                                          }).toList(),
                                        ),
                                        Row(
                                          children: ConstFile.prefectureItems.sublist(32,ConstFile.prefectureItems.length).map((item){
                                            return GestureDetector(
                                              onTap: () {
                                                handlePrefecture(item);
                                              },
                                              child: GroupPrefectureItem(
                                                id: ConstFile.prefectureItems.indexOf(item), 
                                                text: item.replaceAll(RegExp(r'[県]'), ''), 
                                                inChecked: prefectureIds.contains(ConstFile.prefectureItems.indexOf(item))
                                              ),
                                            );
                      
                                          }).toList(),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: CustomText(
                                  text: "体型", 
                                  fontSize: 14, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryBlack
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: ConstFile.bodyTypes.map((item){
                                    return GestureDetector(
                                      onTap: () {
                                        handleBodyTypes(item);
                                      },
                                      child: GroupOtherItem(
                                        id: ConstFile.bodyTypes.indexOf(item), 
                                        text: item, 
                                        inChecked: bodyTypes.contains(ConstFile.bodyTypes.indexOf(item))
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: CustomText(
                                  text: "結婚歴", 
                                  fontSize: 14, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryBlack
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: ConstFile.maritalHistories.map((item){
                                    return GestureDetector(
                                      onTap: () {
                                        handleMaritalHistories(item);
                                      },
                                      child: GroupOtherItem(
                                        id: ConstFile.maritalHistories.indexOf(item), 
                                        text: item, 
                                        inChecked: maritalHistories.contains(ConstFile.maritalHistories.indexOf(item))
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: CustomText(
                                  text: "結婚に対する意思", 
                                  fontSize: 14, 
                                  fontWeight: FontWeight.normal, 
                                  lineHeight: 1, 
                                  letterSpacing: -1, 
                                  color: AppColors.primaryBlack
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: ConstFile.attitudes.map((item){
                                    return GestureDetector(
                                      onTap: () {
                                        handleAttitudes(item);
                                      },
                                      child: GroupOtherItem(
                                        id: ConstFile.attitudes.indexOf(item), 
                                        text: item, 
                                        inChecked: attitudes.contains(ConstFile.attitudes.indexOf(item))
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                  title: "この条件で検索", 
                                  width: 343, 
                                  fontSize: 15, 
                                  fontWeight: FontWeight.normal, 
                                  color: AppColors.secondaryGreen, 
                                  titleColor: AppColors.primaryWhite, 
                                  onTap: (){
                                    searchSwipeUser(args.id);
                                  }
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){
                          setState(() {
                            clickedSearch = false;
                          });
                        }, 
                        icon: Icon(
                          Icons.close,
                          color: AppColors.primaryBlack,
                          size: 40,
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              clickedSearch = false;
                            });
                          }, 
                          child: CustomText(
                            text: "リセット", 
                            fontSize: 14, 
                            fontWeight: FontWeight.normal, 
                            lineHeight: 1, 
                            letterSpacing: -1, 
                            color: AppColors.secondaryGreen
                          )
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ),
        ),
      );
  }
 
  @override
  Widget build(BuildContext context) {
    // final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final args = ModalRoute.of(context)!.settings.arguments as SwipeGroupModel;
    return BaseScreen(
      child: isLoding? Stack(
        children: [
          Center(
            child: CustomContainer(
              decoration: BoxDecoration(
                color: AppColors.primaryBackground
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:260, left: 20, right: 20, bottom: 50),
                child: groupUsers.isNotEmpty?  SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: groupUsers.map((item){
                      return MemberItem(
                        id: item.id, 
                        name: item.name, 
                        prefectureId: item.prefectureId, 
                        age: item.age, 
                        introduction: item.introduction, 
                        avatar: item.avatar
                      );
                    }).toList()
                  ),
                ): Center(
                    child: CustomContainer(
                      decoration: BoxDecoration(
                        color: AppColors.primaryBackground
                      ),
                      child: Center(
                        child: Container(
                          width: 345,
                          height: 215,
                          padding: const EdgeInsets.only(top: 46, bottom: 26),
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.secondaryGray.withOpacity(0.5), // Shadow color
                                spreadRadius: 0.5, // Spread radius
                                blurRadius: 5, // Blur radius
                                offset: const Offset(0, 1), // Shadow position (x, y)
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "条件に該当する\n会員が見つかりませんでした",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.primaryBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: -1
                                ),
                              ),
                              Container(
                                width: 280,
                                height: 46,
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryGreen,
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: CustomText(
                                      text: "他のおすすめ会員を表示", 
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
                        ),
                      )
                    ),
                  ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                CustomContainer(
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
                          text: args.name, 
                          fontSize: 17, 
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
                  height: 145,
                  decoration: BoxDecoration(
                    color: AppColors.primaryWhite
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 25, bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("${dotenv.get('BASE_URL')}/img/${args.thumbnail}"),
                              fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.circular(10) 
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              text: args.name, 
                              fontSize: 20, 
                              fontWeight: FontWeight.normal, 
                              lineHeight: 1, 
                              letterSpacing: -1, 
                              color: AppColors.secondaryGreen
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 183,
                              height: 38,
                              decoration: BoxDecoration(
                                color: isMember? AppColors.secondaryGray.withOpacity(0.8):AppColors.secondaryGreen,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  if (!isMember) {
                                    enterGroup(args.id);
                                  }
                                },
                                child: Center(
                                  child: CustomText(
                                    text: "参加する", 
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
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: CustomContainer(
              height: 94,
              child: Padding(
                padding: const EdgeInsets.only(top:46),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          clickedSearch = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: ImageIcon(
                          const AssetImage("assets/images/search.png"),
                          color: AppColors.primaryWhite,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if(clickedSearch)
           searchWidget()
        ],
      ):const CustomContainer(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
