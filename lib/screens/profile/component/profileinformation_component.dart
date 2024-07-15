import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/components/picker/cupertinopicker.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';

class ProfileInformationWidget extends StatefulWidget{
  const ProfileInformationWidget({
    super.key
 });

  @override
  State<ProfileInformationWidget> createState() => _ProfileInformationWidgetState();
}

class _ProfileInformationWidgetState extends State<ProfileInformationWidget> {
  String name = "ゆうた";
  late int blood;
  late int education;
  late int birth;
  late int income;
  late int jobType;
  late int maritalHistory;
  late int children;
  late int housework;
  late int hopeMeet;
  late int dateCost;
  late int prefectureId;
  late int height;
  late int bodyType;
  late int attitude;
  int? holiday;
  int? roommate;
  int? alcohol;
  int? smoking;
  int? savings;

  @override
  void initState() {
    super.initState();
    setState(() {
      blood = 0;
      prefectureId = 12;
      height = 150;
      bodyType = 2;
      birth = 12;
      education = 1;
      jobType = 14;
      income = 3;
      maritalHistory = 1;
      attitude = 2;
      children = 1;
      housework = 1;
      hopeMeet = 0;
      dateCost = 2;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  void changePrefecture(int index) {
    setState(() {
      prefectureId = index;
    });
  }
  void changeHeight(int index) {
    setState(() {
      height = 130 + index; 
    });
  }
  void changebodyType(int index) {
    setState(() {
      bodyType = index;
    });
  }
  void changeBlood(int index) {
    setState(() {
      blood = index;
    });
  }
  void changeBirth(int index) {
    setState(() {
      birth = index;
    });
  }
  void changeEducation(int index) {
    setState(() {
      education = index;
    });
  }
  void changeJobType(int index) {
    setState(() {
      jobType = index;
    });
  }
  void changeIncome(int index) {
    setState(() {
      income = index;
    });
  }
  void changeHoliday(int index) {
    setState(() {
      holiday = index;
    });
  }
  void changeRoomate(int index) {
    setState(() {
      roommate = index;
    });
  }
  void changeAlcohol(int index) {
    setState(() {
      alcohol = index;
    });
  }
  void changeSmoking(int index) {
    setState(() {
      smoking = index;
    });
  }
  void changeMaritalHistory(int index) {
    setState(() {
      maritalHistory = index;
    });
  }
  void changeAttitude(int index) {
    setState(() {
      attitude = index;
    });
  }
  void changeChildren(int index) {
    setState(() {
      children =  index;
    });
  }
  void changeHousework(int index) {
    setState(() {
      housework =  index;
    });
  }
  void changeHopeMeet(int index) {
    setState(() {
      hopeMeet =  index;
    });
  }
  void changeDateCost(int index) {
    setState(() {
      dateCost =  index;
    });
  }
  void changeSaving(int index) {
    setState(() {
      savings =  index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 16, left: 20, right: 16, bottom: 40),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "プロフィール", 
            fontSize: 17, 
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
            height: 33,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/edit_name");
                },
                child: ProfileItem(label: "ニックネーム", text: name, isText: true,)
              ),
//--------prefecture-------------- 
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext builder) {
                          return Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryWhite,
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                              ),
                              height: MediaQuery.of(context).copyWith().size.height / 3,
                              child: CustomCupertinoPicker(
                                text: "居住地",
                                items: ConstFile.prefectureItems, 
                                onSelectedItemChanged: (int index){
                                  changePrefecture(index);
                                },
                              )
                            );
                        });
                },
                child: ProfileItem(label: "居住地", text: ConstFile.prefectureItems[prefectureId])
              ),
// --------height-----------------
              GestureDetector(
                onTap: () {
                  List<String> values = List.generate(80, (index) => '${130 + index}cm');
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                            ),
                            height: MediaQuery.of(context).copyWith().size.height / 3,
                            child: CustomCupertinoPicker(
                              text: "身長",
                              items: values, 
                              onSelectedItemChanged: (int index){
                                changeHeight(index);
                              }
                            )
                          );
                      });
                },
                child: ProfileItem(label: "身長", text: "${height}cm")
              ),
