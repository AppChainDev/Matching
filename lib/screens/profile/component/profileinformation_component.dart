import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/components/picker/cupertinopicker.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:rinlin/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileInformationWidget extends StatefulWidget{
  const ProfileInformationWidget({
    super.key
 });

  @override
  State<ProfileInformationWidget> createState() => _ProfileInformationWidgetState();
}

class _ProfileInformationWidgetState extends State<ProfileInformationWidget> {
  late String name;
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
  int? roomate;
  int? alcohol;
  int? smoking;
  int? savings;

  bool isLoding = false;

  @override
  void initState() {
    super.initState();
    getProfileInformation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getProfileInformation() async{
    setState(() {
      name =  Provider.of<UserState>(context, listen: false).user!.name;
      blood = Provider.of<UserState>(context, listen: false).user!.blood;
      prefectureId = Provider.of<UserState>(context, listen: false).user!.prefectureId;
      height = Provider.of<UserState>(context, listen: false).user!.height;
      bodyType = Provider.of<UserState>(context, listen: false).user!.bodyType;
      birth = Provider.of<UserState>(context, listen: false).user!.birth;
      education = Provider.of<UserState>(context, listen: false).user!.education;
      jobType = Provider.of<UserState>(context, listen: false).user!.jobType;
      income = Provider.of<UserState>(context, listen: false).user!.income;
      maritalHistory = Provider.of<UserState>(context, listen: false).user!.materialHistory;
      attitude = Provider.of<UserState>(context, listen: false).user!.attitude;
      children = Provider.of<UserState>(context, listen: false).user!.children;
      housework = Provider.of<UserState>(context, listen: false).user!.housework;
      hopeMeet = Provider.of<UserState>(context, listen: false).user!.hopeMeet;
      dateCost = Provider.of<UserState>(context, listen: false).user!.dateCost;
      holiday = Provider.of<UserState>(context, listen: false).user!.holiday;
      roomate = Provider.of<UserState>(context, listen: false).user!.roomate;
      alcohol = Provider.of<UserState>(context, listen: false).user!.alcohol;
      smoking = Provider.of<UserState>(context, listen: false).user!.smoking;
      savings = Provider.of<UserState>(context, listen: false).user!.saving;
      isLoding = true;
    });
  }

  Future<void> changePrefecture(int index) async{
    setState(() {
      prefectureId = index;
    });
    await Provider.of<UserState>(context, listen: false).updatePrefecture(prefectureId);
  }
  Future<void> changeHeight(int index) async{
    setState(() {
      height = 130 + index; 
    });
    await Provider.of<UserState>(context, listen: false).updateHeight(height);
  }
  Future<void> changebodyType(int index) async{
    setState(() {
      bodyType = index;
    });
    await Provider.of<UserState>(context, listen: false).updateBodyType(bodyType);
  }
  Future<void> changeBlood(int index) async{
    setState(() {
      blood = index;
    });
    await Provider.of<UserState>(context, listen: false).updateBlood(blood);
  }
  Future<void> changeBirth(int index) async{
    setState(() {
      birth = index;
    });
    await Provider.of<UserState>(context, listen: false).updateBirth(birth);
  }
  Future<void> changeEducation(int index) async{
    setState(() {
      education = index;
    });
    await Provider.of<UserState>(context, listen: false).updateEducation(education);
  }
  Future<void> changeJobType(int index) async{
    setState(() {
      jobType = index;
    });
    await Provider.of<UserState>(context, listen: false).updateJobType(jobType);
  }
  Future<void> changeIncome(int index) async{
    setState(() {
      income = index;
    });
    await Provider.of<UserState>(context, listen: false).updateIncome(income);
  }
  Future<void> changeHoliday(int index) async{
    setState(() {
      holiday = index;
    });
    await Provider.of<UserState>(context, listen: false).updateHoliday(holiday!);
  }
  Future<void> changeRoomate(int index) async{
    setState(() {
      roomate = index;
    });
    await Provider.of<UserState>(context, listen: false).updateRoomate(roomate!);
  }
  Future<void> changeAlcohol(int index) async{
    setState(() {
      alcohol = index;
    });
    await Provider.of<UserState>(context, listen: false).updateAlcohol(alcohol!);
  }
  Future<void> changeSmoking(int index) async{
    setState(() {
      smoking = index;
    });
    await Provider.of<UserState>(context, listen: false).updateSmoking(smoking!);
  }
  Future<void> changeMaritalHistory(int index) async{
    setState(() {
      maritalHistory = index;
    });
    await Provider.of<UserState>(context, listen: false).updateMaritalHistory(maritalHistory);
  }
  Future<void> changeAttitude(int index) async{
    setState(() {
      attitude = index;
    });
    await Provider.of<UserState>(context, listen: false).updateAttitude(attitude);
  }
  Future<void> changeChildren(int index) async{
    setState(() {
      children =  index;
    });
    await Provider.of<UserState>(context, listen: false).updateChildren(children);
  }
  Future<void> changeHousework(int index) async{
    setState(() {
      housework =  index;
    });
    await Provider.of<UserState>(context, listen: false).updateHousework(housework);
  }
  Future<void> changeHopeMeet(int index) async{
    setState(() {
      hopeMeet =  index;
    });
    await Provider.of<UserState>(context, listen: false).updateHopeMeet(hopeMeet);
  }
  Future<void> changeDateCost(int index) async{
    setState(() {
      dateCost =  index;
    });
    await Provider.of<UserState>(context, listen: false).updateDateCost(dateCost);
  }
  Future<void> changeSaving(int index) async{
    setState(() {
      savings =  index;
    });
    await Provider.of<UserState>(context, listen: false).updateSaving(savings!);
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
      child: isLoding? Column(
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
// ----------------roomate--------------
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
                            items: ConstFile.roomateItem, 
                            onSelectedItemChanged: (int index){
                              changeRoomate(index);
                            }
                          )
                        );
                    });
                },
                child: ProfileItem(label: "同居人", text: roomate!=null?ConstFile.roomateItem[roomate!]:"")
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
      ): const Center(
        child: CircularProgressIndicator(),
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
