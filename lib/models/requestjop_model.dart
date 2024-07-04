

import 'package:multi_dropdown/multiselect_dropdown.dart';

class RequestJobModel {
  final int id;
  final String name;
  final List<ValueItem> selectedCategoryList;
  final int prefectureValue;
  final String? city;
  final bool requestDeadline;
  final int deadlineYear;
  final int deadlineMonth;
  final int deadlineDay;
  final int salaryType;
  final int? salary;
  final int? salaryMin;
  final int? salaryMax;
  final int selectedstartDate;
  final String? startMinDate;
  final String? startMaxDate;
  final String introduce; 

  RequestJobModel(this.name, this.selectedCategoryList, this.prefectureValue, this.city, this.requestDeadline, this.deadlineYear, this.deadlineMonth, this.deadlineDay, this.salaryType, this.salary, this.salaryMin, this.salaryMax, this.selectedstartDate, this.startMinDate, this.startMaxDate, this.introduce, {required this.id});
}
