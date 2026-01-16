
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sssmobileapp/controller/user_profile_controller.dart';
import 'package:sssmobileapp/utils/local_storage/shared_pref.dart';

import 'package:flutter/material.dart';
import 'package:sssmobileapp/view/auth/signin.dart';

// class AuthHelper {
//   /// Logout user and clear token
//   static Future<void> logout(BuildContext context) async {
//     try {
//       // Show loading dialog
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//
//       // Clear token from shared preferences
//       await SharedPrefs.clearToken();
//
//       // Close loading dialog
//       Navigator.of(context).pop();
//
//       // Navigate to SignIn and remove all previous routes
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (_) => const SignIn()),
//             (route) => false,
//       );
//
//       print('✅ Logout successful - Token cleared');
//     } catch (e) {
//       print('❌ Error during logout: $e');
//
//       // Close loading dialog if open
//       if (Navigator.of(context).canPop()) {
//         Navigator.of(context).pop();
//       }
//
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Logout failed. Please try again.'),
//         ),
//       );
//     }
//   }
//
//   /// Check if user session is still valid (has token)
//   static Future<bool> isSessionValid() async {
//     try {
//       final token = await SharedPrefs.getAccessToken();
//       return token != null && token.isNotEmpty;
//     } catch (e) {
//       print('❌ Error checking session: $e');
//       return false;
//     }
//   }
//
//   /// Force logout if session expired
//   static Future<void> handleSessionExpired(BuildContext context) async {
//     // Clear token
//     await SharedPrefs.clearToken();
//
//     // Navigate to login screen
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (_) => const SignIn()),
//           (route) => false,
//     );
//
//     // Show notification
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Session expired. Please login again.'),
//         backgroundColor: Colors.orange,
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
// }

class AuthHelper {
  /// Logout user and clear all data
  static Future<void> logout(BuildContext context) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Clear GetX controller
      // Get.find<UserProfileController>().clearUserData();

      // Close loading dialog
      Navigator.of(context).pop();

      // Navigate to SignIn and remove all previous routes
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const SignIn()),
            (route) => false,
      );

      print('✅ Logout successful');
    } catch (e) {
      print('❌ Error during logout: $e');

      // Close loading dialog if open
      Navigator.of(context).pop();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed. Please try again.')),
      );
    }
  }

  /// Check if user session is still valid
  static Future<bool> isSessionValid() async {
    try {
      final isLoggedIn = await SharedPrefs.isLoggedIn();
      final userContent = await SharedPrefs.getUserContent();
      final token = await SharedPrefs.getAccessToken();

      return isLoggedIn && userContent != null && token != null;
    } catch (e) {
      print('❌ Error checking session: $e');
      return false;
    }
  }

  /// Force logout if session expired
  static Future<void> handleSessionExpired(BuildContext context) async {
    await SharedPrefs.clearUser();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SignIn()),
          (route) => false,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Session expired. Please login again.'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
