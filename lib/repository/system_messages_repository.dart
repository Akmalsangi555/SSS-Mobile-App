import 'package:sssmobileapp/api_function.dart';
import 'package:sssmobileapp/model/guard_message_model.dart';
import 'package:sssmobileapp/utils/api_url/app_urls.dart';

class SystemMessagesRepository {
  Future<GuardMessageResponse> sendByGuard(GuardMessageRequest request) async {
    final res = await ApiService.post('SystemMessages/SendByGuard', data: request.toJson());
    if (res.statusCode == 200) {
      final dynamic data = res.data;
      if (data is Map<String, dynamic>) {
        return GuardMessageResponse.fromJson(data);
      }
      return GuardMessageResponse(isSuccess: true, message: data?.toString() ?? '', content: null);
    }
    throw Exception('Failed to send message: ${res.statusCode}');
  }
}
