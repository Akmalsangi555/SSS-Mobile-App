class GuardMessageRequest {
  final int createdByUserId;
  final int organizationId;
  final int branchId;
  final int guardsTypeId;
  final int clientsId;
  final int guardId;
  final String alertMessage;
  GuardMessageRequest({
    required this.createdByUserId,
    required this.organizationId,
    required this.branchId,
    required this.guardsTypeId,
    required this.clientsId,
    required this.guardId,
    required this.alertMessage,
  });
  Map<String, dynamic> toJson() {
    return {
      'CreatedByUserId': createdByUserId,
      'OrganizationID': organizationId,
      'BranchID': branchId,
      'GuardsType_ID': guardsTypeId,
      'Clients_ID': clientsId,
      'GuardID': guardId,
      'AlertMessage': alertMessage,
    };
  }
}

class GuardMessageResponse {
  final bool isSuccess;
  final String message;
  final dynamic content;
  GuardMessageResponse({
    required this.isSuccess,
    required this.message,
    this.content,
  });
  factory GuardMessageResponse.fromJson(Map<String, dynamic> json) {
    return GuardMessageResponse(
      isSuccess: json['IsSuccess'] ?? false,
      message: json['Message'] ?? '',
      content: json['Content'],
    );
  }
}
