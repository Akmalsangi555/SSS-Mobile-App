import 'package:sssmobileapp/api_function.dart';
import 'package:sssmobileapp/model/attendance_history_model.dart';

class AttendanceRepository {
  AttendanceRepository();

  Future<List<AttendanceHistoryModel>> getAttendanceHistory({
    required int organizationId,
    required int branchId,
    required int usersProfileId,
  }) async {
    final query = {
      'OrganizationId': '$organizationId',
      'BranchId': '$branchId',
      'UsersProfileId': '$usersProfileId',
    };
    final endpoint =
        'MyAttendanceHistory/Details?${Uri(queryParameters: query).query}';

    final res = await ApiService.get(endpoint);

    if (res.statusCode == 200 &&
        res.data != null &&
        res.data['IsSuccess'] == true) {
      final list = (res.data['Content'] as List?) ?? [];
      return list.map((e) => AttendanceHistoryModel.fromJson(e)).toList();
    }
    final msg = (res.data is Map && res.data['Message'] != null)
        ? res.data['Message'].toString()
        : 'Failed to fetch attendance history';
    throw Exception(msg);
  }
}
