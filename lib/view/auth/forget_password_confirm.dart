
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sssmobileapp/api_function.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';
import 'package:sssmobileapp/view_model/auth_controller/auth_controller.dart';

class ForgetPasswordConfirm extends StatefulWidget {
  const ForgetPasswordConfirm({
    super.key,
    required this.email,
    required this.userId,
  });

  final String email;
  final int userId;

  @override
  State<ForgetPasswordConfirm> createState() => _ForgetPasswordConfirmState();
}

class _ForgetPasswordConfirmState extends State<ForgetPasswordConfirm> {
  final AuthController _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _handleResendCode() async {
    await _authController.sendForgotPasswordCode(widget.email);
  }

  Future<void> _handleVerifyCode() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final code = int.parse(_codeController.text.trim());
      final success = await _authController.verifyResetCode(
        userId: widget.userId,
        code: code,
      );

      if (success) {
        // Navigation is handled in the controller
      }
    } catch (e) {
      ApiService.showDialogOnApi(context, 'Invalid code format. Please enter numbers only.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SScaffold(
      titleOfPage: 'Forget password',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Column(
          children: [
            Text(
              'A code has been sent to your email. Check inbox or spam and enter it below to reset your password.',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textColor97,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: SizedBox(
                    height: 47,
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _codeController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Invalid code. Please try again.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Type a code',
                          errorStyle: const TextStyle(
                            fontSize: 11,
                            height: 1.0,
                            color: Colors.red,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: AppTheme.primaryTextButtonColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 47,
                    width: 150,
                    child: Obx(() => SSSFilledButton(
                      bgColor: AppTheme.primaryBGButtonColor,
                      buttonText: 'Resend',
                      onPressed: _authController.isForgotPasswordLoading.value
                          ? null
                          : _handleResendCode,
                      child: _authController.isForgotPasswordLoading.value
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                          : null,
                    )),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: Obx(() => SSSFilledButton(
                buttonText: 'Verify',
                onPressed: _authController.isVerifyCodeLoading.value ?
                null : _handleVerifyCode,
                child: _authController.isVerifyCodeLoading.value ?
                const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ) : null,
              )),
            ),
          ],
        ),
      ),
    );
  }
}

// class ForgetPasswordConfirm extends StatefulWidget {
//   const ForgetPasswordConfirm(
//       {super.key, required this.email, required this.userId});
//   final String email;
//   final int userId;
//
//   @override
//   State<ForgetPasswordConfirm> createState() => _ForgetPasswordConfirmState();
// }
//
// class _ForgetPasswordConfirmState extends State<ForgetPasswordConfirm> {
//   bool isApiCallInProgress = false;
//   bool isConfirmApiCallInProgress = false;
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController codeController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SScaffold(
//       titleOfPage: 'Forget password',
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
//         child: Column(
//           children: [
//             Text('A code has been sent to your email. Check inbox or spam and enter it below to reset your password.',
//             style: TextStyle(fontSize: 14 , color: AppTheme.textColor97, fontWeight: FontWeight.w400),),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   flex: 7,
//                   child: SizedBox(
//                     height: 47 + 20,
//                     child: TextFormField(
//                       controller: codeController,
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Invalid code. Please try again.';
//                         }
//                         return null;
//                       },
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'Type a code',
//                         // Important: make error text smaller and align better
//                         errorStyle: const TextStyle(
//                           fontSize: 11,
//                           height: 1.0,
//                           color: Colors.red,
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 12,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         // optional: filled style
//                         filled: true,
//                         fillColor: Colors.grey.shade50,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Flexible(
//                 //   flex: 3,
//                 //   child: Container(
//                 //     height: 47,
//                 //     child: Form(
//                 //       key: _formKey,
//                 //       child: TextFormField(
//                 //         controller: codeController,
//                 //         validator: (value) {
//                 //           if (value == null || value.isEmpty) {
//                 //             return 'Invalid code. Please try again.';
//                 //           }
//                 //           return null;
//                 //         },
//                 //         keyboardType: TextInputType.number,
//                 //         decoration: InputDecoration(
//                 //           labelText: 'Type a code',
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   flex: 3,
//                   child: Container(
//                     height: 47,
//                     width: 150,
//                     child: SSSFilledButton(
//                       bgColor: AppTheme.primaryBGButtonColor,
//                       buttonText: 'Resend',
//                       onPressed: () async {
//                         if (!isApiCallInProgress) {
//                           try {
//                             setState(() {
//                               isApiCallInProgress = true;
//                             });
//                             var res = await ApiService.post('AuthAPI/ForgotPassword',
//                                 data: {'email': widget.email});
//                             if (kDebugMode) {
//                               print(res.data);
//                             }
//                             if (res.statusCode == 200 &&
//                                 res.data['IsSuccess'] == true) {
//                               ApiService.showSnackBarOnDialog(
//                                   context, res.data['Message']);
//                             } else {
//                               ApiService.showSnackBarOnDialog(
//                                   context, res.data['Message']);
//                             }
//                           } catch (e) {
//                             if (kDebugMode) {
//                               print(e);
//                             }
//                             ApiService.showSnackBarOnDialog(
//                                 context, "Something went wrong");
//                           } finally {
//                             setState(() {
//                               isApiCallInProgress = false;
//                             });
//                           }
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 50),
//             SizedBox(
//               width: double.infinity,
//               child: SSSFilledButton(
//                 buttonText: 'Verify',
//                 onPressed: () async {
//                   if (!isConfirmApiCallInProgress) {
//                     if (!_formKey.currentState!.validate()) {
//                       return;
//                     }
//                     try {
//                       setState(() {
//                         isConfirmApiCallInProgress = true;
//                       });
//                       int code = int.parse(codeController.text.trim());
//                       var res = await ApiService.post('AuthAPI/VerifyResetCode',
//                           data: {"UserId": widget.userId, "Code": code});
//                       if (res.statusCode == 200 &&
//                           res.data['IsSuccess'] == true) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => ChangePassword(
//                                       userId: widget.userId,
//                                       code: code,
//                                     )));
//                       } else {
//                         ApiService.showDialogOnApi(context, res.data['Message']);
//                       }
//                     } catch (e) {
//                       if (kDebugMode) {
//                         print(e);
//                       }
//                       ApiService.showDialogOnApi(context, 'Something went wrong');
//                     } finally {
//                       setState(() {
//                         isConfirmApiCallInProgress = false;
//                       });
//                     }
//                   }
//                 },
//                 child: isConfirmApiCallInProgress
//                     ? CircularProgressIndicator()
//                     : null,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
