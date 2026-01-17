
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';
import 'package:sssmobileapp/view_model/notification_controller.dart';
import 'package:sssmobileapp/model/notification_model/notification_model.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final NotificationController _controller = Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.notifications.isEmpty && !_controller.isLoading.value) {
        _controller.fetchNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SScaffold(
      appBar: AppBar(
        leadingWidth: 70,
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: Obx(() {
        // Show loading
        if (_controller.isLoading.value && _controller.notifications.isEmpty) {
          return Center(
              child:
                  CircularProgressIndicator(color: AppTheme.backgroundColor));
        }

        // Show error
        if (_controller.errorMessage.isNotEmpty &&
            _controller.notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  _controller.errorMessage.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                SSSFilledButton(
                  buttonText: 'Retry',
                  onPressed: _controller.refreshNotifications,
                  buttonWidth: 120,
                ),
              ],
            ),
          );
        }

        // Show empty state
        if (_controller.notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'No notifications yet',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'You\'ll see notifications here when they arrive',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                SSSFilledButton(
                  buttonText: 'Refresh',
                  onPressed: _controller.refreshNotifications,
                  buttonWidth: 120,
                ),
              ],
            ),
          );
        }

        // Show notifications with ListView
        return RefreshIndicator(
          onRefresh: _controller.refreshNotifications,
          color: AppTheme.backgroundColor,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            itemCount: _controller.notifications.length,
            itemBuilder: (context, index) {
              final notification = _controller.notifications[index];
              return _buildNotificationItem(notification);
            },
          ),
        );
      }),
    );
  }

  Widget _buildNotificationItem(NotificationsContent notification) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppTheme.notificationBackgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getTitleFromNotification(notification),
                  style: TextStyle(
                    color: AppTheme.backgroundColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification.message ?? 'No message',
                  style: TextStyle(color: AppTheme.primaryTextColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _formatDateFromAPI(notification.createDateTime),
                style: TextStyle(
                  color: AppTheme.primaryTextColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getTitleFromNotification(NotificationsContent notification) {
    return notification.userName ??
        notification.notificationType ??
        '${notification.firstName ?? ''} ${notification.lastName ?? ''}'.trim();
  }

  String _formatDateFromAPI(String? dateTimeString) {
    if (dateTimeString == null) return '';

    try {
      final dateTime = DateTime.parse(dateTimeString);
      final day = dateTime.day.toString().padLeft(2, '0');
      final month = dateTime.month.toString().padLeft(2, '0');
      final year = dateTime.year;
      final weekday = [
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun'
      ][dateTime.weekday - 1];
      final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final period = dateTime.hour < 12 ? 'AM' : 'PM';

      return '$day/$month/$year $weekday ${hour.toString().padLeft(2, '0')}:$minute$period';
    } catch (e) {
      return dateTimeString;
    }
  }
}
