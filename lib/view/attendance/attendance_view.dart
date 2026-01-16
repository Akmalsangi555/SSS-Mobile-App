import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:sssmobileapp/api_function.dart';
import 'package:sssmobileapp/component/ClockInOutDialog.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/model/attendance_history_model.dart';
import 'package:sssmobileapp/model/auth_models/login_user_model.dart';
import 'package:sssmobileapp/controller/user_profile_controller.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  void showClockDialog(BuildContext context, bool isClockIn) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ClockInOutDialog(isClockIn: isClockIn);
      },
    );
  }

  List<AttendanceHistoryModel> attendanceHistory = [];
  bool loadData = true;
  getData() async {
    LoginUserModel userData = Get.find<UserProfileController>().userData!;
    print(
        'MyAttendanceHistory/Details?OrganizationId=${userData.organizationId}&BranchId=${userData.branchId}&UsersProfileId=${userData.usersProfileId}');

    var res = await ApiService.get(
        'MyAttendanceHistory/Details?OrganizationId=${userData.organizationId}&BranchId=${userData.branchId}&UsersProfileId=${userData.usersProfileId}');

    if (res.statusCode == 200 && res.data['IsSuccess']) {
      var data = res.data['Content'] as List;
      attendanceHistory =
          data.map((e) => AttendanceHistoryModel.fromJson(e)).toList();
      // setState(() {});
    } else {
      ApiService.showDialogOnApi(context, res.data['Message']);
    }
    setState(() {
      loadData = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SScaffold(
        appBar: ssAppBar('Clock In/Out', context),
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppTheme.notificationBackgroundColor,
                        ),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Note:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  'Please select your shift before clocking in. Otherwise, time will be counted without a shift.')
                        ], style: TextStyle(color: AppTheme.primaryTextColor))),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFFF4F4F4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Clock In/Out',
                              style: TextStyle(
                                  color: AppTheme.backgroundColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '25',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        'Sat',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 56,
                                    child: VerticalDivider(
                                      thickness: 1,
                                      width: 32,
                                      color: AppTheme.secondaryColor,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '07:00 - 19:00',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        Text(
                                          'Main Tower Site',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '123 main street NY, USA',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Image.asset(
                                    'assets/images/checkboxes.png',
                                    width: 15,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Clocked In: 07:09',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 31,
                                        child: SSSFilledButton(
                                          buttonText: 'Check In',
                                          onPressed: () {
                                            showClockDialog(context, true);
                                          },
                                          bgColor:
                                              AppTheme.primaryBGButtonColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Clocked Out: 15:19',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 31,
                                        child: SSSFilledButton(
                                          buttonText: 'Clock Out',
                                          onPressed: () {
                                            showClockDialog(context, false);
                                          },
                                          textColor: AppTheme.primaryTextColor,
                                          bgColor:
                                              AppTheme.secondaryBGButtonColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Attendance History',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      loadData
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : attendanceHistory.isEmpty
                              ? Center(child: CircularProgressIndicator())
                              : Column(
                                  children: attendanceHistory
                                      .map((e) => Container(
                                            margin: EdgeInsets.only(bottom: 16),
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withValues(alpha: 0.2),
                                                  spreadRadius: 5,
                                                  blurRadius: 6,
                                                  offset: const Offset(0, 3),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      DateFormat('dd').format(
                                                          e.attendanceDate),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    Text(
                                                      DateFormat('EEE').format(e
                                                          .attendanceDate), //'Sat',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 56,
                                                  child: VerticalDivider(
                                                    thickness: 1,
                                                    width: 32,
                                                    color: AppTheme
                                                        .primaryBGButtonColor,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${e.attendanceDetails.first.checkInTime.split(' ').last} - ${e.attendanceDetails.first.checkOutTime.split(' ').last}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                      Text(
                                                        // e.attendanceDetails.first
                                                        //         .locationIp ??
                                                        'Main Tower Site',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        // e.attendanceDetails.first
                                                        //         .latitude ??
                                                        '123 main street NY, USA',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'Clocked In: ${e.attendanceDetails.first.checkInTime.split(' ').last}',
                                                      style: TextStyle(
                                                          color: AppTheme
                                                              .secondaryColor,
                                                          fontSize: 10),
                                                    ),
                                                    Text(
                                                      'Clocked Out: ${e.attendanceDetails.first.checkOutTime.split(' ').last}',
                                                      style: TextStyle(
                                                          color: AppTheme
                                                              .secondaryColor,
                                                          fontSize: 10),
                                                    ),
                                                    Text(
                                                      'Total Hours: ${e.attendanceDetails.first.hoursWorked}',
                                                      style: TextStyle(
                                                          color: AppTheme
                                                              .secondaryColor,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ))
                                      .toList())
                    ]))));
  }
}
