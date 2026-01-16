import 'package:get/get.dart';
import 'package:sssmobileapp/model/attendance_history_model.dart';
import 'package:sssmobileapp/model/auth_models/login_user_model.dart';
import 'package:sssmobileapp/repository/attendance_repository.dart';
import 'package:sssmobileapp/utils/local_storage/shared_pref.dart';
import 'package:sssmobileapp/controller/user_profile_controller.dart';
import 'package:sssmobileapp/api_function.dart';

class AttendanceController extends GetxController {
  final AttendanceRepository _repo = AttendanceRepository();

  final RxList<AttendanceHistoryModel> attendanceHistory =
      <AttendanceHistoryModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> loadAttendanceHistory() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      LoginUserModel? userData = Get.find<UserProfileController>().userData;
      if (userData == null) {
        final saved = await SharedPrefs.getUserContent();
        if (saved != null) {
          final guardsTypeIdStr = await SharedPrefs.getGuardsTypeId();
          final guardsTypeId = int.tryParse(guardsTypeIdStr ?? '0') ?? 0;
          final restored = saved.toUserProfileModel(
            guardsTypeId: guardsTypeId,
            clientId: 0,
            guardCode: '',
          );
          Get.find<UserProfileController>().setUserData(restored);
          userData = restored;
        }
        final token = await SharedPrefs.getAccessToken();
        if (token != null && token.isNotEmpty) {
          ApiService.setToken = token;
        }
      }

      if (userData == null) {
        errorMessage.value = 'Session not found. Please sign in again.';
        return;
      }

      final list = await _repo.getAttendanceHistory(
        organizationId: userData.organizationId,
        branchId: userData.branchId,
        usersProfileId: userData.usersProfileId,
      );
      attendanceHistory.assignAll(list);
    } catch (e) {
      errorMessage.value =
          e.toString().replaceAll('Exception: ', '').trim();
    } finally {
      isLoading.value = false;
    }
  }
}
