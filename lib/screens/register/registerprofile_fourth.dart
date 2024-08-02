import 'package:drone/components/app_colors.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_container.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/components/picker/cupertinopicker.dart';
import 'package:drone/state/user_state.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterProfileFourthScreen extends StatefulWidget {

  const RegisterProfileFourthScreen({super.key});

  @override
  State<RegisterProfileFourthScreen> createState() => _RegisterProfileFourthScreenState();
}

class _RegisterProfileFourthScreenState extends State<RegisterProfileFourthScreen> {

  final TextEditingController bloodController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController jobTypeController = TextEditingController();
  final TextEditingController maritalHistoryController = TextEditingController();
  final TextEditingController childrenController = TextEditingController();
  final TextEditingController houseworkController = TextEditingController();
  final TextEditingController hopeMeetController = TextEditingController();
  final TextEditingController dateCostController = TextEditingController();
  int blood = 0;
  int education = 0;
  int birth = 0;
  int income = 0;
  int jobType = 0;
  int maritalHistory = 0;
  int children = 0;
  int housework = 0;
  int hopeMeet = 0;
  int dateCost = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeBlood(int index) {
    setState(() {
      blood = index;
      bloodController.text = ConstFile.bloodItems[index]; 
    });
  }

  void changeBirth(int index) {
    setState(() {
      birth = index;
      birthController.text = ConstFile.prefectureItems[index]; 
    });
  }
  
  void changeEducation(int index) {
    setState(() {
      education = index;
      educationController.text = ConstFile.educationItems[index];
    });
  }

  void changeJobType(int index) {
    setState(() {
      jobType = index;
      jobTypeController.text = ConstFile.jobTypes[index];
    });
  }

  void changeIncome(int index) {
    setState(() {
      income = index;
      incomeController.text = ConstFile.incomes[index];
    });
  }

  void changeMaritalHistory(int index) {
    setState(() {
      maritalHistory = index;
      maritalHistoryController.text = ConstFile.maritalHistories[index];
    });
  }

  void changeChildren(int index) {
    setState(() {
      children =  index;
      childrenController.text = ConstFile.childrenItems[index];
    });
  }

  void changeHousework(int index) {
    setState(() {
      housework =  index;
      houseworkController.text = ConstFile.houseworkItems[index];
    });
  }

  void changeHopeMeet(int index) {
    setState(() {
      hopeMeet =  index;
      hopeMeetController.text = ConstFile.hopeMeetItems[index];
    });
  }
  void changeDateCost(int index) {
    setState(() {
      dateCost =  index;
      dateCostController.text = ConstFile.dateCostItems[index];
    });
  }

  bool isCompleted(){
    if(
      bloodController.text.isNotEmpty && 
      birthController.text.isNotEmpty && 
      educationController.text.isNotEmpty && 
      jobTypeController.text.isNotEmpty &&
      maritalHistoryController.text.isNotEmpty &&
      incomeController.text.isNotEmpty &&
      childrenController.text.isNotEmpty &&
      houseworkController.text.isNotEmpty &&
      hopeMeetController.text.isNotEmpty &&
      dateCostController.text.isNotEmpty 
    ){
      return true;
    } else {
      return false;
    }
  }

  Future saveSecondStep() async{
    final isSaved = await Provider.of<UserState>(context, listen: false).saveSecondStep(blood, birth, education, jobType, maritalHistory, income, children, housework, hopeMeet, dateCost);
    if(isSaved){
      Navigator.pushNamed(context, "/registerprofile_group");
    } else{
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
                  "情報を保存できませんでした。",
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
                      color: isCompleted()?AppColors.secondaryGreen:AppColors.secondaryGreen.withOpacity(0.5), 
                      titleColor: AppColors.primaryWhite, 
                      onTap: () { 
                        if(isCompleted()){
                          saveSecondStep();
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
              decoration: BoxDecoration(
                color: AppColors.primaryWhite
              ),
               child: SingleChildScrollView(
                 child: Column(
                   children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 120, left: 30, right: 30, bottom: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [                       
// ------------------blood---------------------------
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "血液型", 
                                fontSize: 13, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  readOnly: true,
                                  controller: bloodController,
                                  style: TextStyle(
                                    color: AppColors.secondaryGreen
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "選択してください",
                                    focusColor: AppColors.secondaryGreen,
                                    contentPadding: const EdgeInsets.all(10),
                                    suffixIcon: const Icon(
                                      Icons.keyboard_arrow_down_rounded
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                  
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
                                ),
                              ),
                            ],
                          ),
// ------------------birth---------------------------
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "出身地", 
                                fontSize: 13, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  readOnly: true,
                                  controller: birthController,
                                  style: TextStyle(
                                    color: AppColors.secondaryGreen
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "選択してください",
                                    contentPadding: const EdgeInsets.all(10),
                                    suffixIcon: const Icon(
                                      Icons.keyboard_arrow_down_rounded
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),                              
                                  onTap: (){
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
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
// ------------------education---------------------------                       
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "学歴", 
                                fontSize: 13, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  readOnly: true,
                                  controller: educationController,
                                  style: TextStyle(
                                    color: AppColors.secondaryGreen
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "選択してください",
                                    contentPadding: const EdgeInsets.all(10),
                                    suffixIcon: const Icon(
                                      Icons.keyboard_arrow_down_rounded
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),                              
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
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
// ------------------jobTypes---------------------------                       
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "職種", 
                                fontSize: 13, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  readOnly: true,
                                  controller: jobTypeController,
                                  style: TextStyle(
                                    color: AppColors.secondaryGreen
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "選択してください",
                                    contentPadding: const EdgeInsets.all(10),
                                    suffixIcon: const Icon(
                                      Icons.keyboard_arrow_down_rounded
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),                              
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
                                ),
                              ),
                            ],
                          ),
// ------------------income---------------------------
                          const SizedBox(
                            height: 30,
                          ),              
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "年収", 
                                fontSize: 13, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  readOnly: true,
                                  controller: incomeController,
                                  style: TextStyle(
                                    color: AppColors.secondaryGreen
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "選択してください",
                                    contentPadding: const EdgeInsets.all(10),
                                    suffixIcon: const Icon(
                                      Icons.keyboard_arrow_down_rounded
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),                              
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
                                ),
                              ),
                            ],
                          ),
// ------------------maritalHistory---------------------------
                          const SizedBox(
                            height: 30,
                          ),                       
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "婚歴", 
                                fontSize: 13, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  readOnly: true,
                                  controller: maritalHistoryController,
                                  style: TextStyle(
                                    color: AppColors.secondaryGreen
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "選択してください",
                                    contentPadding: const EdgeInsets.all(10),
                                    suffixIcon: const Icon(
                                      Icons.keyboard_arrow_down_rounded
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),                              
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
                                ),
                              ),
                            ],
                          ),
