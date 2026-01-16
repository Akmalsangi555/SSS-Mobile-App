
import 'package:get/get.dart';
import 'forget_password_class.dart';
import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';
import 'package:sssmobileapp/widgets/bottom_nav.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';
import 'package:sssmobileapp/view_model/auth_controller/auth_controller.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthController _authController = Get.put(AuthController());

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SScaffold(
      titleOfPage: 'Sign in',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildLogo(),
              _buildWelcomeText(),
              const SizedBox(height: 16),
              _buildLoginForm(),
              const SizedBox(height: 32),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/logo.png',
      height: 250,
    );
  }

  Widget _buildWelcomeText() {
    return Text(
      'Good to see you!\nSign in to access your dashboard.',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildEmailField(),
          const SizedBox(height: 16),
          _buildPasswordField(),
          const SizedBox(height: 8),
          _buildForgotPasswordLink(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(label: Text('Email')),
      validator: _validateEmail,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(label: Text('Password')),
      validator: _validatePassword,
    );
  }

  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: _navigateToForgotPassword,
        child: const Text('Forgot your password?'),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        child: SSSFilledButton(
          onPressed: _authController.isLoading.value ? null : _handleLogin,
          buttonText: 'Sign in',
          child: _authController.isLoading.value
              ? CircularProgressIndicator(
            color: AppTheme.secondaryTextButtonColor,
          )
              : null,
        ),
      );
    });
  }

  // ── VALIDATION METHODS ──────────────────────────────────────────────
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  // ── EVENT HANDLERS ──────────────────────────────────────────────
  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ForgetPasswordClass()),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final success = await _authController.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (success) {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const BottomNav()),
          (route) => false,
    );
  }
}

// class SignIn extends StatefulWidget {
//   const SignIn({super.key});
//
//   @override
//   State<SignIn> createState() => _SignInState();
// }
//
// class _SignInState extends State<SignIn> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool apoLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return SScaffold(
//       titleOfPage: 'Sign in',
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Image.asset(
//                 'assets/images/logo.png',
//                 height: 250,
//               ),
//               Text(
//                 'Good to see you!\nSign in to access your dashboard.',
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               SizedBox(height: 16),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _emailController,
//                       textInputAction: TextInputAction.next,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         } else if (!value.contains('@')) {
//                           return 'Please enter your email';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         label: Text('Email'),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     TextFormField(
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your password';
//                         }
//                         return null;
//                       },
//                       obscureText: true,
//                       controller: _passwordController,
//                       decoration: InputDecoration(
//                         label: Text('Password'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.topRight,
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => ForgetPasswordClass()),
//                     );
//                   },
//                   child: Text('Forgot your password ?'),
//                 ),
//               ),
//               SizedBox(height: 32),
//               SizedBox(
//                 width: double.infinity,
//                 child: SSSFilledButton(
//                   onPressed: () async {
//                     if (!_formKey.currentState!.validate()) {
//                       return;
//                     }
//
//                     setState(() {
//                       apoLoading = true;
//                     });
//
//                     try {
//                       var res = await ApiService.post('AuthAPI/Login', data: {
//                         'email': _emailController.text,
//                         'password': _passwordController.text,
//                         "lat": "31.5204",
//                         "lon": "74.3587",
//                         "os": "Android",
//                         "location": "Lahore"
//                       });
//
//                       print(res);
//
//                       if (res.statusCode == 200) {
//                         var data = res.data;
//
//                         // Parse user profile from API response
//                         final userProfile = UserProfileModel.fromJson(
//                           data['Content'],
//                           _emailController.text,
//                         );
//
//                         // Create UserContent object for SharedPrefs
//                         final userContent = UserContent(
//                           guardsId: userProfile.guardsId,
//                           usersProfileId: userProfile.usersProfileId,
//                           userName: userProfile.fullName,
//                           branchId: userProfile.branchId,
//                           organizationId: userProfile.organizationId,
//                           usersProfileTypeId: userProfile.usersProfileTypeId,
//                           profileType: 'Guard', // Adjust based on your logic
//                           email: userProfile.email,
//                           phone: userProfile.phone,
//                           profilePhoto: userProfile.profilePhoto,
//                         );
//
//                         // Save to SharedPreferences
//                         await SharedPrefs.saveUserContent(
//                           userContent,
//                           token: data['Token']?.toString(), // Save token if available
//                           guardId: userProfile.guardsId.toString(),
//                           userId: userProfile.usersProfileId.toString(),
//                           guardName: userProfile.fullName,
//                           branchId: userProfile.branchId.toString(),
//                           organizationId: userProfile.organizationId.toString(),
//                           guardsTypeId: userProfile.guardsTypeId.toString(),
//                         );
//
//                         // Also save to GetX controller
//                         Get.find<UserProfileController>().setUserData(userProfile);
//
//                         // Navigate to BottomNav and remove all previous routes
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(builder: (_) => BottomNav()),
//                               (route) => false,
//                         );
//                       } else {
//                         ApiService.showDialogOnApi(context, res.data['Message']);
//                       }
//                     } catch (e) {
//                       if (kDebugMode) {
//                         print(e);
//                       }
//                       ApiService.showDialogOnApi(context, "Something went wrong");
//                     } finally {
//                       setState(() {
//                         apoLoading = false;
//                       });
//                     }
//                   },
//                   buttonText: 'Sign in',
//                   child: apoLoading ? CircularProgressIndicator(color: AppTheme.secondaryTextButtonColor) : null,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
