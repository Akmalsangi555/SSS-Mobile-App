
// Login Response Model
class LoginResponse {
  final bool isSuccess;
  final String message;
  final String? token;
  final Map<String, dynamic>? content;

  LoginResponse({
    required this.isSuccess,
    required this.message,
    this.token,
    this.content,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      isSuccess: json['IsSuccess'] ?? false,
      message: json['Message'] ?? '',
      token: json['Token'],
      content: json['Content'] is Map<String, dynamic>
          ? json['Content'] as Map<String, dynamic>
          : null,
    );
  }
}

class LoginUserModel {
  final String email;
  final int usersProfileId;
  final String fullName;
  final String? profilePhoto;
  final String? phone;
  final String? gender;
  final int usersProfileTypeId;
  final int organizationId;
  final int branchId;
  final int guardsTypeId;
  final int guardsId;
  final int clientId;

  // Optional: Add more fields you need later
  final String guardCode;
  final String guardName;
  final DateTime? dateOfBirth;
  final String? currentAddress;
  final int? leavePolicyId;
  final int? designation;
  final int? department;

  LoginUserModel({
    required this.email,
    required this.usersProfileId,
    required this.fullName,
    this.profilePhoto,
    this.phone,
    this.gender,
    required this.usersProfileTypeId,
    required this.organizationId,
    required this.branchId,
    required this.guardsTypeId,
    required this.guardsId,
    required this.clientId,
    required this.guardCode,
    required this.guardName,
    this.dateOfBirth,
    this.currentAddress,
    this.leavePolicyId,
    this.designation,
    this.department,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json, String loginEmail) {
    // json here is data['Content']
    final login = json['Login'] as Map<String, dynamic>;
    final profile = json['Profile'] as Map<String, dynamic>;

    return LoginUserModel(
      email: loginEmail, // safest: use the one user typed (because Profile.Email is null)
      usersProfileId: login['UsersProfile_ID'] as int,
      fullName: profile['GuardName'] as String? ?? 'Unknown User',
      profilePhoto: login['ProfilePhoto'] as String?,
      phone: profile['Phone'] as String?,
      gender: profile['Gender'] as String?,
      usersProfileTypeId: login['UsersProfileType_ID'] as int,
      organizationId: login['Organization_ID'] as int,
      branchId: login['Branch_ID'] as int,
      guardsTypeId: login['GuardsType_ID'] as int,
      guardsId: login['Guards_ID'] as int,
      clientId: login['Client_ID'] as int,

      // Extra useful fields
      guardCode: profile['GuardCode'] as String? ?? '',
      guardName: profile['GuardName'] as String? ?? '',
      dateOfBirth: profile['DateOfBirth'] != null && profile['DateOfBirth'] != "0001-01-01T00:00:00"
          ? DateTime.tryParse(profile['DateOfBirth'] as String)
          : null,
      currentAddress: profile['CurrentAddress'] as String?,

      // These are the ones that were crashing before
      leavePolicyId: profile['LeavePolicyId'] as int?,
      designation: profile['Designation'] as int?,
      department: profile['Department'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    "email": email,
    "usersProfileId": usersProfileId,
    "fullName": fullName,
    "profilePhoto": profilePhoto,
    "phone": phone,
    "gender": gender,
    "usersProfileTypeId": usersProfileTypeId,
    "organizationId": organizationId,
    "branchId": branchId,
    "guardsTypeId": guardsTypeId,
    "guardsId": guardsId,
    "clientId": clientId,
    "guardCode": guardCode,
  };
}
