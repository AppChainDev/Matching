import 'package:date_format_field/date_format_field.dart';
import 'package:drone/components/app_colors.dart';
import 'package:drone/components/custom_button.dart';
import 'package:drone/components/custom_text.dart';
import 'package:drone/models/category_model.dart';
import 'package:drone/models/pilotid_model.dart';
import 'package:drone/models/requestjop_model.dart';
import 'package:drone/utils/const_file.dart';
import 'package:flutter/material.dart';
import 'package:drone/components/base_screen.dart';
import 'package:drone/components/custom_container.dart';
import 'package:flutter/services.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class RequestScreen extends StatefulWidget {

  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final TextEditingController emailController = TextEditingController();
  final List<String> prefectureItems = ConstFile.prefectureItems;
  static List<Category> categories = [
    // "なし", "カテゴリー名1", "カテゴリー名2", "カテゴリー名3"
    Category(id: 1, label: "カテゴリー名1"),
    Category(id: 2, label: "カテゴリー名2"),
    Category(id: 3, label: "カテゴリー名3")
  ];
  final MultiSelectController<int> _controller = MultiSelectController();
  final _items = categories.map((category) => ValueItem(label: category.label, value: category.id)).toList();
  int selectedPrefectureValue = 0;
  List<ValueItem> selectedCategoryList = [];
  bool selectedrequestDeadline = false;
  int selectedstartDate = 0;
  int selectedsalaryType = 1;
  final List<int> yearItems = List<int>.generate(101, (index) => 1950 + index);
  final List<int> monthItems = List<int>.generate(12, (index) => 1 + index);
  final List<int> dayItems = List<int>.generate(31, (index) => 1 + index);
  int selectedYearValue = DateTime.now().year;
  int selectedMonthValue = DateTime.now().month;
  int selectedDayValue = DateTime.now().day;

  final TextEditingController salaryController = TextEditingController();
  final TextEditingController salaryMinController = TextEditingController();
  final TextEditingController salaryMaxController = TextEditingController();
  final TextEditingController introduceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  DateTime? startMinDate;
  DateTime? startMaxDate;
  
  late int deadlineYear;
  late int deadlineMonth;
  late int deadlineDay;
  
  late int salary;
  late int salaryMin;
  late int salaryMax;

  late String? startMinDateValue;
  late String? startMaxDateValue;

  void filterInputValue() {
    if(selectedrequestDeadline){
      deadlineYear = selectedYearValue;
      deadlineMonth = selectedMonthValue;
      deadlineDay = selectedDayValue;
    }else{
      deadlineYear = 0;
      deadlineMonth = 0;
      deadlineDay = 0;
    }
    switch (selectedsalaryType) {
      case 2:
        salary = 0;
        salaryMin = salaryMinController.text!=""?int.parse(salaryMinController.text):0;
        salaryMax = salaryMaxController.text!=""?int.parse(salaryMaxController.text):0;
        break;
      case 1:
        salary = salaryController.text!=""?int.parse(salaryController.text):0;
        salaryMin = 0;
        salaryMax = 0;
        break;
    }
    switch (selectedstartDate) {
      case 1:
        startMinDateValue = startMinDate.toString();
        startMaxDateValue = "";
        break;
      case 2:
        startMinDateValue = startMinDate.toString();
        startMaxDateValue = startMaxDate.toString();
        break;
      default:
        startMinDateValue = "";
        startMaxDateValue = "";
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PilotidIdModel;
    return BaseScreen(
      child: Stack(
        children: [
           Center(
             child: CustomContainer(
              child: Image.asset(
                "assets/images/white_commonback.png",
                fit: BoxFit.cover
              ),
             ),
           ),
           Center(
             child: CustomContainer(
               child: Padding(
                padding: const EdgeInsets.only(bottom: 81),
                 child: SingleChildScrollView(
                   child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 375,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 103, left: 20, right: 20, bottom: 81),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "カテゴリ", 
                                      fontSize: 13, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      color: AppColors.primaryBlack,
                                      letterSpacing: 1,
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Container(
                                      // padding: const EdgeInsets.symmetric(vertical: 5),
                                      // height: 45,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryWhite, borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.secondaryGray.withOpacity(0.25), // Shadow color
                                            spreadRadius: 0.5, // Spread radius
                                            blurRadius: 5, // Blur radius
                                            offset: const Offset(0, 1), // Shadow position (x, y)
                                          ),
                                        ]
                                      ), 
                                      child: MultiSelectDropDown<int>(
                                        controller: _controller,
                                        clearIcon: const Icon(Icons.close),
                                        onOptionSelected: (options) {
                                          selectedCategoryList = options;
                                        },
                                        options: _items,
                                        dropdownMargin: 2,
                                        selectionType: SelectionType.multi,
                                        chipConfig: ChipConfig(
                                          wrapType: WrapType.scroll, 
                                          backgroundColor: AppColors.secondaryBlue,
                                        ),
                                        optionTextStyle: const TextStyle(fontSize: 12),
                                        selectedOptionIcon: const Icon(Icons.check_circle),
                                        onOptionRemoved: (index, option) {},
                                        optionBuilder: (context, valueItem, isSelected) {
                                          return ListTile(
                                            title: Text(valueItem.label),
                                            trailing: isSelected
                                                ? Icon(Icons.check_circle, color: AppColors.secondaryBlue,)
                                                : Icon(Icons.radio_button_unchecked, color: AppColors.secondaryBlue),
                                          );
                                        },
                                      ),
                                    ),
                                  ]
                                ),
                                const SizedBox(
                                  height: 21.6,
                                ),
                                //----------- address --------------
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "エリア", 
                                      fontSize: 13, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      color: AppColors.primaryBlack,
                                      letterSpacing: 1,
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          height: 45,
                                          width: 161,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryWhite, borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.secondaryGray.withOpacity(0.25), // Shadow color
                                                spreadRadius: 0.5, // Spread radius
                                                blurRadius: 5, // Blur radius
                                                offset: const Offset(0, 1), // Shadow position (x, y)
                                              ),
                                            ]
                                          ), 
                                          child: DropdownButton<int>(
                                            value: selectedPrefectureValue,
                                            dropdownColor: AppColors.primaryWhite,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedPrefectureValue = value!;
                                              });
                                            },
                                            items: prefectureItems
                                                .map<DropdownMenuItem<int>>(
                                                    (String value) => DropdownMenuItem<int>(
                                                          value: prefectureItems.indexOf(value),
                                                          child: Text(
                                                            value.toString(),
                                                            style: TextStyle(
                                                              color: AppColors.primaryBlack
                                                            ),
                                                          ),
                                                        ))
                                                .toList(),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            iconSize: 30,
                                            underline: const SizedBox(),
                                            isExpanded: true,
                                          ),
                                        ),
                                        Container(
                                          width: 161,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.secondaryGray.withOpacity(0.25), // Shadow color
                                                spreadRadius: 0.5, // Spread radius
                                                blurRadius: 5, // Blur radius
                                                offset: const Offset(0, 1), // Shadow position (x, y)
                                              ),
                                            ]
                                          ),
                                          child: TextField(
                                            controller: cityController,
                                            textAlign: TextAlign.start,
                                            keyboardType: TextInputType.text,
                                            cursorColor: AppColors.primaryBlack,
                                            style: TextStyle(
                                              color:AppColors.primaryBlack
                                            ),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              hoverColor: AppColors.primaryWhite,
                                              filled: true,
                                              contentPadding: const EdgeInsets.all(15),
                                              fillColor: AppColors.primaryWhite,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ]
                                ),
                                const SizedBox(
                                  height: 21.6,
                                ),
                                //----------- request deadline --------------
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "募集期限", 
                                      fontSize: 13, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      color: AppColors.primaryBlack,
                                      letterSpacing: 1,
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 22,
                                                  child: RadioListTile(
                                                    value: false,
                                                    groupValue: selectedrequestDeadline,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedrequestDeadline = value!;
                                                      });
                                                    },
                                                    activeColor: AppColors.primaryRed,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                CustomText(
                                                  text: "期限なし", 
                                                  fontSize: 14, 
                                                  fontWeight: FontWeight.bold, 
                                                  lineHeight: 1, 
                                                  letterSpacing: 1.5, 
                                                  color: AppColors.primaryBlack
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 22,
                                                  child: RadioListTile(
                                                    value: true,
                                                    groupValue: selectedrequestDeadline,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedrequestDeadline = value!;
                                                      });
                                                    },
                                                    activeColor: AppColors.primaryRed,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                CustomText(
                                                  text: "期限あり", 
                                                  fontSize: 14, 
                                                  fontWeight: FontWeight.bold, 
                                                  lineHeight: 1, 
                                                  letterSpacing: 1.5, 
                                                  color: AppColors.primaryBlack
                                                )
                                              ],
                                            ),
                                            if(selectedrequestDeadline)
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      // --------year--------
                                                      Container(
                                                        width: 104,
                                                        height: 45,
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                        decoration: BoxDecoration(
                                                            color: AppColors.primaryWhite, borderRadius: BorderRadius.circular(10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: AppColors.secondaryGray.withOpacity(0.25), // Shadow color
                                                                spreadRadius: 0.5, // Spread radius
                                                                blurRadius: 5, // Blur radius
                                                                offset: const Offset(0, 1), // Shadow position (x, y)
                                                              ),
                                                            ]
                                                        ),
                                                        child: Center(
                                                          child: DropdownButton<int>(
                                                            value: selectedYearValue,
                                                            dropdownColor: AppColors.primaryWhite,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedYearValue = value!;
                                                              });
                                                            },
                                                            items: yearItems
                                                                .map<DropdownMenuItem<int>>(
                                                                    (int value) => DropdownMenuItem<int>(
                                                                          value: value,
                                                                          child: Text(
                                                                            "${value.toString()}年",
                                                                            style: TextStyle(
                                                                              color: AppColors.primaryBlack
                                                                            ),
                                                                          ),
                                                                        ))
                                                                .toList(),
                                                            icon: const Icon(Icons.keyboard_arrow_down),
                                                            iconSize: 30,
                                                            underline: const SizedBox(),
                                                            isExpanded: true,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 11.5,
                                                      ),
                                                      //---------- month-----------
                                                      Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                        width: 104,
                                                        height: 45,
                                                        decoration: BoxDecoration(
                                                          color: AppColors.primaryWhite, borderRadius: BorderRadius.circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: AppColors.secondaryGray.withOpacity(0.25), // Shadow color
                                                              spreadRadius: 0.5, // Spread radius
                                                              blurRadius: 5, // Blur radius
                                                              offset: const Offset(0, 1), // Shadow position (x, y)
                                                            ),
                                                          ]
                                                        ),
                                                        child: Center(
                                                          child: DropdownButton<int>(
                                                            value: selectedMonthValue,
                                                            dropdownColor: AppColors.primaryWhite,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedMonthValue = value!;
                                                              });
                                                            },
                                                            items: monthItems
                                                                .map<DropdownMenuItem<int>>(
                                                                    (int value) => DropdownMenuItem<int>(
                                                                          value: value,
                                                                          child: Text(
                                                                            "${value.toString()}月",
                                                                            style: TextStyle(
                                                                              color: AppColors.primaryBlack
                                                                            ),
                                                                          ),
                                                                        ))
                                                                .toList(),
                                                            icon: const Icon(Icons.keyboard_arrow_down),
                                                            iconSize: 30,
                                                            underline: const SizedBox(),
                                                            isExpanded: true,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 11.5,
                                                      ),
                                                      //---------- day-----------
                                                      Container(
                                                        width: 104,
                                                        height: 45,
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                        decoration: BoxDecoration(
                                                          color: AppColors.primaryWhite, borderRadius: BorderRadius.circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: AppColors.secondaryGray.withOpacity(0.25), // Shadow color
                                                              spreadRadius: 0.5, // Spread radius
                                                              blurRadius: 5, // Blur radius
                                                              offset: const Offset(0, 1), // Shadow position (x, y)
                                                            ),
                                                          ]
                                                        ),
                                                        child: Center(
                                                          child: DropdownButton<int>(
                                                            value: selectedDayValue,
                                                            dropdownColor: AppColors.primaryWhite,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedDayValue = value!;
                                                              });
                                                            },
                                                            items: dayItems
                                                                .map<DropdownMenuItem<int>>(
                                                                    (int value) => DropdownMenuItem<int>(
                                                                          value: value,
                                                                          child: Text(
                                                                            "${value.toString()}日",
                                                                            style: TextStyle(
                                                                              color: AppColors.primaryBlack
                                                                            ),
                                                                          ),
                                                                        ))
                                                                .toList(),
                                                            icon: const Icon(Icons.keyboard_arrow_down),
                                                            iconSize: 30,
                                                            underline: const SizedBox(),
                                                            isExpanded: true,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]
                                              ), 
                                          ],
                                        ),
                                      ],
                                    ),
                                  ]
                                ),
                                const SizedBox(
                                  height: 21.6,
                                ),
