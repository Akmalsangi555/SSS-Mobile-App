
import 'dart:convert';
import 'package:sssmobileapp/api_function.dart';
import 'package:sssmobileapp/model/auth_models/forgot_password_model.dart';
import 'package:sssmobileapp/utils/api_url/app_urls.dart';
import 'package:sssmobileapp/model/auth_models/login_user_model.dart';

class AuthRepository {
  AuthRepository();

  // ── LOGIN ────────────────────────────────────────────────────────
  Future<LoginResponse> login({
    required String email,
    required String password,
    required String lat,
    required String lon,
    required String os,
    required String location,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and Password are required.');
    }

    final body = {
      'Email': email.trim(),
      'Password': password,
      'lat': lat,
      'lon': lon,
      'os': os,
      'location': location,
    };

    _printRequestDetails('LOGIN', AppUrls.login, body);

    try {
      final res = await ApiService.post(
        'AuthAPI/Login',
        data: body,
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final dynamic data = res.data;
        Map<String, dynamic> json = {};

        if (data is Map<String, dynamic>) {
          json = data;
        } else if (data is String) {
          json = jsonDecode(data);
        }

        return LoginResponse.fromJson(json);
      } else {
        _logError('LOGIN', res);
        throw Exception('Login failed: ${res.statusCode}');
      }
    } catch (e) {
      print('Login Exception: $e');
      rethrow;
    }
  }

  // ── FORGOT PASSWORD ──────────────────────────────────────────────
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    // Debug output
    print('=== FORGOT PASSWORD REQUEST ===');
    print('Email: $email');
    print('===============================');

    final body = {
      'Email': email.trim(), // Changed from 'EmailAddress' to 'Email'
    };

    try {
      final apiResponse = await ApiService.post(
        'AuthAPI/ForgotPassword',
        data: body,
      );

      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
        final dynamic data = apiResponse.data;
        Map<String, dynamic> json = {};

        if (data is Map<String, dynamic>) {
          json = data;
        } else if (data is String) {
          try {
            final decoded = jsonDecode(data);
            if (decoded is Map<String, dynamic>) {
              json = decoded;
            } else {
              json = {
                'IsSuccess': true,
                'Message': data,
                'Content': null,
              };
            }
          } catch (_) {
            json = {
              'IsSuccess': true,
              'Message': data,
              'Content': null,
            };
          }
        } else {
          json = {
            'IsSuccess': true,
            'Message': 'Code sent successfully',
            'Content': null,
          };
        }

        print('=== FORGOT PASSWORD RESPONSE ===');
        print('Response: $json');
        print('================================');

        return ForgotPasswordResponse.fromJson(json);
      }

      final dynamic err = apiResponse.data;
      String errorMsg = 'Failed to send reset code';

      if (err is Map && err['Message'] is String) {
        errorMsg = err['Message'] as String;
      } else if (err is String && err.trim().isNotEmpty) {
        errorMsg = err.trim();
      }

