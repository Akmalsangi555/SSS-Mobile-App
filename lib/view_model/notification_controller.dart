
import 'package:get/get.dart';
import 'package:sssmobileapp/utils/local_storage/shared_pref.dart';
import 'package:sssmobileapp/repository/notification_repository.dart';
import 'package:sssmobileapp/model/notification_model/notification_model.dart';

class NotificationController extends GetxController {
  final NotificationRepository _notificationRepo = NotificationRepository();

  // State variables
  final RxList<NotificationsContent> notifications = <NotificationsContent>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasMore = true.obs;
  final RxInt currentPage = 1.obs;
  final RxBool isMarkingAsRead = false.obs;
  final RxBool isDeleting = false.obs;

  // Use RxString for guardId (cleaner)
  final RxString guardId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadGuardId();
  }

  Future<void> _loadGuardId() async {
    try {
      final id = await SharedPrefs.getGuardId();
      guardId.value = id ?? '';
      if (guardId.isEmpty) {
        errorMessage.value = 'User not logged in';
      }
    } catch (e) {
      errorMessage.value = 'Error loading user data';
    }
  }

  Future<void> fetchNotifications({bool isRefresh = false}) async {
    try {
      if (guardId.isEmpty) {
        await _loadGuardId();
      }

      if (guardId.isEmpty) {
        errorMessage.value = 'Please login again';
        return;
      }

      if (isRefresh) {
        currentPage.value = 1;
        hasMore.value = true;
        notifications.clear();
      }

      isLoading.value = true;
      errorMessage.value = '';

      final response = await _notificationRepo.getSystemNotifications(
        guardId: guardId.value,
      );

      if (response.isSuccess ?? false) {
        if (response.content != null && response.content!.isNotEmpty) {
          notifications.addAll(response.content!);

          // Sort by date (newest first)
          notifications.sort((a, b) {
            final dateA = DateTime.tryParse(a.createDateTime ?? '');
            final dateB = DateTime.tryParse(b.createDateTime ?? '');
            return (dateB ?? DateTime(0)).compareTo(dateA ?? DateTime(0));
          });

          // Assume no more data if less than 20 items
          if (response.content!.length < 20) {
            hasMore.value = false;
          }
        } else {
          hasMore.value = false;
        }

        print('Loaded ${notifications.length} notifications');
      } else {
        errorMessage.value = response.message ?? 'Failed to load notifications';
      }
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '').trim();
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> markNotificationAsRead(int notificationId) async {
    if (guardId.isEmpty) return false;

    try {
      isMarkingAsRead.value = true;
      final success = await _notificationRepo.markAsRead(
        notificationId: notificationId,
        guardId: guardId.value,
      );

      if (success) {
        // Update local notification if you have isRead field
        final index = notifications.indexWhere(
                (n) => n.systemNotificationID == notificationId
        );
        if (index != -1) {
          // notifications[index] = notifications[index].copyWith(isRead: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      return false;
    } finally {
      isMarkingAsRead.value = false;
    }
  }

  // Future<bool> deleteNotification(int notificationId) async {
  //   if (guardId.isEmpty) return false;
  //
  //   try {
  //     isDeleting.value = true;
  //     final success = await _notificationRepo.deleteNotification(
  //       notificationId: notificationId,
  //       guardId: guardId.value,
  //     );
  //
  //     if (success) {
  //       notifications.removeWhere((n) => n.systemNotificationID == notificationId);
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     return false;
  //   } finally {
  //     isDeleting.value = false;
  //   }
  // }

  Future<void> markAllAsRead() async {
    if (guardId.isEmpty || notifications.isEmpty) return;

    try {
      isMarkingAsRead.value = true;

      for (final notification in notifications) {
        if (notification.systemNotificationID != null) {
          await _notificationRepo.markAsRead(
            notificationId: notification.systemNotificationID!,
            guardId: guardId.value,
          );
        }
      }
    } finally {
      isMarkingAsRead.value = false;
    }
  }

  // Future<void> clearAllNotifications() async {
  //   if (notifications.isEmpty) return;
  //
  //   try {
  //     isLoading.value = true;
  //
  //     // Delete in reverse to avoid index issues
  //     final notificationsCopy = List<NotificationsContent>.from(notifications);
  //     for (final notification in notificationsCopy) {
  //       if (notification.systemNotificationID != null) {
  //         await deleteNotification(notification.systemNotificationID!);
  //       }
  //     }
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> refreshNotifications() async {
    await fetchNotifications(isRefresh: true);
  }

  // Getter for unread count (add isRead field to NotificationsContent model)
  int get unreadCount => notifications.where((n) => !(n.isRead ?? false)).length;

  bool get hasNotifications => notifications.isNotEmpty;
}