// ---------bodyType--------------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                            ),
                            height: MediaQuery.of(context).copyWith().size.height / 3,
                            child: CustomCupertinoPicker(
                              text: "体型",
                              items: ConstFile.bodyTypes, 
                              onSelectedItemChanged: (int index){
                                changebodyType(index);
                              }
                            )
                          );
                      });
                },
                child: ProfileItem(label: "体型", text: ConstFile.bodyTypes[bodyType])
              ),
// ----------------blood--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                            ),
                            height: MediaQuery.of(context).copyWith().size.height / 3,
                            child: CustomCupertinoPicker(
                              text: "血液型",
                              items: ConstFile.bloodItems, 
                              onSelectedItemChanged: (int index){
                                changeBlood(index);
                              },
                            )
                          );
                      });
                },
                child: ProfileItem(label: "血液型", text: ConstFile.bloodItems[blood])
              ),
// ----------------birth--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                            ),
                            height: MediaQuery.of(context).copyWith().size.height / 3,
                            child: CustomCupertinoPicker(
                              text: "出身地",
                              items: ConstFile.prefectureItems, 
                              onSelectedItemChanged: (int index){
                                changeBirth(index);
                              }
                            )
                          );
                      });
                },
                child: ProfileItem(label: "出身地", text: ConstFile.prefectureItems[birth])
              ),
// ----------------education--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                            ),
                            height: MediaQuery.of(context).copyWith().size.height / 3,
                            child: CustomCupertinoPicker(
                              text: "学歴",
                              items: ConstFile.educationItems, 
                              onSelectedItemChanged: (int index){
                                changeEducation(index);
                              }
                            )
                          );
                      });
                },
                child: ProfileItem(label: "学歴", text: ConstFile.educationItems[education])
              ),
// ----------------jobType--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                          ),
                          height: MediaQuery.of(context).copyWith().size.height / 3,
                          child: CustomCupertinoPicker(
                            text: "職種",
                            items: ConstFile.jobTypes, 
                            onSelectedItemChanged: (int index){
                              changeJobType(index);
                            }
                          )
                        );
                    });
                },
                child: ProfileItem(label: "職種", text: ConstFile.jobTypes[jobType])
              ),
// ----------------income--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                          ),
                          height: MediaQuery.of(context).copyWith().size.height / 3,
                          child: CustomCupertinoPicker(
                            text: "年収",
                            items: ConstFile.incomes, 
                            onSelectedItemChanged: (int index){
                              changeIncome(index);
                            }
                          )
                        );
                    });
                },
                child: ProfileItem(label: "年収", text: ConstFile.incomes[income])
              ),
// ----------------holiday--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                          ),
                          height: MediaQuery.of(context).copyWith().size.height / 3,
                          child: CustomCupertinoPicker(
                            text: "休日",
                            items: ConstFile.holidayItem, 
                            onSelectedItemChanged: (int index){
                              changeHoliday(index);
                            }
                          )
                        );
                    });
                },
                child: ProfileItem(label: "休日", text: holiday!=null?ConstFile.holidayItem[holiday!]:"")
              ),
// ----------------roommate--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                          ),
                          height: MediaQuery.of(context).copyWith().size.height / 3,
                          child: CustomCupertinoPicker(
                            text: "同居人",
                            items: ConstFile.roommateItem, 
                            onSelectedItemChanged: (int index){
                              changeRoomate(index);
                            }
                          )
                        );
                    });
                },
                child: ProfileItem(label: "同居人", text: roommate!=null?ConstFile.roommateItem[roommate!]:"")
              ),
// ----------------alcohol--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                          ),
                          height: MediaQuery.of(context).copyWith().size.height / 3,
                          child: CustomCupertinoPicker(
                            text: "お酒",
                            items: ConstFile.alcoholItem, 
                            onSelectedItemChanged: (int index){
                              changeAlcohol(index);
                            }
                          )
                        );
                    });
                },
                child: ProfileItem(label: "お酒", text: alcohol!=null?ConstFile.alcoholItem[alcohol!]:"")
              ),
// ----------------smoking--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                          ),
                          height: MediaQuery.of(context).copyWith().size.height / 3,
                          child: CustomCupertinoPicker(
                            text: "タバコ",
                            items: ConstFile.smokingItem, 
                            onSelectedItemChanged: (int index){
                              changeSmoking(index);
                            }
                          )
                        );
                    });
                },
                child: ProfileItem(label: "タバコ", text: smoking!=null?ConstFile.smokingItem[smoking!]:"")
              ),
