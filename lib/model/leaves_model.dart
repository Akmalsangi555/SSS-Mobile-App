// To parse this JSON data, do
//
//     final leavesModel = leavesModelFromJson(jsonString);

import 'dart:convert';

LeavesModel leavesModelFromJson(String str) =>
    LeavesModel.fromJson(json.decode(str));

String leavesModelToJson(LeavesModel data) => json.encode(data.toJson());

class LeavesModel {
  int guardsLeaveId;
  int guardsId;
  String fromDate;
  String toDate;
  String reasonOfLeave;
  int usersProfileId;
  int createdBy;
  DateTime createdDate;
  int organizationId;
  int branchId;
  int annualLeaveBalance;
  int sickLeaveBalance;
  int funeralLeaveBalance;
  int leaveBalanceId;
  int guardsTypeId;
  int guardsStatusId;
  int shiftTypeId;
  String shiftType;
  dynamic shift;
  dynamic clinetId;
  String client;
  String guardCode;
  String guardName;
  dynamic leaveType;
  int leaveTypeId;
  String leaveTypeName;
  int leaveStatusId;

  LeavesModel({
    required this.guardsLeaveId,
    required this.guardsId,
    required this.fromDate,
    required this.toDate,
    required this.reasonOfLeave,
    required this.usersProfileId,
    required this.createdBy,
    required this.createdDate,
    required this.organizationId,
    required this.branchId,
    required this.annualLeaveBalance,
    required this.sickLeaveBalance,
    required this.funeralLeaveBalance,
    required this.leaveBalanceId,
    required this.guardsTypeId,
    required this.guardsStatusId,
    required this.shiftTypeId,
    required this.shiftType,
    required this.shift,
    required this.clinetId,
    required this.client,
    required this.guardCode,
    required this.guardName,
    required this.leaveType,
    required this.leaveTypeId,
    required this.leaveTypeName,
    required this.leaveStatusId,
  });

  factory LeavesModel.fromJson(Map<String, dynamic> json) => LeavesModel(
        guardsLeaveId: json["GuardsLeave_ID"],
        guardsId: json["Guards_ID"],
        fromDate: json["FromDate"],
        toDate: json["ToDate"],
        reasonOfLeave: json["ReasonOfLeave"],
        usersProfileId: json["UsersProfile_ID"],
        createdBy: json["CreatedBy"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        organizationId: json["Organization_ID"],
        branchId: json["Branch_ID"],
        annualLeaveBalance: json["AnnualLeaveBalance"],
        sickLeaveBalance: json["SickLeaveBalance"],
        funeralLeaveBalance: json["FuneralLeaveBalance"],
        leaveBalanceId: json["LeaveBalance_ID"],
        guardsTypeId: json["GuardsType_ID"],
        guardsStatusId: json["GuardsStatus_ID"],
        shiftTypeId: json["ShiftType_ID"],
        shiftType: json["ShiftType"],
        shift: json["Shift"],
        clinetId: json["ClinetID"],
        client: json["Client"],
        guardCode: json["GuardCode"],
        guardName: json["GuardName"],
        leaveType: json["LeaveType"],
        leaveTypeId: json["leave_type_id"],
        leaveTypeName: json["leave_type_name"],
        leaveStatusId: json["LeaveStatusId"],
      );

  Map<String, dynamic> toJson() => {
        "GuardsLeave_ID": guardsLeaveId,
        "Guards_ID": guardsId,
        "FromDate": fromDate,
        "ToDate": toDate,
        "ReasonOfLeave": reasonOfLeave,
        "UsersProfile_ID": usersProfileId,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate.toIso8601String(),
        "Organization_ID": organizationId,
        "Branch_ID": branchId,
        "AnnualLeaveBalance": annualLeaveBalance,
        "SickLeaveBalance": sickLeaveBalance,
        "FuneralLeaveBalance": funeralLeaveBalance,
        "LeaveBalance_ID": leaveBalanceId,
        "GuardsType_ID": guardsTypeId,
        "GuardsStatus_ID": guardsStatusId,
        "ShiftType_ID": shiftTypeId,
        "ShiftType": shiftType,
        "Shift": shift,
        "ClinetID": clinetId,
        "Client": client,
        "GuardCode": guardCode,
        "GuardName": guardName,
        "LeaveType": leaveType,
        "leave_type_id": leaveTypeId,
        "leave_type_name": leaveTypeName,
        "LeaveStatusId": leaveStatusId,
      };
}
