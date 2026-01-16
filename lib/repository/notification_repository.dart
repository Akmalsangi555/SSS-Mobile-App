
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sssmobileapp/api_function.dart';
import 'package:sssmobileapp/utils/api_url/app_urls.dart';
import 'package:sssmobileapp/model/notification_model/notification_model.dart';

class NotificationRepository {
  NotificationRepository();

  // ── GET SYSTEM NOTIFICATIONS ────────────────────────────────────────
  Future<NotificationModel> getSystemNotifications({
    required String guardId,
  }) async {
    try {
      // Build URL exactly as it works in Postman
      final url = '${AppUrls.baseUrl}/MyNotifictions/SystemNotifications?GuardId=$guardId';

      print('🔗 API Request URL: $url');
      print('🔑 Token present: ${ApiService.token.isNotEmpty}');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${ApiService.token}',
          'Content-Type': 'application/json',
          'device': ApiService.device,
          if (ApiService.appVersion != null) 'version': ApiService.appVersion!,
        },
      );

      print('📊 Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        final model = NotificationModel.fromJson(data);
        print('✅ Successfully loaded ${model.content?.length ?? 0} notifications');
        return model;
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else {
        throw Exception('Failed to fetch notifications: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Get Notifications Exception: $e');
      rethrow;
    }
  }

  // ── MARK NOTIFICATION AS READ ────────────────────────────────────────
  Future<bool> markAsRead({
    required int notificationId,
    required String guardId,
  }) async {
    try {
      final url = '${AppUrls.baseUrl}/MyNotifictions/MarkAsRead';
      final body = jsonEncode({
        'NotificationId': notificationId,
        'GuardId': guardId,
      });

      print('🔗 Mark as Read URL: $url');
      print('📦 Request Body: $body');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${ApiService.token}',
          'Content-Type': 'application/json',
          'device': ApiService.device,
          if (ApiService.appVersion != null) 'version': ApiService.appVersion!,
        },
        body: body,
      );

      print('📊 Response Status: ${response.statusCode}');
      print('📄 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        final isSuccess = data['IsSuccess'] ?? false;
        if (isSuccess) {
          print('✅ Notification $notificationId marked as read');
        } else {
          print('⚠️ Mark as read failed: ${data['Message']}');
        }
        return isSuccess;
      } else {
        throw Exception('Failed to mark as read: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Mark as Read Exception: $e');
      rethrow;
    }
  }

  // ── DELETE NOTIFICATION ──────────────────────────────────────────────
  Future<bool> deleteNotification({
    required int notificationId,
    required String guardId,
  }) async {
    try {
      final url = '${AppUrls.baseUrl}/MyNotifictions/DeleteNotification?NotificationId=$notificationId&GuardId=$guardId';

      print('🔗 Delete URL: $url');

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${ApiService.token}',
          'Content-Type': 'application/json',
          'device': ApiService.device,
          if (ApiService.appVersion != null) 'version': ApiService.appVersion!,
        },
      );

      print('📊 Response Status: ${response.statusCode}');
      print('📄 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        final isSuccess = data['IsSuccess'] ?? false;
        if (isSuccess) {
          print('✅ Notification $notificationId deleted');
        } else {
          print('⚠️ Delete failed: ${data['Message']}');
        }
        return isSuccess;
      } else {
        throw Exception('Failed to delete notification: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Delete Notification Exception: $e');
      rethrow;
    }
  }
}
