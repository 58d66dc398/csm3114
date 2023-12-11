import 'dart:math';

class Employee {
  late final String name, staffNo, department;
  double score = 0;

  Employee(this.name,
      {required String staffNo,
      required this.department,
      required double score}) {
    this.staffNo = (int.tryParse(staffNo) == null) ? '0' : staffNo;
    this.score = min(5, max(1, score));
  }
}
