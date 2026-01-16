
class NotificationModel {
  bool? isSuccess;
  String? message;
  List<NotificationsContent>? content;

  NotificationModel({this.isSuccess, this.message, this.content});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    if (json['Content'] != null) {
      content = <NotificationsContent>[];
      json['Content'].forEach((v) {
        content!.add(new NotificationsContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = this.message;
    if (this.content != null) {
      data['Content'] = this.content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationsContent {
  int? systemNotificationID;
  int? organizationID;
  int? branchID;
  int? createdByUserId;
  String? message;
  int? assignedToUserId;
  String? notificationType;
  String? createDateTime;
  String? firstName;
  String? lastName;
  String? userName;
  bool? isRead;

  NotificationsContent(
      {this.systemNotificationID,
        this.organizationID,
        this.branchID,
        this.createdByUserId,
        this.message,
        this.assignedToUserId,
        this.notificationType,
        this.createDateTime,
        this.firstName,
        this.lastName,
        this.userName,
        this.isRead = false,
      });

  NotificationsContent.fromJson(Map<String, dynamic> json) {
    systemNotificationID = json['SystemNotificationID'];
    organizationID = json['OrganizationID'];
    branchID = json['BranchID'];
    createdByUserId = json['CreatedByUserId'];
    message = json['Message'];
    assignedToUserId = json['AssignedToUserId'];
    notificationType = json['NotificationType'];
    createDateTime = json['CreateDateTime'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    userName = json['UserName'];
    isRead = json['IsRead'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SystemNotificationID'] = this.systemNotificationID;
    data['OrganizationID'] = this.organizationID;
    data['BranchID'] = this.branchID;
    data['CreatedByUserId'] = this.createdByUserId;
    data['Message'] = this.message;
    data['AssignedToUserId'] = this.assignedToUserId;
    data['NotificationType'] = this.notificationType;
    data['CreateDateTime'] = this.createDateTime;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['UserName'] = this.userName;
    data['IsRead'] = this.isRead;
    return data;
  }
}