      throw Exception('$errorMsg (${apiResponse.statusCode})');
    } catch (e) {
      print('Forgot Password Error: $e');
      rethrow;
    }
  }

  // ── VERIFY RESET CODE ────────────────────────────────────────────
  Future<ForgotPasswordResponse> verifyResetCode({
    required int userId,
    required int code,
  }) async {
    print('=== VERIFY RESET CODE REQUEST ===');
    print('User ID: $userId');
    print('Code: $code');
    print('==================================');

    final body = {
      'UserId': userId,
      'Code': code,
    };

    try {
      final apiResponse = await ApiService.post(
        'AuthAPI/VerifyResetCode',
        data: body,
      );

      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
        final dynamic data = apiResponse.data;
        Map<String, dynamic> json = {};

        if (data is Map<String, dynamic>) {
          json = data;
        } else if (data is String) {
          try {
            final decoded = jsonDecode(data);
            if (decoded is Map<String, dynamic>) {
              json = decoded;
            } else {
              json = {
                'IsSuccess': true,
                'Message': data,
                'Content': null,
              };
            }
          } catch (_) {
            json = {
              'IsSuccess': true,
              'Message': data,
              'Content': null,
            };
          }
        } else {
          json = {
            'IsSuccess': true,
            'Message': 'Code verified successfully',
            'Content': null,
          };
        }

        print('=== VERIFY RESET CODE RESPONSE ===');
        print('Response: $json');
        print('==================================');

        return ForgotPasswordResponse.fromJson(json);
      }

      final dynamic err = apiResponse.data;
      String errorMsg = 'Failed to verify code';

      if (err is Map && err['Message'] is String) {
        errorMsg = err['Message'] as String;
      } else if (err is String && err.trim().isNotEmpty) {
        errorMsg = err.trim();
      }

      throw Exception('$errorMsg (${apiResponse.statusCode})');
    } catch (e) {
      print('Verify Reset Code Error: $e');
      rethrow;
    }
  }

  // ── UPDATE PASSWORD CODE ────────────────────────────────────────────
  Future<ForgotPasswordResponse> updatePassword({
    required int userId,
    required int code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    print('=== UPDATE PASSWORD REQUEST ===');
    print('User ID: $userId');
    print('Code: $code');
    print('================================');

    final body = {
      'UserId': userId,
      'Code': code,
      'NewPassword': newPassword,
      'ConfirmPassword': confirmPassword,
    };

    try {
      final apiResponse = await ApiService.post(
        'AuthAPI/UpdatePassword',
        data: body,
      );

      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
        final dynamic data = apiResponse.data;
        Map<String, dynamic> json = {};

        if (data is Map<String, dynamic>) {
          json = data;
        } else if (data is String) {
          try {
            final decoded = jsonDecode(data);
            if (decoded is Map<String, dynamic>) {
              json = decoded;
            } else {
              json = {
                'IsSuccess': true,
                'Message': data,
                'Content': null,
              };
            }
          } catch (_) {
            json = {
              'IsSuccess': true,
              'Message': data,
              'Content': null,
            };
          }
        } else {
          json = {
            'IsSuccess': true,
            'Message': 'Password updated successfully',
            'Content': null,
          };
        }

        print('=== UPDATE PASSWORD RESPONSE ===');
        print('Response: $json');
        print('================================');

        return ForgotPasswordResponse.fromJson(json);
      }

      final dynamic err = apiResponse.data;
      String errorMsg = 'Failed to update password';

      if (err is Map && err['Message'] is String) {
        errorMsg = err['Message'] as String;
      } else if (err is String && err.trim().isNotEmpty) {
        errorMsg = err.trim();
      }

      throw Exception('$errorMsg (${apiResponse.statusCode})');
    } catch (e) {
      print('Update Password Error: $e');
      rethrow;
    }
  }

  // ── HELPER METHODS ──────────────────────────────────────────────
  void _printRequestDetails(String type, String url, Map<String, dynamic> body) {
    print('========== $type REQUEST ==========');
    print('URL: $url');
    print('Body: ${jsonEncode(body)}');
    print('===================================');
  }

  void _logError(String type, ApiResponse res) {
    print('========== $type ERROR ==========');
    print('Status: ${res.statusCode}');
    print('Body: ${res.data}');
    print('=================================');
  }

  void printUserData(LoginUserModel user) {
    print('========== USER LOGIN DATA ==========');
    print('User ID: ${user.usersProfileId}');
    print('Guard ID: ${user.guardsId}');
    print('Full Name: ${user.fullName}');
    print('Email: ${user.email}');
    print('Phone: ${user.phone}');
    print('Branch ID: ${user.branchId}');
    print('Organization ID: ${user.organizationId}');
    print('Profile Type ID: ${user.usersProfileTypeId}');
    print('Guard Type ID: ${user.guardsTypeId}');
    if (user.profilePhoto != null) {
      print('Profile Photo: ${user.profilePhoto}');
    }
    print('=====================================');
  }
}

