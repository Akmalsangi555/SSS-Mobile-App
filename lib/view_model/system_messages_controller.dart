import 'package:get/get.dart';
import 'package:sssmobileapp/controller/user_profile_controller.dart';
import 'package:sssmobileapp/model/guard_message_model.dart';
import 'package:sssmobileapp/repository/system_messages_repository.dart';
import 'package:sssmobileapp/utils/local_storage/shared_pref.dart';

class SystemMessagesController extends GetxController {
  final SystemMessagesRepository _repo = SystemMessagesRepository();
  final RxBool isSending = false.obs;
  final RxString errorMessage = ''.obs;
  Future<GuardMessageResponse?> sendMessage(String message) async {
    if (message.trim().isEmpty) return null;
    try {
      isSending.value = true;
      errorMessage.value = '';
      var user = Get.find<UserProfileController>().userData;
      if (user == null) {
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
          user = restored;
        }
      }
      if (user == null) {
        errorMessage.value = 'User session not found';
        return null;
      }
      final req = GuardMessageRequest(
        createdByUserId: user.usersProfileId,
        organizationId: user.organizationId,
        branchId: user.branchId,
        guardsTypeId: user.guardsTypeId,
        clientsId: user.clientId,
        guardId: user.guardsId,
        alertMessage: message,
      );
      final res = await _repo.sendByGuard(req);
      print('IsSuccess: ${res.isSuccess}');
      print('Message: ${res.message}');
      return res;
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '').trim();
      print('SendByGuard Error: $e');
      return null;
    } finally {
      isSending.value = false;
    }
  }
}
