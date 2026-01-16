
class AppUrls {
  // Base URL (change this for different environments)
  static String get linkUrl => 'https://beta.swiftexsecurity.com/';
  static const String baseUrl = 'https://beta.swiftexsecurity.com/api';

  // Auth endpoints
  static const String login = '$baseUrl/AuthAPI/Login';
  static const String forgetPasswordUrl = '$baseUrl/AuthAPI/ForgotPassword';
  static const String verifyOtp = '$baseUrl/AuthAPI/VerifyOTP';
  static const String resetPassword = '$baseUrl/AuthAPI/ResetPassword';

  // Notification endpoints - Use EXACT spelling from API
  static const String systemNotifications = '$baseUrl/MyNotifictions/SystemNotifications';
  static const String markAsRead = '$baseUrl/MyNotifictions/MarkAsRead';
  static const String deleteNotification = '$baseUrl/MyNotifictions/DeleteNotification';

}
