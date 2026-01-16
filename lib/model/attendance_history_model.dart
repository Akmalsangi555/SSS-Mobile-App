// To parse this JSON data, do
//
//     final attendanceHistoryModel = attendanceHistoryModelFromJson(jsonString);

import 'dart:convert';

AttendanceHistoryModel attendanceHistoryModelFromJson(String str) =>
    AttendanceHistoryModel.fromJson(json.decode(str));

String attendanceHistoryModelToJson(AttendanceHistoryModel data) =>
    json.encode(data.toJson());

class AttendanceHistoryModel {
  int attendanceMasterId;
  int usersProfileId;
  int shiftTypeId;
  DateTime attendanceDate;
  String remarks;
  int branchId;
  int organizationId;
  DateTime createdDate;
  List<AttendanceDetail> attendanceDetails;

  AttendanceHistoryModel({
    required this.attendanceMasterId,
    required this.usersProfileId,
    required this.shiftTypeId,
    required this.attendanceDate,
    required this.remarks,
    required this.branchId,
    required this.organizationId,
    required this.createdDate,
    required this.attendanceDetails,
  });

  factory AttendanceHistoryModel.fromJson(Map<String, dynamic> json) =>
      AttendanceHistoryModel(
        attendanceMasterId: json["AttendanceMaster_ID"],
        usersProfileId: json["UsersProfile_ID"],
        shiftTypeId: json["ShiftType_ID"],
        attendanceDate: DateTime.parse(json["AttendanceDate"]),
        remarks: json["Remarks"],
        branchId: json["Branch_ID"],
        organizationId: json["Organization_ID"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        attendanceDetails: List<AttendanceDetail>.from(
            json["AttendanceDetails"].map((x) => AttendanceDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "AttendanceMaster_ID": attendanceMasterId,
        "UsersProfile_ID": usersProfileId,
        "ShiftType_ID": shiftTypeId,
        "AttendanceDate": attendanceDate.toIso8601String(),
        "Remarks": remarks,
        "Branch_ID": branchId,
        "Organization_ID": organizationId,
        "CreatedDate": createdDate.toIso8601String(),
        "AttendanceDetails":
            List<dynamic>.from(attendanceDetails.map((x) => x.toJson())),
      };
}

class AttendanceDetail {
  int attendanceDetailId;
  int attendanceMasterId;
  int attendanceStatusId;
  int assignmentTypeId;
  int guardsId;
  int clientsId;
  dynamic remarks;
  dynamic cashDaily;
  dynamic cashOt;
  dynamic rateDaily;
  dynamic rateOt;
  dynamic otHours;
  dynamic walkingGuard;
  dynamic replacedGuardId;
  dynamic replacedCashPaid;
  dynamic replacedCashPaidAgree;
  dynamic replacementRemarks;
  dynamic clientCode;
  dynamic title;
  dynamic guardCode;
  dynamic guardName;
  dynamic photo;
  dynamic assignmentTypeTitle;
  dynamic attendanceStatusTitle;
  DateTime attendanceDate;
  int shiftTypeId;
  String locationIp;
  String checkInTime;
  String checkOutTime;
  num hoursWorked;
  String latitude;
  String longitude;

  AttendanceDetail({
    required this.attendanceDetailId,
    required this.attendanceMasterId,
    required this.attendanceStatusId,
    required this.assignmentTypeId,
    required this.guardsId,
    required this.clientsId,
    required this.remarks,
    required this.cashDaily,
    required this.cashOt,
    required this.rateDaily,
    required this.rateOt,
    required this.otHours,
    required this.walkingGuard,
    required this.replacedGuardId,
    required this.replacedCashPaid,
    required this.replacedCashPaidAgree,
    required this.replacementRemarks,
    required this.clientCode,
    required this.title,
    required this.guardCode,
    required this.guardName,
    required this.photo,
    required this.assignmentTypeTitle,
    required this.attendanceStatusTitle,
    required this.attendanceDate,
    required this.shiftTypeId,
    required this.locationIp,
    required this.checkInTime,
    required this.checkOutTime,
    required this.hoursWorked,
    required this.latitude,
    required this.longitude,
  });

  factory AttendanceDetail.fromJson(Map<String, dynamic> json) =>
      AttendanceDetail(
        attendanceDetailId: json["AttendanceDetail_ID"],
        attendanceMasterId: json["AttendanceMaster_ID"],
        attendanceStatusId: json["AttendanceStatus_ID"],
        assignmentTypeId: json["AssignmentType_ID"],
        guardsId: json["Guards_ID"],
        clientsId: json["Clients_ID"],
        remarks: json["Remarks"],
        cashDaily: json["CashDaily"],
        cashOt: json["CashOT"],
        rateDaily: json["RateDaily"],
        rateOt: json["RateOT"],
        otHours: json["OTHours"],
        walkingGuard: json["WalkingGuard"],
        replacedGuardId: json["ReplacedGuard_ID"],
        replacedCashPaid: json["ReplacedCashPaid"],
        replacedCashPaidAgree: json["ReplacedCashPaidAgree"],
        replacementRemarks: json["ReplacementRemarks"],
        clientCode: json["ClientCode"],
        title: json["Title"],
        guardCode: json["GuardCode"],
        guardName: json["GuardName"],
        photo: json["Photo"],
        assignmentTypeTitle: json["AssignmentTypeTitle"],
        attendanceStatusTitle: json["AttendanceStatusTitle"],
        attendanceDate: DateTime.parse(json["AttendanceDate"]),
        shiftTypeId: json["ShiftType_ID"],
        locationIp: json["LocationIP"],
        checkInTime: json["CheckInTime"],
        checkOutTime: json["CheckOutTime"],
        hoursWorked: json["HoursWorked"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
      );

  Map<String, dynamic> toJson() => {
        "AttendanceDetail_ID": attendanceDetailId,
        "AttendanceMaster_ID": attendanceMasterId,
        "AttendanceStatus_ID": attendanceStatusId,
        "AssignmentType_ID": assignmentTypeId,
        "Guards_ID": guardsId,
        "Clients_ID": clientsId,
        "Remarks": remarks,
        "CashDaily": cashDaily,
        "CashOT": cashOt,
        "RateDaily": rateDaily,
        "RateOT": rateOt,
        "OTHours": otHours,
        "WalkingGuard": walkingGuard,
        "ReplacedGuard_ID": replacedGuardId,
        "ReplacedCashPaid": replacedCashPaid,
        "ReplacedCashPaidAgree": replacedCashPaidAgree,
        "ReplacementRemarks": replacementRemarks,
        "ClientCode": clientCode,
        "Title": title,
        "GuardCode": guardCode,
        "GuardName": guardName,
        "Photo": photo,
        "AssignmentTypeTitle": assignmentTypeTitle,
        "AttendanceStatusTitle": attendanceStatusTitle,
        "AttendanceDate": attendanceDate.toIso8601String(),
        "ShiftType_ID": shiftTypeId,
        "LocationIP": locationIp,
        "CheckInTime": checkInTime,
        "CheckOutTime": checkOutTime,
        "HoursWorked": hoursWorked,
        "Latitude": latitude,
        "Longitude": longitude,
      };
}
