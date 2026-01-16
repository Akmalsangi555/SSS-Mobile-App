
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';
import 'package:sssmobileapp/view_model/auth_controller/auth_controller.dart';

class ForgetPasswordClass extends StatefulWidget {
  const ForgetPasswordClass({super.key});

  @override
  State<ForgetPasswordClass> createState() => _ForgetPasswordClassState();
}

class _ForgetPasswordClassState extends State<ForgetPasswordClass> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SScaffold(
      titleOfPage: 'Forgot password',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Error message display
            Obx(() {
              if (_authController.forgotPasswordErrorMessage.isNotEmpty) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _authController.forgotPasswordErrorMessage.value,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }
              return const SizedBox();
            }),

            _buildInstructionText(),
            const SizedBox(height: 16),
            _buildEmailForm(),
            const SizedBox(height: 50),
            _buildGetCodeButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionText() {
    return const Text(
      'Enter your email to reset your password',
      style: TextStyle(fontSize: 14, color: Colors.black87),
    );
  }

  Widget _buildEmailForm() {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: emailController,
        validator: _validateEmail,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: const TextStyle(color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppTheme.backgroundColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildGetCodeButton() {
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        child: SSSFilledButton(
          buttonText: 'Get code',
          onPressed: _authController.isForgotPasswordLoading.value
              ? null
              : _handleGetCode,
          child: _authController.isForgotPasswordLoading.value
              ? const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          )
              : null,
        ),
      );
    });
  }

  // ── VALIDATION METHOD ──────────────────────────────────────────────
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email.';
    } else if (!value.contains('@')) {
      return 'Invalid email. Please try again.';
    }
    return null;
  }

  // ── EVENT HANDLER ──────────────────────────────────────────────
  Future<void> _handleGetCode() async {
    // Clear any previous errors
    _authController.forgotPasswordErrorMessage.value = '';

    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Debug: Print the email being sent
    print('=== FORGOT PASSWORD WIDGET ===');
    print('Email entered: ${emailController.text}');
    print('Trimmed email: ${emailController.text.trim()}');
    print('=============================');

    // Call controller method
    await _authController.sendForgotPasswordCode(
      emailController.text.trim(),
    );
  }
}

// class ForgetPasswordClass extends StatefulWidget {
//   const ForgetPasswordClass({super.key});
//
//   @override
//   State<ForgetPasswordClass> createState() => _ForgetPasswordClassState();
// }
//
// class _ForgetPasswordClassState extends State<ForgetPasswordClass> {
//   TextEditingController emailController = TextEditingController();
//   bool isApiCallInProgress = false;
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return SScaffold(
//       titleOfPage: 'Forget password',
//       child: Padding(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Enter your email to reset your password'),
//             SizedBox(
//               height: 16,
//             ),
//             Form(
//               key: _formKey,
//               child: TextFormField(
//                 controller: emailController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email.';
//                   } else if (!value.contains('@')) {
//                     return 'Invalid email. Please try again.';
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 32,
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: SSSFilledButton(
//                 buttonText: 'Get code',
//                 onPressed: () async {
//                   if (!isApiCallInProgress) {
//                     if (!_formKey.currentState!.validate()) {
//                       return;
//                     }
//
//                     try {
//                       setState(() {
//                         isApiCallInProgress = true;
//                       });
//                       var res = await ApiService.post('AuthAPI/ForgotPassword',
//                           data: {'email': emailController.text});
//                       if (kDebugMode) {
//                         print(res.data);
//                       }
//                       if (res.statusCode == 200 &&
//                           res.data['IsSuccess'] == true) {
//                         int userId = res.data['Content'];
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => ForgetPasswordConfirm(
//                                       email: emailController.text,
//                                       userId: userId,
//                                     )));
//                       } else {
//                         ApiService.showSnackBarOnDialog(context, res.data['Message']);
//                       }
//                     } catch (e) {
//                       if (kDebugMode) {
//                         print(e);
//                       }
//                       ApiService.showSnackBarOnDialog(context, "Something went wrong");
//                     } finally {
//                       setState(() {
//                         isApiCallInProgress = false;
//                       });
//                     }
//                   }
//                 },
//                 child: isApiCallInProgress ? CircularProgressIndicator() : null,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
