
import 'login_user_model.dart';

class UserContentModel {
  final int guardsId;
  final int usersProfileId;
  final String userName;
  final int branchId;
  final int organizationId;
  final int usersProfileTypeId;
  final String profileType;
  final String? email;
  final String? phone;
  final String? profilePhoto;
  final String? gender;

  UserContentModel({
    required this.guardsId,
    required this.usersProfileId,
    required this.userName,
    required this.branchId,
    required this.organizationId,
    required this.usersProfileTypeId,
    required this.profileType,
    this.email,
    this.phone,
    this.profilePhoto,
    this.gender,
  });

  factory UserContentModel.fromJson(Map<String, dynamic> json) {
    return UserContentModel(
      guardsId: json['guardsId'] as int,
      usersProfileId: json['usersProfileId'] as int,
      userName: json['userName'] as String,
      branchId: json['branchId'] as int,
      organizationId: json['organizationId'] as int,
      usersProfileTypeId: json['usersProfileTypeId'] as int,
      profileType: json['profileType'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
      gender: json['gender'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guardsId': guardsId,
      'usersProfileId': usersProfileId,
      'userName': userName,
      'branchId': branchId,
      'organizationId': organizationId,
      'usersProfileTypeId': usersProfileTypeId,
      'profileType': profileType,
      'email': email,
      'phone': phone,
      'profilePhoto': profilePhoto,
      'gender': gender,
    };
  }

  // Helper method to convert UserContent to UserProfileModel
  LoginUserModel toUserProfileModel({
    required int guardsTypeId,
    required int clientId,
    String? guardCode,
  }) {
    return LoginUserModel(
      email: email ?? '',
      usersProfileId: usersProfileId,
      fullName: userName,
      profilePhoto: profilePhoto,
      phone: phone,
      gender: gender,
      usersProfileTypeId: usersProfileTypeId,
      organizationId: organizationId,
      branchId: branchId,
      guardsTypeId: guardsTypeId,
      guardsId: guardsId,
      clientId: clientId,
      guardCode: guardCode ?? '',
      guardName: userName,
    );
  }
}
