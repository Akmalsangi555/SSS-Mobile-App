
// Forgot Password Response Model
class ForgotPasswordResponse {
  final bool isSuccess;
  final String message;
  final int? content;

  ForgotPasswordResponse({
    required this.isSuccess,
    required this.message,
    this.content,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      isSuccess: json['IsSuccess'] ?? false,
      message: json['Message'] ?? '',
      content: json['Content'] is int
          ? json['Content']
          : (json['Content'] is String
          ? int.tryParse(json['Content'])
          : null),
    );
  }
}

// class ForgotPasswordResponse {
//   final bool isSuccess;
//   final String message;
//   final int? content;
//
//   ForgotPasswordResponse({
//     required this.isSuccess,
//     required this.message,
//     this.content,
//   });
//
//   factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
//     return ForgotPasswordResponse(
//       isSuccess: json['IsSuccess'] as bool? ?? false,
//       message: json['Message'] as String? ?? 'No message provided',
//       content: json['Content'] as int?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'IsSuccess': isSuccess,
//       'Message': message,
//       'Content': content,
//     };
//   }
//
//   @override
//   String toString() {
//     return 'ForgotPasswordResponse(isSuccess: $isSuccess, message: "$message", content: $content)';
//   }
// }
