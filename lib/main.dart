import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/controller/leave_controller.dart';
import 'package:sssmobileapp/controller/user_profile_controller.dart';

import 'utils/local_storage/shared_pref.dart';
import 'view/splash/splash_screen.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  await SharedPrefs.init();

  // Initialize GetX controllers
  Get.put(UserProfileController());
  Get.put(LeaveController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SSS Mobile App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: AppTheme.backgroundColor,
          shadowColor: Colors.transparent,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(Colors.blue),
            textStyle: WidgetStateProperty.all(const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue)),
          ),
        ),
        textTheme: TextTheme(
            bodyMedium: TextStyle(
              fontSize: 14,
              color: AppTheme.primaryTextColor,
            ),
            bodySmall: TextStyle(
              fontSize: 12,
              color: AppTheme.primaryTextColor,
            )),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Color(0xFFCACACA), fontSize: 14),
          labelStyle: TextStyle(color: Color(0xFFCACACA), fontSize: 14),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Color(0xFFCBCBCB),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppTheme.backgroundColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Color(0xFFCBCBCB),
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.red,
              )),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      // Change home to SplashScreen
      home: const SplashScreen(),
    );
  }
}

// void main() {
//   Get.put(UserProfileController());
//   Get.put(LeaveController());
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'SSS Mobile App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: 'Poppins',
//         appBarTheme: AppBarTheme(
//           foregroundColor: Colors.white,
//           backgroundColor: AppTheme.backgroundColor,
//           shadowColor: Colors.transparent,
//         ),
//         textButtonTheme: TextButtonThemeData(
//           style: ButtonStyle(
//             foregroundColor: WidgetStateProperty.all(Colors.blue),
//             textStyle: WidgetStateProperty.all(const TextStyle(
//                 fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue)),
//           ),
//         ),
//         textTheme: TextTheme(
//             bodyMedium: TextStyle(
//               fontSize: 14,
//               color: AppTheme.primaryTextColor,
//             ),
//             bodySmall: TextStyle(
//               fontSize: 12,
//               color: AppTheme.primaryTextColor,
//             )),
//         inputDecorationTheme: InputDecorationTheme(
//           hintStyle: TextStyle(color: Color(0xFFCACACA), fontSize: 14),
//           labelStyle: TextStyle(color: Color(0xFFCACACA), fontSize: 14),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: Color(0xFFCBCBCB),
//               )),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: AppTheme.backgroundColor,
//               )),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: Color(0xFFCBCBCB),
//               )),
//           errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: Colors.red,
//               )),
//         ),
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: false,
//       ),
//       home: const SignIn(),
//     );
//   }
// }