// class AuthRepository {
//   AuthRepository();
//
//   // ── LOGIN ────────────────────────────────────────────────────────
//   Future<LoginResponse> login({
//     required String email,
//     required String password,
//     required String lat,
//     required String lon,
//     required String os,
//     required String location,
//   }) async {
//     if (email.isEmpty || password.isEmpty) {
//       throw Exception('Email and Password are required.');
//     }
//
//     final body = {
//       'Email': email.trim(),
//       'Password': password,
//       'lat': lat,
//       'lon': lon,
//       'os': os,
//       'location': location,
//     };
//
//     _printRequestDetails('LOGIN', AppUrls.login, body);
//
//     try {
//       final res = await ApiService.post(
//         'AuthAPI/Login',
//         data: body,
//       );
//
//       if (res.statusCode == 200 || res.statusCode == 201) {
//         final dynamic data = res.data;
//         Map<String, dynamic> json = {};
//
//         if (data is Map<String, dynamic>) {
//           json = data;
//         } else if (data is String) {
//           json = jsonDecode(data);
//         }
//
//         return LoginResponse.fromJson(json);
//       } else {
//         _logError('LOGIN', res);
//         throw Exception('Login failed: ${res.statusCode}');
//       }
//     } catch (e) {
//       print('Login Exception: $e');
//       rethrow;
//     }
//   }
//
//   // ── FORGOT PASSWORD ──────────────────────────────────────────────
//   Future<ForgotPasswordResponse> forgotPassword(String email) async {
//     if (email.trim().isEmpty || !email.contains('@')) {
//       throw Exception('Please enter a valid email address');
//     }
//
//     final body = {
//       'EmailAddress': email.trim(),
//     };
//
//     try {
//       final apiResponse = await ApiService.post(
//         'AuthAPI/ForgotPassword',
//         data: body,
//       );
//
//       if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
//         final dynamic data = apiResponse.data;
//         Map<String, dynamic> json = {};
//
//         if (data is Map<String, dynamic>) {
//           json = data;
//         } else if (data is String) {
//           try {
//             final decoded = jsonDecode(data);
//             if (decoded is Map<String, dynamic>) {
//               json = decoded;
//             } else {
//               json = {
//                 'IsSuccess': true,
//                 'Message': data,
//                 'Content': null,
//               };
//             }
//           } catch (_) {
//             json = {
//               'IsSuccess': true,
//               'Message': data,
//               'Content': null,
//             };
//           }
//         } else {
//           json = {
//             'IsSuccess': true,
//             'Message': 'Code sent successfully',
//             'Content': null,
//           };
//         }
//
//         return ForgotPasswordResponse.fromJson(json);
//       }
//
//       final dynamic err = apiResponse.data;
//       String errorMsg = 'Failed to send reset code';
//
//       if (err is Map && err['Message'] is String) {
//         errorMsg = err['Message'] as String;
//       } else if (err is String && err.trim().isNotEmpty) {
//         errorMsg = err.trim();
//       }
//
//       throw Exception('$errorMsg (${apiResponse.statusCode})');
//     } catch (e) {
//       print('Forgot Password Error: $e');
//       rethrow;
//     }
//   }
//
//   // ── HELPER METHODS ──────────────────────────────────────────────
//   void _printRequestDetails(String type, String url, Map<String, dynamic> body) {
//     print('========== $type REQUEST ==========');
//     print('URL: $url');
//     print('Body: ${jsonEncode(body)}');
//     print('===================================');
//   }
//
//   void _logError(String type, ApiResponse res) {
//     print('========== $type ERROR ==========');
//     print('Status: ${res.statusCode}');
//     print('Body: ${res.data}');
//     print('=================================');
//   }
//
//   void printUserData(LoginUserModel user) {
//     print('========== USER LOGIN DATA ==========');
//     print('User ID: ${user.usersProfileId}');
//     print('Guard ID: ${user.guardsId}');
//     print('Full Name: ${user.fullName}');
//     print('Email: ${user.email}');
//     print('Phone: ${user.phone}');
//     print('Branch ID: ${user.branchId}');
//     print('Organization ID: ${user.organizationId}');
//     print('Profile Type ID: ${user.usersProfileTypeId}');
//     print('Guard Type ID: ${user.guardsTypeId}');
//     if (user.profilePhoto != null) {
//       print('Profile Photo: ${user.profilePhoto}');
//     }
//     print('=====================================');
//   }
// }
