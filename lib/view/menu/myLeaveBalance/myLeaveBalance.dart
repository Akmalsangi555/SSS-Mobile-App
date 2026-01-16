import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sssmobileapp/api_function.dart';
import 'package:sssmobileapp/model/leaves_model.dart';
import 'package:sssmobileapp/model/auth_models/login_user_model.dart';
import 'package:sssmobileapp/controller/leave_controller.dart';
import 'package:sssmobileapp/controller/user_profile_controller.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';

class MyLeavesBalanceView extends StatefulWidget {
  const MyLeavesBalanceView({super.key});

  @override
  State<MyLeavesBalanceView> createState() => _MyLeavesBalanceViewState();
}

class _MyLeavesBalanceViewState extends State<MyLeavesBalanceView> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getLeaveData();
  }

  bool loadData = true;

  getLeaveData() async {
    try {
      LoginUserModel profileModel =
          Get.find<UserProfileController>().userData!;
      var res = await ApiService.get(
          'LeaveBalance/MyLeaves?OrganizationID=${profileModel.organizationId}&BranchID=${profileModel.branchId}&loginUserId=${profileModel.usersProfileId}');
      print(res.data);
      if (res.statusCode == 200 && res.data['IsSuccess'] == true) {
        var data = res.data['Content'] as List;
        Get.find<LeaveController>()
            .setLeaves(data.map((e) => LeavesModel.fromJson(e)).toList());
      } else {
        ApiService.showDialogOnApi(context, res.data['Message']);
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        loadData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final leaveCtrl = Get.find<LeaveController>();
    // List<LeavesModel> leavesData = leaveCtrl.leaves;
    // final List<Map<String, dynamic>> leaves = [
    //   {
    //     'name': 'Jaxson Stark',
    //     'leaveType': 'Sick Leave',
    //     'fromDate': '27/09/2025',
    //     'toDate': '28/09/2025',
    //     'reason': 'I have bad fever...',
    //     'status': 'Pending',
    //     'statusColor': Color(0xFFFF5252),
    //   },
    //   {
    //     'name': 'Jaxson Stark',
    //     'leaveType': 'Sick Leave',
    //     'fromDate': '27/09/2025',
    //     'toDate': '28/09/2025',
    //     'reason': 'I have bad fever...',
    //     'status': 'Approved',
    //     'statusColor': Color(0xFF4CAF50),
    //   },
    // ];

    return SScaffold(
      appBar: ssAppBar('My Leaves', context),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leave Balance Card
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Leave balance',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildBalanceItem(
                                'Total Leave', '${leaveCtrl.leaves.length}'),
                            _buildBalanceItem('Taken', '05'),
                            _buildBalanceItem('Remaining', '23'),
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(height: 20),
              loadData
                  ? Center(child: CircularProgressIndicator())
                  : Obx(() {
                      final data = leaveCtrl.leaves;
                      return Column(
                          children: data
                              .map((leave) => _buildLeaveCard(leave))
                              .toList());
                    }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLeaveCard(LeavesModel leave) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildLeaveRow('Name:', leave.guardName),
          SizedBox(height: 12),
          _buildLeaveRow('Leave Type:', leave.leaveTypeName),
          SizedBox(height: 12),
          _buildLeaveRow('From Date:', leave.fromDate),
          SizedBox(height: 12),
          _buildLeaveRow('To Date:', leave.toDate),
          SizedBox(height: 12),
          _buildLeaveRow('Reason', leave.reasonOfLeave),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  // leave.leaveStatusId.toString(),
                  'Approved',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