// ----------------maritalHistory--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                          ),
                          height: MediaQuery.of(context).copyWith().size.height / 3,
                          child: CustomCupertinoPicker(
                            text: "婚歴",
                            items: ConstFile.maritalHistories, 
                            onSelectedItemChanged: (int index){
                              changeMaritalHistory(index);
                            }
                          )
                        );
                    });
                },
                child: ProfileItem(label: "婚歴", text: ConstFile.maritalHistories[maritalHistory])
              ),
// ----------------attitude--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                          ),
                          height: MediaQuery.of(context).copyWith().size.height / 3,
                          child: CustomCupertinoPicker(
                            text: "結婚に対する意識",
                            items: ConstFile.attitudes, 
                            onSelectedItemChanged: (int index){
                              changeAttitude(index);
                            }
                          )
                        );
                    });
                },
                child: ProfileItem(label: "結婚に対する意思", text: ConstFile.attitudes[attitude])
              ),
// ----------------children--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                          ),
                          height: MediaQuery.of(context).copyWith().size.height / 3,
                          child: CustomCupertinoPicker(
                            text: "子供の有無",
                            items: ConstFile.childrenItems, 
                            onSelectedItemChanged: (int index){
                              changeChildren(index);
                            }
                          )
                        );
                    });
                },
                child: ProfileItem(label: "子供の有無", text: ConstFile.childrenItems[children])
              ),
// ----------------housework--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                          ),
                          height: MediaQuery.of(context).copyWith().size.height / 3,
                          child: CustomCupertinoPicker(
                            text: "家事や育児",
                            items: ConstFile.houseworkItems, 
                            onSelectedItemChanged: (int index){
                              changeHousework(index);
                            }
                          )
                        );
                    });
                },
                child: ProfileItem(label: "家事や育児", text: ConstFile.houseworkItems[housework])
              ),
// ----------------hopeMeet--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryWhite,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                        ),
                        height: MediaQuery.of(context).copyWith().size.height / 3,
                        child: CustomCupertinoPicker(
                          text: "出会うまでの希望",
                          items: ConstFile.hopeMeetItems, 
                          onSelectedItemChanged: (int index){
                            changeHopeMeet(index);
                          }
                        )
                      );
                    });
                },
                child: ProfileItem(label: "出会うまでの希望", text: ConstFile.hopeMeetItems[hopeMeet])
              ),
// ----------------dateCost--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryWhite,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                        ),
                        height: MediaQuery.of(context).copyWith().size.height / 3,
                        child: CustomCupertinoPicker(
                          text: "初回のデート費用",
                          items: ConstFile.dateCostItems, 
                          onSelectedItemChanged: (int index){
                            changeDateCost(index);
                          }
                        )
                      );
                    });
                },
                child: ProfileItem(label: "初回のデート費用", text: ConstFile.dateCostItems[dateCost])
              ),
// ----------------saving--------------
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                          ),
                          height: MediaQuery.of(context).copyWith().size.height / 3,
                          child: CustomCupertinoPicker(
                            text: "貯蓄",
                            items: ConstFile.smokingItem, 
                            onSelectedItemChanged: (int index){
                              changeSaving(index);
                            }
                          )
                        );
                    });
                },
                child: ProfileItem(label: "貯蓄", text: savings!=null?ConstFile.savingsItem[savings!]:"")
              ),
            ],
          )

        ],
      ),
    );
  }
}

class ProfileItem extends StatelessWidget{
  const ProfileItem({
    super.key, required this.label, required this.text, this.isText
 });

 final String label;
 final String text;
 final bool? isText;
  
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
            Row(
              children: [
                if(text != "")
                  CustomText(
                    text: text, 
                    fontSize: 13, 
                    fontWeight: FontWeight.normal, 
                    lineHeight: 1, 
                    letterSpacing: 1, 
                    color: AppColors.secondaryGreen
                  ),
                if(text == "")
                  CustomText(
                    text: "未設定 +10P", 
                    fontSize: 13, 
                    fontWeight: FontWeight.normal, 
                    lineHeight: 1, 
                    letterSpacing: 1, 
                    color: AppColors.secondaryBlue
                  ),
                if(isText == null)
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.secondaryGray.withOpacity(0.5),
                  ),
                if(isText != null)
                  const SizedBox(
                    width: 20,
                  )
              ],
            )
            
          ],
        ),
      ),
    );
  }
}