// ---------ammount---------------
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "依頼金額", 
                                      fontSize: 13, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      color: AppColors.primaryBlack,
                                      letterSpacing: 1,
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 22,
                                              child: RadioListTile(
                                                value: 1,
                                                groupValue: selectedsalaryType,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedsalaryType = value!;
                                                  });
                                                },
                                                activeColor: AppColors.primaryRed,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            CustomText(
                                              text: "固定金額", 
                                              fontSize: 14, 
                                              fontWeight: FontWeight.bold, 
                                              lineHeight: 1, 
                                              letterSpacing: 1.5, 
                                              color: AppColors.primaryBlack
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 22,
                                              child: RadioListTile(
                                                value: 2,
                                                groupValue: selectedsalaryType,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedsalaryType = value!;
                                                  });
                                                },
                                                activeColor: AppColors.primaryRed,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            CustomText(
                                              text: "範囲金額", 
                                              fontSize: 14, 
                                              fontWeight: FontWeight.bold, 
                                              lineHeight: 1, 
                                              letterSpacing: 1.5, 
                                              color: AppColors.primaryBlack
                                            )
                                          ],
                                        ),
                                        // const SizedBox(
                                        //   height: 16,
                                        // ),
                                        if(selectedsalaryType==1)
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.secondaryGray.withOpacity(0.25), // Shadow color
                                                  spreadRadius: 0.5, // Spread radius
                                                  blurRadius: 5, // Blur radius
                                                  offset: const Offset(0, 1), // Shadow position (x, y)
                                                ),
                                              ]
                                            ),
                                            child: TextField(
                                              controller: salaryController,
                                              textAlign: TextAlign.start,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              cursorColor: AppColors.primaryBlack,
                                              style: TextStyle(
                                                color:AppColors.primaryBlack
                                              ),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none,
                                                  ),
                                                ),
                                                hoverColor: AppColors.primaryWhite,
                                                filled: true,
                                                contentPadding: const EdgeInsets.all(15),
                                                fillColor: AppColors.primaryWhite,
                                              ),
                                            ),
                                          ),
                                        if(selectedsalaryType==2)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 152,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColors.secondaryGray.withOpacity(0.25), // Shadow color
                                                      spreadRadius: 0.5, // Spread radius
                                                      blurRadius: 5, // Blur radius
                                                      offset: const Offset(0, 1), // Shadow position (x, y)
                                                    ),
                                                  ]
                                                ),
                                                child: TextField(
                                                  controller: salaryMinController,
                                                  textAlign: TextAlign.start,
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  cursorColor: AppColors.primaryBlack,
                                                  style: TextStyle(
                                                    color:AppColors.primaryBlack
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: const BorderSide(
                                                        width: 0,
                                                        style: BorderStyle.none,
                                                      ),
                                                    ),
                                                    hoverColor: AppColors.primaryWhite,
                                                    filled: true,
                                                    contentPadding: const EdgeInsets.all(15),
                                                    fillColor: AppColors.primaryWhite,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 30,
                                                child: Center(
                                                  child: CustomText(
                                                    text: "~", 
                                                    fontSize: 14, 
                                                    fontWeight: FontWeight.bold, 
                                                    lineHeight: 1, 
                                                    letterSpacing: 1, 
                                                    color: AppColors.primaryBlack
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 152,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColors.secondaryGray.withOpacity(0.25), // Shadow color
                                                      spreadRadius: 0.5, // Spread radius
                                                      blurRadius: 5, // Blur radius
                                                      offset: const Offset(0, 1), // Shadow position (x, y)
                                                    ),
                                                  ]
                                                ),
                                                child: TextField(
                                                  controller: salaryMaxController,
                                                  textAlign: TextAlign.start,
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  cursorColor: AppColors.primaryBlack,
                                                  style: TextStyle(
                                                    color:AppColors.primaryBlack
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: const BorderSide(
                                                        width: 0,
                                                        style: BorderStyle.none,
                                                      ),
                                                    ),
                                                    hoverColor: AppColors.primaryWhite,
                                                    filled: true,
                                                    contentPadding: const EdgeInsets.all(15),
                                                    fillColor: AppColors.primaryWhite,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ]
                                ),
                                const SizedBox(
                                  height: 21.6,
                                ), 
                            //----------- start date --------------
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "募集期限", 
                                      fontSize: 13, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      color: AppColors.primaryBlack,
                                      letterSpacing: 1,
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 22,
                                                  child: RadioListTile(
                                                    value: 0,
                                                    groupValue: selectedstartDate,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedstartDate = value!;
                                                      });
                                                    },
                                                    activeColor: AppColors.primaryRed,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                CustomText(
                                                  text: "未定", 
                                                  fontSize: 14, 
                                                  fontWeight: FontWeight.bold, 
                                                  lineHeight: 1, 
                                                  letterSpacing: 1.5, 
                                                  color: AppColors.primaryBlack
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 22,
                                                  child: RadioListTile(
                                                    value: 1,
                                                    groupValue: selectedstartDate,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedstartDate = value!;
                                                      });
                                                    },
                                                    activeColor: AppColors.primaryRed,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                CustomText(
                                                  text: "日付指定", 
                                                  fontSize: 14, 
                                                  fontWeight: FontWeight.bold, 
                                                  lineHeight: 1, 
                                                  letterSpacing: 1.5, 
                                                  color: AppColors.primaryBlack
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 22,
                                                  child: RadioListTile(
                                                    value: 2,
                                                    groupValue: selectedstartDate,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedstartDate = value!;
                                                      });
                                                    },
                                                    activeColor: AppColors.primaryRed,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                CustomText(
                                                  text: "期間指定", 
                                                  fontSize: 14, 
                                                  fontWeight: FontWeight.bold, 
                                                  lineHeight: 1, 
                                                  letterSpacing: 1.5, 
                                                  color: AppColors.primaryBlack
                                                )
                                              ],
                                            ),
                                            
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                if(selectedstartDate==1 || selectedstartDate==2)
                                                  Container(
                                                    width: 152,
                                                    height: 45,
                                                    padding: const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.primaryWhite,
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(
                                                        color: AppColors.secondaryGray.withOpacity(0.2),
                                                        width: 1
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: AppColors.secondaryGray.withOpacity(0.25), // Shadow color
                                                          spreadRadius: 0.5, // Spread radius
                                                          blurRadius: 5, // Blur radius
                                                          offset: const Offset(0, 4), // Shadow position (x, y)
                                                        ),
                                                      ]
                                                    ),
                                                    child: DateFormatField(
                                                      onComplete: (date) {
                                                        startMinDate = date;
                                                      },
                                                      decoration: InputDecoration(
                                                        fillColor: AppColors.primaryWhite,
                                                      ), 
                                                      type: DateFormatType.type4,
                                                      addCalendar: true,
                                                    )
                                                  ),
                                                if(selectedstartDate==2)
                                                  SizedBox(
                                                    width: 30,
                                                    child: Center(
                                                      child: CustomText(
                                                        text: "~", 
                                                        fontSize: 14, 
                                                        fontWeight: FontWeight.bold, 
                                                        lineHeight: 1, 
                                                        letterSpacing: 1, 
                                                        color: AppColors.primaryBlack
                                                      ),
                                                    ),
                                                  ),
                                                if(selectedstartDate==2)
                                                  Container(
                                                    width: 152,
                                                    height: 45,
                                                    padding: const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.primaryWhite,
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(
                                                        color: AppColors.primaryWhite.withOpacity(0.2),
                                                        width: 1
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: AppColors.secondaryGray.withOpacity(0.25), // Shadow color
                                                          spreadRadius: 0.5, // Spread radius
                                                          blurRadius: 5, // Blur radius
                                                          offset: const Offset(0, 4), // Shadow position (x, y)
                                                        ),
                                                      ]
                                                    ),
                                                    child: DateFormatField(
                                                      onComplete: (date) {
                                                        startMaxDate = date;
                                                      }, 
                                                      type: DateFormatType.type4,
                                                      addCalendar: true,
                                                    )
                                                  ),
                                              ],
                                            )  
                                          ]),
                                        ],
                                      ),
                                    ]
                                ),
                                const SizedBox(
                                  height: 22.7,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "紹介文", 
                                      fontSize: 13, 
                                      fontWeight: FontWeight.bold, 
                                      lineHeight: 1, 
                                      color: AppColors.primaryBlack,
                                      letterSpacing: 1,
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryWhite,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.secondaryGray.withOpacity(0.25), // Shadow color
                                            spreadRadius: 0.5, // Spread radius
                                            blurRadius: 5, // Blur radius
                                            offset: const Offset(0, 4), // Shadow position (x, y)
                                          ),
                                        ]
                                      ),
                                      child: TextFormField(
                                        controller: introduceController,
                                        cursorColor: AppColors.primaryBlack,
                                        style: TextStyle(
                                          color: AppColors.primaryBlack
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(10.0),
                                        ),
                                        maxLines: null,
                                        expands: true,
                                      ),
                                    ),
                                  ]
                                ),
                                const SizedBox(
                                  height: 36.5
                                ),
                                CustomButton(
                                  title: "確認する", 
                                  width: 296, 
                                  fontSize: 16, 
                                  fontWeight: FontWeight.bold, 
                                  color: AppColors.secondaryBlue, 
                                  borderColor: AppColors.secondaryBlue, 
                                  titleColor: AppColors.primaryWhite, 
                                  onTap: (){
                                    filterInputValue();
                                    Navigator.pushNamed(context, "/requestconfirm", arguments: RequestJobModel(args.name, selectedCategoryList, selectedPrefectureValue, cityController.text, selectedrequestDeadline, deadlineYear, deadlineMonth, deadlineDay, selectedsalaryType, salary, salaryMin, salaryMax, selectedstartDate, startMinDateValue, startMaxDateValue, introduceController.text, id: args.id));
                                  }
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                   ),
                 ),
               ),
             ),
           ),
           Center(
             child: Padding(
              padding: const EdgeInsets.only(top: 44),
              child: CustomText(
                text: "案件依頼",
                fontSize: 16, 
                fontWeight: FontWeight.bold, 
                color: AppColors.primaryBlack,
                lineHeight: 1.5,
                letterSpacing: 1,
              )
             ),
           ),
           Center(
            child: CustomContainer(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(top:30, left:20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        icon: Image.asset("assets/images/black_backmark.png", fit: BoxFit.cover,)
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        onPressed: (){
                          Navigator.pushNamed(context, "/settingpilot");
                        }, 
                        icon: Image.asset("assets/images/back_settingicon.png", fit: BoxFit.cover,)
                      ),
                    ),
                  ],
                ),
              ),
            ),
           ),
           Center(
             child: CustomContainer(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                  height: 81,
                  color: AppColors.primaryWhite,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 94,
                        child: MaterialButton(
                          onPressed: () {
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  const AssetImage("assets/images/bx-search.png"),
                                  color: AppColors.secondaryBlue,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                CustomText(
                                  text: "探す", 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.secondaryBlue
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 94,
                        child: MaterialButton(
                          onPressed: () {
                            
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const ImageIcon(
                                  AssetImage("assets/images/bx-clipboard.png")
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                CustomText(
                                  text: "依頼一覧", 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.secondaryGray
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  const AssetImage("assets/images/bx-message-detail.png"),
                                  color: AppColors.secondaryGray,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                CustomText(
                                  text: "メッセージ", 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.secondaryGray
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 94,
                        child: MaterialButton(
                          onPressed: () {
                            
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const ImageIcon(
                                  AssetImage("assets/images/bx-wallet.png")
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                CustomText(
                                  text: "支払履歴", 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  lineHeight: 1, 
                                  letterSpacing: 1, 
                                  color: AppColors.secondaryGray
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  )
                ],
              )
             ),
           ),
        ],
      )
    );
  }
}
