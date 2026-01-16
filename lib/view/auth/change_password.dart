
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';
import 'package:sssmobileapp/view_model/auth_controller/auth_controller.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    super.key,
    required this.userId,
    required this.code,
  });

  final int userId;
  final int code;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final AuthController _authController = AuthController.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() => setState(() => _showPassword = !_showPassword);
  void _toggleConfirmPasswordVisibility() => setState(() => _showConfirmPassword = !_showConfirmPassword);

  Future<void> _handleUpdatePassword() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    final validationError = _authController.validatePasswords(password, confirmPassword);
    if (validationError != null) {
      Get.snackbar('Error', validationError);
      return;
    }

    await _authController.updatePassword(
      userId: widget.userId,
      code: widget.code,
      newPassword: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SScaffold(
      titleOfPage: 'Change Password',
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              _buildPasswordField(
                title: 'Type your new password',
                controller: _passwordController,
                hintText: 'New password',
                isVisible: _showPassword,
                onToggle: _togglePasswordVisibility,
              ),
              const SizedBox(height: 16),
              _buildPasswordField(
                title: 'Confirm password',
                controller: _confirmPasswordController,
                hintText: 'Confirm password',
                isVisible: _showConfirmPassword,
                onToggle: _toggleConfirmPasswordVisibility,
              ),
              const SizedBox(height: 48),
              _buildUpdateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String title,
    required TextEditingController controller,
    required String hintText,
    required bool isVisible,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.secondaryColor,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          obscureText: !isVisible,
          validator: _validateField,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                // color: AppTheme.primaryColor,
              ),
              onPressed: onToggle,
            ),
          ),
        ),
      ],
    );
  }

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  Widget _buildUpdateButton() {
    return Obx(() => SSSFilledButton(
      buttonText: 'Change Password',
      onPressed: _authController.isUpdatePasswordLoading.value
          ? null
          : _handleUpdatePassword,
      isLoading: _authController.isUpdatePasswordLoading.value,
      buttonWidth: double.infinity,
    ));
  }
}

// class ChangePassword extends StatefulWidget {
//   const ChangePassword({super.key, required this.userId, required this.code});
//   final int userId;
//   final int code;
//   @override
//   State<ChangePassword> createState() => _ChangePasswordState();
// }
//
// class _ChangePasswordState extends State<ChangePassword> {
//   bool isApiCalling = false;
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmedPasswordController = TextEditingController();
//   bool showPassword = false;
//   bool showConfirmedPassword = false;
//   @override
//   Widget build(BuildContext context) {
//     return SScaffold(
//         titleOfPage: 'Change password',
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 32,
//                 ),
//                 Text(
//                   'Type your new password',
//                   style:
//                       TextStyle(fontSize: 12, color: AppTheme.secondaryColor),
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 TextFormField(
//                   controller: passwordController,
//                   obscureText: !showPassword,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password.';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                       hintText: 'New password',
//                       suffixIcon: IconButton(
//                           icon: Icon(showPassword
//                               ? Icons.visibility
//                               : Icons.visibility_off),
//                           onPressed: () {
//                             setState(() {
//                               showPassword = !showPassword;
//                             });
//                           })),
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Text(
//                   'Confirm password',
//                   style:
//                       TextStyle(fontSize: 12, color: AppTheme.secondaryColor),
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 TextFormField(
//                   controller: confirmedPasswordController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your confirm password.';
//                     }
//                     return null;
//                   },
//                   obscureText: !showConfirmedPassword,
//                   decoration: InputDecoration(
//                       hintText: 'Confirm password',
//                       suffixIcon: IconButton(
//                           icon: Icon(showConfirmedPassword ?
//                           Icons.visibility : Icons.visibility_off),
//                           onPressed: () {
//                             setState(() {
//                               showConfirmedPassword = !showConfirmedPassword;
//                             });
//                           })),
//                 ),
//                 SizedBox(
//                   height: 48,
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: SSSFilledButton(
//                     buttonText: 'Change password',
//                     onPressed: () async {
//                       FocusManager.instance.primaryFocus?.unfocus();
//
//                       if (!isApiCalling) {
//                         if (!_formKey.currentState!.validate()) {
//                           return;
//                         } else if (passwordController.text !=
//                             confirmedPasswordController.text) {
//                           ApiService.showDialogOnApi(context,
//                               'Password and confirmed password do not match.');
//                           return;
//                         }
//
//                         try {
//                           setState(() {
//                             isApiCalling = true;
//                           });
//                           var res =
//                               await ApiService.post('AuthAPI/UpdatePassword', data: {
//                             "UserId": widget.userId,
//                             "Code": widget.code,
//                             "NewPassword": passwordController.text,
//                             "ConfirmPassword": confirmedPasswordController.text
//                           });
//                           if (res.statusCode == 200 &&
//                               res.data['IsSuccess'] == true) {
//                             Navigator.pushAndRemoveUntil(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => SignIn(),
//                               ),
//                               (route) => false,
//                             );
//                           } else {
//                             ApiService.showDialogOnApi(context, res.data['Message']);
//                           }
//                         } catch (e) {
//                           if (kDebugMode) {
//                             print(e);
//                           }
//                           ApiService.showDialogOnApi(context, e.toString());
//                         } finally {
//                           setState(() {
//                             isApiCalling = false;
//                           });
//                         }
//                       }
//                     },
//                     child: isApiCalling ? CircularProgressIndicator() : null,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