// ------------------children---------------------------
                          const SizedBox(
                            height: 30,
                          ),                       
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "子供の有無", 
                                fontSize: 13, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  readOnly: true,
                                  controller: childrenController,
                                  style: TextStyle(
                                    color: AppColors.secondaryGreen
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "選択してください",
                                    contentPadding: const EdgeInsets.all(10),
                                    suffixIcon: const Icon(
                                      Icons.keyboard_arrow_down_rounded
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),                              
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
                                ),
                              ),
                            ],
                          ),
// ------------------housework---------------------------                       
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "家事や育児", 
                                fontSize: 13, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  readOnly: true,
                                  controller: houseworkController,
                                  style: TextStyle(
                                    color: AppColors.secondaryGreen
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "選択してください",
                                    contentPadding: const EdgeInsets.all(10),
                                    suffixIcon: const Icon(
                                      Icons.keyboard_arrow_down_rounded
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),                              
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
                                ),
                              ),
                            ],
                          ),                      
// ------------------hopeMeet---------------------------                       
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "出会うまでの希望", 
                                fontSize: 13, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  readOnly: true,
                                  controller: hopeMeetController,
                                  style: TextStyle(
                                    color: AppColors.secondaryGreen
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "選択してください",
                                    contentPadding: const EdgeInsets.all(10),
                                    suffixIcon: const Icon(
                                      Icons.keyboard_arrow_down_rounded
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),                              
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
                                ),
                              ),
                            ],
                          ),
// ------------------dateCost---------------------------                       
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "初回のデート費用", 
                                fontSize: 13, 
                                fontWeight: FontWeight.normal, 
                                lineHeight: 1, 
                                letterSpacing: 1, 
                                color: AppColors.primaryBlack
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  readOnly: true,
                                  controller: dateCostController,
                                  style: TextStyle(
                                    color: AppColors.secondaryGreen
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "選択してください",
                                    contentPadding: const EdgeInsets.all(10),
                                    suffixIcon: const Icon(
                                      Icons.keyboard_arrow_down_rounded
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),                              
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
                                ),
                              ),
                            ],
                          ),
                 
                        ],
                      ),
                    ),
                   ],
                 ),
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
                      text: "プロフィール登録", 
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
           Center(
            child: CustomContainer(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(top:46),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color:AppColors.primaryWhite,
                      )
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


class GenderItem extends StatelessWidget {
  const GenderItem({super.key, required this.inChecked, required this.id, required this.text});
  
  final int id;
  final String text;
  final bool inChecked;

  Color getBackColor(BuildContext context) {
    return inChecked ? AppColors.secondaryGreen : AppColors.primaryWhite;
  }
  Color getBorderColor(BuildContext context) {
    return inChecked ? Colors.transparent : AppColors.secondaryGray;
  }
  Color getTextColor(BuildContext context) {
    return inChecked ? AppColors.primaryWhite : AppColors.secondaryGray;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: getBorderColor(context)
        ),
        color: getBackColor(context)
      ),
      width: 93,
      height: 35,
      child: Center(
        child: CustomText(
          text: text, 
          fontSize: 13, 
          fontWeight: FontWeight.normal, 
          lineHeight: 1, 
          letterSpacing: 1, 
          color: getTextColor(context)
        ),
      ),
    );
  }
}
