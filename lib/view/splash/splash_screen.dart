
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/view/auth/signin.dart';
import 'package:sssmobileapp/widgets/bottom_nav.dart';
import 'package:sssmobileapp/utils/local_storage/shared_pref.dart';
import 'package:sssmobileapp/view/language/select_language_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    _decideNavigation();
  }

  Future<void> _decideNavigation() async {
    await Future.delayed(const Duration(seconds: 2));

    final hasLanguage = await SharedPrefs.hasLanguageBeenSelected();
    final isLoggedIn = await SharedPrefs.isLoggedIn();

    if (isLoggedIn) {
      // Already logged in → go home (language already selected long ago)
      if (mounted) {
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => BottomNav()),
        );
      }
    } else if (!hasLanguage) {
      // First time, no language → must select language (no back)
      if (mounted) {
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const SelectLanguageScreen()),
        );
      }
    } else {
      // Language selected, but not logged in → go to login
      // From login user can go back to change language
      if (mounted) {
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const SignIn()),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 200,
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Setup animation
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//     );
//
//     _controller.forward();
//
//     // Check auth and navigate
//     _checkAuthAndNavigate();
//   }
//
//   Future<void> _checkAuthAndNavigate() async {
//     try {
//       // Initialize SharedPreferences (already done in main, but safe to call again)
//       await SharedPrefs.init();
//
//       // Wait for splash animation (minimum 2 seconds)
//       await Future.delayed(const Duration(seconds: 2));
//
//       // Check if user is logged in
//       final isLoggedIn = await SharedPrefs.isLoggedIn();
//
//       print('🔍 Checking login status: $isLoggedIn');
//
//       if (isLoggedIn) {
//         // Get saved user data
//         final userContent = await SharedPrefs.getUserContent();
//
//         if (userContent != null) {
//           // Restore user session
//           print('✅ User session found - Auto login');
//           print('📧 Email: ${userContent.email}');
//           print('👤 Name: ${userContent.userName}');
//
//           // Get additional saved data
//           final guardId = await SharedPrefs.getGuardId();
//           final userId = await SharedPrefs.getUserId();
//           final token = await SharedPrefs.getAccessToken();
//           final guardsTypeId = await SharedPrefs.getGuardsTypeId();
//
//           print('🔑 Guard ID: $guardId');
//           print('🆔 User ID: $userId');
//           print('🎫 Token exists: ${token != null && token.isNotEmpty}');
//
//           // Convert UserContent to UserProfileModel for GetX controller
//           final userProfile = userContent.toUserProfileModel(
//             guardsTypeId: int.tryParse(guardsTypeId ?? '0') ?? 0,
//             clientId: 0, // You can get this from another SharedPrefs key if needed
//             guardCode: '', // You can get this from another SharedPrefs key if needed
//           );
//
//           // Update GetX controller with restored session
//           Get.find<UserProfileController>().setUserData(userProfile);
//
//           print('✅ Session restored successfully');
//
//           // Print all saved data for debugging
//           await SharedPrefs.printAllSavedData();
//
//           // Navigate to BottomNav
//           Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (_) => BottomNav()),
//           );
//         } else {
//           // User data corrupted, go to login
//           print('⚠️ User data corrupted - Redirecting to login');
//           _navigateToSignIn();
//         }
//       } else {
//         // Not logged in, go to sign in
//         print('ℹ️ No active session - Redirecting to login');
//         _navigateToSignIn();
//       }
//     } catch (e) {
//       print('❌ Error during splash: $e');
//       // On error, go to sign in
//       _navigateToSignIn();
//     }
//   }
//
//   void _navigateToSignIn() {
//     Navigator.pushReplacement(context,
//       MaterialPageRoute(builder: (_) => const SignIn()),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.backgroundColor,
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Your logo
//               Image.asset(
//                 'assets/images/logo.png',
//                 height: 200,
//               ),
//               const SizedBox(height: 30),
//               // Loading indicator
//               CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Loading...',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
