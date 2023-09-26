class Employee {
  String? id;
  String? name;
  String? contactInformation;
  String? role;
  String? shiftSchedule;
  String? payrollInformation;

  Employee({
    this.id,
    this.name,
    this.contactInformation,
    this.role,
    this.shiftSchedule,
    this.payrollInformation,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      contactInformation: json['contact_information'],
      role: json['role'],
      shiftSchedule: json['shift_schedule'],
      payrollInformation: json['payroll_information'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contact_information': contactInformation,
      'role': role,
      'shift_schedule': shiftSchedule,
      'payroll_information': payrollInformation,
    };
  }
}
