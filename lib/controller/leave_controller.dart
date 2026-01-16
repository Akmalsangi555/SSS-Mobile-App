import 'package:get/get.dart';
import 'package:sssmobileapp/model/leaves_model.dart';

class LeaveController extends GetxController {
  final RxList<LeavesModel> leaves = <LeavesModel>[].obs;

  void setLeaves(List<LeavesModel> newLeaves) {
    leaves.assignAll(newLeaves);
  }
}
