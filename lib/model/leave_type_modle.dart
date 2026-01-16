// To parse this JSON data, do
//
//     final leaveTypeModel = leaveTypeModelFromJson(jsonString);

import 'dart:convert';

LeaveTypeModel leaveTypeModelFromJson(String str) =>
    LeaveTypeModel.fromJson(json.decode(str));

String leaveTypeModelToJson(LeaveTypeModel data) => json.encode(data.toJson());

class LeaveTypeModel {
  int leaveTypeId;
  String leaveTypeName;

  LeaveTypeModel({
    required this.leaveTypeId,
    required this.leaveTypeName,
  });

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) => LeaveTypeModel(
        leaveTypeId: json["leave_type_id"],
        leaveTypeName: json["leave_type_name"],
      );

  Map<String, dynamic> toJson() => {
        "leave_type_id": leaveTypeId,
        "leave_type_name": leaveTypeName,
      };
}
