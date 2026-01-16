
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/utils/custom_text.dart';
import 'package:sssmobileapp/view/auth/change_password.dart';
import 'package:sssmobileapp/view/auth/signin.dart';
import 'package:sssmobileapp/widgets/bottom_nav.dart';
import 'package:sssmobileapp/repository/auth_repository.dart';
import 'package:sssmobileapp/utils/local_storage/shared_pref.dart';
import 'package:sssmobileapp/view/auth/forget_password_confirm.dart';
import 'package:sssmobileapp/model/auth_models/login_user_model.dart';
import 'package:sssmobileapp/controller/user_profile_controller.dart';
import 'package:sssmobileapp/model/auth_models/user_content_model.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final AuthRepository _authRepo = AuthRepository();

  // Login state
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Forgot password state
  final RxBool isForgotPasswordLoading = false.obs;
  final RxString forgotPasswordErrorMessage = ''.obs;

  // Verify code state
  final RxBool isVerifyCodeLoading = false.obs;
  final RxString verifyCodeErrorMessage = ''.obs;

  // Update password state
  final RxBool isUpdatePasswordLoading = false.obs;
  final RxString updatePasswordErrorMessage = ''.obs;

  // ── LOGIN ────────────────────────────────────────────────────────
  Future<bool> login({
    required String email,
    required String password,
    String lat = '31.5204',
    String lon = '74.3587',
    String os = 'Android',
    String location = 'Lahore',
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _authRepo.login(
        email: email,
        password: password,
        lat: lat,
        lon: lon,
        os: os,
        location: location,
      );

      if (response.isSuccess && response.content != null) {
        final userProfile = LoginUserModel.fromJson(
          response.content!,
          email,
        );

        _authRepo.printUserData(userProfile);

        final userContent = UserContentModel(
          guardsId: userProfile.guardsId,
          usersProfileId: userProfile.usersProfileId,
          userName: userProfile.fullName,
          branchId: userProfile.branchId,
          organizationId: userProfile.organizationId,
          usersProfileTypeId: userProfile.usersProfileTypeId,
          profileType: _getProfileType(userProfile),
          email: userProfile.email,
          phone: userProfile.phone,
          profilePhoto: userProfile.profilePhoto,
        );

        await SharedPrefs.saveUserContent(
          userContent,
          token: response.token,
          guardId: userProfile.guardsId.toString(),
          userId: userProfile.usersProfileId.toString(),
          guardName: userProfile.fullName,
          branchId: userProfile.branchId.toString(),
          organizationId: userProfile.organizationId.toString(),
          guardsTypeId: userProfile.guardsTypeId.toString(),
        );

        Get.find<UserProfileController>().setUserData(userProfile);

        Get.snackbar(
          'Success',
          'Login successful!',
          backgroundColor: Colors.green.shade700,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        _navigateToHome();
        return true;
      } else {
        errorMessage.value = response.message;
        Get.snackbar('Error', response.message);
        return false;
      }
    } catch (e) {
      final msg = e.toString().replaceAll('Exception: ', '').trim();
      errorMessage.value = msg.isEmpty ? 'Something went wrong' : msg;
      Get.snackbar('Error', errorMessage.value);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ── FORGOT PASSWORD ──────────────────────────────────────────────
  Future<bool> sendForgotPasswordCode(String email) async {
    try {
      isForgotPasswordLoading.value = true;
      forgotPasswordErrorMessage.value = '';

      print('=== FORGOT PASSWORD CONTROLLER ===');
      print('Calling API with email: $email');
      print('==================================');

      final response = await _authRepo.forgotPassword(email);

      if (response.isSuccess) {
        print('=== SUCCESS RESPONSE ===');
        print('Message: ${response.message}');
        print('Content: ${response.content}');
        print('========================');

        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green.shade700,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );

        _navigateToForgetPasswordConfirm(
          email: email,
          userId: response.content ?? 0,
        );

        return true;
      } else {
        forgotPasswordErrorMessage.value = response.message;
        print('=== ERROR RESPONSE ===');
        print('Error: ${response.message}');
        print('=====================');
        Get.snackbar('Error', response.message);
        return false;
      }
    } catch (e) {
      final msg = e.toString().replaceAll('Exception: ', '').trim();
      forgotPasswordErrorMessage.value = msg.isEmpty ? 'Something went wrong' : msg;

      print('=== EXCEPTION CAUGHT ===');
      print('Exception: $e');
      print('Error Message: $msg');
      print('=======================');

      Get.snackbar('Error', forgotPasswordErrorMessage.value);
      return false;
    } finally {
      isForgotPasswordLoading.value = false;
    }
  }

  // ── VERIFY RESET CODE ────────────────────────────────────────────
  Future<bool> verifyResetCode({
    required int userId,
    required int code,
  }) async {
    try {
      isVerifyCodeLoading.value = true;
      verifyCodeErrorMessage.value = '';

      print('=== VERIFY RESET CODE CONTROLLER ===');
      print('User ID: $userId, Code: $code');
      print('====================================');

      final response = await _authRepo.verifyResetCode(
        userId: userId,
        code: code,
      );

      if (response.isSuccess) {
        print('=== VERIFICATION SUCCESS ===');
        print('Message: ${response.message}');
        print('============================');

        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green.shade700,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        _navigateToChangePassword(userId: userId, code: code);
        return true;
      } else {
        verifyCodeErrorMessage.value = response.message;
        print('=== VERIFICATION ERROR ===');
        print('Error: ${response.message}');
        print('==========================');
        Get.snackbar('Error', response.message);
        return false;
      }
    } catch (e) {
      final msg = e.toString().replaceAll('Exception: ', '').trim();
      verifyCodeErrorMessage.value = msg.isEmpty ? 'Something went wrong' : msg;

      print('=== VERIFICATION EXCEPTION ===');
      print('Exception: $e');
      print('Error Message: $msg');
      print('==============================');

      Get.snackbar('Error', verifyCodeErrorMessage.value);
      return false;
    } finally {
      isVerifyCodeLoading.value = false;
    }
  }

  // ── RESEND VERIFICATION CODE ────────────────────────────────────
  Future<bool> resendVerificationCode(String email) async {
    return await sendForgotPasswordCode(email);
  }

// ── UPDATE PASSWORD ──────────────────────────────────────────────
  Future<bool> updatePassword({
    required int userId,
    required int code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      isUpdatePasswordLoading.value = true;
      updatePasswordErrorMessage.value = '';

      print('=== UPDATE PASSWORD CONTROLLER ===');
      print('User ID: $userId, Code: $code');
      print('==================================');

      final response = await _authRepo.updatePassword(
        userId: userId,
        code: code,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      if (response.isSuccess) {
        print('=== PASSWORD UPDATE SUCCESS ===');
        print('Message: ${response.message}');
        print('==============================');

        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green.shade700,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        _navigateToSignIn();
        return true;
      } else {
        updatePasswordErrorMessage.value = response.message;
        print('=== PASSWORD UPDATE ERROR ===');
        print('Error: ${response.message}');
        print('============================');
        Get.snackbar('Error', response.message);
        return false;
      }
    } catch (e) {
      final msg = e.toString().replaceAll('Exception: ', '').trim();
      updatePasswordErrorMessage.value = msg.isEmpty ? 'Something went wrong' : msg;

      print('=== UPDATE PASSWORD EXCEPTION ===');
      print('Exception: $e');
      print('Error Message: $msg');
      print('================================');

      Get.snackbar('Error', updatePasswordErrorMessage.value);
      return false;
    } finally {
      isUpdatePasswordLoading.value = false;
    }
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const CustomText(
          text: "Logout",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        content: const CustomText(
          text: "Are you sure you want to log out?",
          fontSize: 16,
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const CustomText(
              text: "Cancel",
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await SharedPrefs.logout();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (_) => const SignIn()), (route) => false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.backgroundColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const CustomText(
              text: "Logout",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

// ── VALIDATE PASSWORDS ──────────────────────────────────────────
  String? validatePasswords(String password, String confirmPassword) {
    if (password.isEmpty) {
      return 'Please enter your password.';
    }

    if (confirmPassword.isEmpty) {
      return 'Please enter your confirm password.';
    }

    if (password != confirmPassword) {
      return 'Password and confirmed password do not match.';
    }

    // // Add more password validation rules if needed
    // if (password.length < 6) {
    //   return 'Password must be at least 6 characters long.';
    // }

    return null;
  }

// ── NAVIGATION ──────────────────────────────────────────────────
  void _navigateToSignIn() {
    Get.offAll(() => SignIn());
  }

  // ── NAVIGATION METHODS ──────────────────────────────────────────
  void _navigateToHome() {
    Get.offAll(() => const BottomNav());
  }

  void _navigateToForgetPasswordConfirm({
    required String email,
    required int userId,
  }) {
    Get.to(() => ForgetPasswordConfirm(
      email: email,
      userId: userId,
    ));
  }

  void _navigateToChangePassword({
    required int userId,
    required int code,
  }) {
    Get.to(() => ChangePassword(
      userId: userId,
      code: code,
    ));
  }

  // ── HELPER METHODS ──────────────────────────────────────────────
  String _getProfileType(LoginUserModel user) {
    if (user.usersProfileTypeId == 1) return 'Admin';
    if (user.usersProfileTypeId == 2) return 'Manager';
    if (user.guardsTypeId != null) return 'Guard';
    return 'User';
  }

  void clearErrors() {
    errorMessage.value = '';
    forgotPasswordErrorMessage.value = '';
    verifyCodeErrorMessage.value = '';
  }
}

// class AuthController extends GetxController {
//   final AuthRepository _authRepo = AuthRepository();
//   final RxBool isLoading = false.obs;
//   final RxString errorMessage = ''.obs;
//
//   // For forgot password state management
//   final RxBool isForgotPasswordLoading = false.obs;
//   final RxString forgotPasswordErrorMessage = ''.obs;
//
//   // ── LOGIN ────────────────────────────────────────────────────────
//   Future<bool> login({
//     required String email,
//     required String password,
//     String lat = '31.5204',
//     String lon = '74.3587',
//     String os = 'Android',
//     String location = 'Lahore',
//   }) async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';
//
//       final response = await _authRepo.login(
//         email: email,
//         password: password,
//         lat: lat,
//         lon: lon,
//         os: os,
//         location: location,
//       );
//
//       if (response.isSuccess && response.content != null) {
//         // Parse user profile from API response
//         final userProfile = LoginUserModel.fromJson(
//           response.content!,
//           email,
//         );
//
//         // Print user data
//         _authRepo.printUserData(userProfile);
//
//         // Create UserContent object for SharedPrefs
//         final userContent = UserContentModel(
//           guardsId: userProfile.guardsId,
//           usersProfileId: userProfile.usersProfileId,
//           userName: userProfile.fullName,
//           branchId: userProfile.branchId,
//           organizationId: userProfile.organizationId,
//           usersProfileTypeId: userProfile.usersProfileTypeId,
//           profileType: _getProfileType(userProfile),
//           email: userProfile.email,
//           phone: userProfile.phone,
//           profilePhoto: userProfile.profilePhoto,
//         );
//
//         // Save to SharedPreferences
//         await SharedPrefs.saveUserContent(
//           userContent,
//           token: response.token,
//           guardId: userProfile.guardsId.toString(),
//           userId: userProfile.usersProfileId.toString(),
//           guardName: userProfile.fullName,
//           branchId: userProfile.branchId.toString(),
//           organizationId: userProfile.organizationId.toString(),
//           guardsTypeId: userProfile.guardsTypeId.toString(),
//         );
//
//         // Also save to GetX controller
//         Get.find<UserProfileController>().setUserData(userProfile);
//
//         // Show success message
//         Get.snackbar(
//           'Success',
//           'Login successful!',
//           backgroundColor: Colors.green.shade700,
//           colorText: Colors.white,
//           duration: const Duration(seconds: 2),
//         );
//
//         // Navigate to home screen
//         _navigateToHome();
//
//         return true;
//       } else {
//         errorMessage.value = response.message;
//         Get.snackbar('Error', response.message);
//         return false;
//       }
//     } catch (e) {
//       final msg = e.toString().replaceAll('Exception: ', '').trim();
//       errorMessage.value = msg.isEmpty ? 'Something went wrong' : msg;
//       Get.snackbar('Error', errorMessage.value);
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // ── FORGOT PASSWORD ──────────────────────────────────────────────
//
//   Future<bool> sendForgotPasswordCode(String email) async {
//     try {
//       isForgotPasswordLoading.value = true;
//       forgotPasswordErrorMessage.value = '';
//
//       print('=== FORGOT PASSWORD CONTROLLER ===');
//       print('Calling API with email: $email');
//       print('==================================');
//
//       final response = await _authRepo.forgotPassword(email);
//
//       if (response.isSuccess) {
//         print('=== SUCCESS RESPONSE ===');
//         print('Message: ${response.message}');
//         print('Content: ${response.content}');
//         print('========================');
//
//         Get.snackbar(
//           'Success',
//           response.message,
//           backgroundColor: Colors.green.shade700,
//           colorText: Colors.white,
//           duration: const Duration(seconds: 4),
//         );
//
//         _navigateToForgetPasswordConfirm(
//           email: email,
//           userId: response.content ?? 0,
//         );
//
//         return true;
//       } else {
//         forgotPasswordErrorMessage.value = response.message;
//         print('=== ERROR RESPONSE ===');
//         print('Error: ${response.message}');
//         print('=====================');
//         Get.snackbar('Error', response.message);
//         return false;
//       }
//     } catch (e) {
//       final msg = e.toString().replaceAll('Exception: ', '').trim();
//       forgotPasswordErrorMessage.value = msg.isEmpty ? 'Something went wrong' : msg;
//
//       print('=== EXCEPTION CAUGHT ===');
//       print('Exception: $e');
//       print('Error Message: $msg');
//       print('=======================');
//
//       Get.snackbar('Error', forgotPasswordErrorMessage.value);
//       return false;
//     } finally {
//       isForgotPasswordLoading.value = false;
//     }
//   }
//
//   // ── NAVIGATION METHODS ──────────────────────────────────────────────
//   void _navigateToHome() {
//     Get.offAll(() => const BottomNav());
//   }
//
//   void _navigateToForgetPasswordConfirm({
//     required String email,
//     required int userId,
//   }) {
//     Get.to(() => ForgetPasswordConfirm(
//       email: email,
//       userId: userId,
//     ));
//   }
//
//   // ── HELPER METHOD ──────────────────────────────────────────────
//   String _getProfileType(LoginUserModel user) {
//     // Add your logic here based on userProfileTypeId or guardsTypeId
//     if (user.usersProfileTypeId == 1) return 'Admin';
//     if (user.usersProfileTypeId == 2) return 'Manager';
//     if (user.guardsTypeId != null) return 'Guard';
//     return 'User';
//   }
// }
