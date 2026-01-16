
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../attendance/attendance_view.dart';
import 'package:sssmobileapp/api_function.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';
import 'package:sssmobileapp/component/ClockInOutDialog.dart';
import 'package:sssmobileapp/view/messages/messages_view.dart';
import 'package:sssmobileapp/view/report/incident_report.dart';
import 'package:sssmobileapp/view/menu/myShifts/myShifts.dart';
import 'package:sssmobileapp/utils/local_storage/shared_pref.dart';
import 'package:sssmobileapp/view/menu/applyLeave/applyLeave.dart';
import 'package:sssmobileapp/view/viewPayStub/ViewPayStubView.dart';
import 'package:sssmobileapp/controller/user_profile_controller.dart';
import 'package:sssmobileapp/view/notification/notification_view.dart';
import 'package:sssmobileapp/view/menu/myLeaveBalance/myLeaveBalance.dart';
import 'package:sssmobileapp/view_model/auth_controller/auth_controller.dart';
import 'package:sssmobileapp/view/ViewRespondWriteUp/ViewRespondWriteUpView.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  void _showClockDialog(BuildContext context, bool isClockIn) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ClockInOutDialog(isClockIn: isClockIn);
      },
    );
  }

  Future<void> _restoreUserSession() async {
    try {
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
      }
      final token = await SharedPrefs.getAccessToken();
      if (token != null && token.isNotEmpty) {
        ApiService.setToken = token;
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _restoreUserSession();
    });
    final List<_MenuItem> menus = [
      _MenuItem(
        image: 'assets/images/attendance_history.png',
        title: 'Attendance History',
        buildPage: () => const AttendanceView(),
      ),
      _MenuItem(
        image: 'assets/images/incident_report.png',
        title: 'Incident Report',
        buildPage: () => const IncidentReportView(),
      ),
      _MenuItem(
        image: 'assets/images/messages.png',
        title: 'Messages',
        buildPage: () => const MessagesView(),
      ),
      _MenuItem(
        image: 'assets/images/writes_up.png',
        title: 'Write-Ups',
        buildPage: () => const ViewRespondWriteUpView(),
      ),
      _MenuItem(
        image: 'assets/images/view_pay_sub.png',
        title: 'View Pay Sub',
        buildPage: () => const ViewPayStubView(),
      ),
      _MenuItem(
        image: 'assets/images/my_shifts.png',
        title: 'My Shifts',
        buildPage: () => const MyScheduleShiftsView(),
      ),
      _MenuItem(
        image: 'assets/images/my_petrol.png',
        title: 'My Patrol',
        buildPage: () => const AttendanceView(),
      ),
      _MenuItem(
        image: 'assets/images/apply_leave.png',
        title: 'Apply Leave/Call Out',
        buildPage: () => const ApplyLeaveView(),
      ),
      _MenuItem(
        image: 'assets/images/leave_balance.png',
        title: 'My Leave Balance',
        buildPage: () => const MyLeavesBalanceView(),
      ),
    ];

    final AuthController authController = Get.put(AuthController());

    return SScaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 13.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Obx(() {
              final user = Get.find<UserProfileController>().rxUserData.value;
              final photo = user?.profilePhoto;
              if (photo != null && photo.isNotEmpty) {
                if (photo.startsWith('data:image')) {
                  final idx = photo.indexOf('base64,');
                  final base64Part =
                      idx != -1 ? photo.substring(idx + 7) : photo;
                  final cleaned = base64Part.startsWith('/')
                      ? base64Part.substring(1)
                      : base64Part;
                  try {
                    final bytes = base64Decode(cleaned);
                    return Image.memory(bytes,
                        width: 57, height: 57, fit: BoxFit.cover);
                  } catch (_) {
                    return Image.asset('assets/images/user_profile.png',
                        width: 57, height: 57, fit: BoxFit.cover);
                  }
                } else {
                  return Image.network(photo,
                      width: 57,
                      height: 57,
                      fit: BoxFit.cover, errorBuilder: (_, __, ___) {
                    return Image.asset('assets/images/user_profile.png',
                        width: 57, height: 57, fit: BoxFit.cover);
                  });
                }
              }
              return Image.asset('assets/images/user_profile.png',
                  width: 57, height: 57, fit: BoxFit.cover);
            }),
          ),
        ),
        title: Obx(() {
          final user = Get.find<UserProfileController>().rxUserData.value;
          String name = 'User';
          if (user != null) {
            if (user.fullName.trim().isNotEmpty) {
              name = user.fullName;
            } else if (user.guardName.trim().isNotEmpty) {
              name = user.guardName;
            }
          }
          return Text('Hi, $name');
        }),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => NotificationView()));
              },
              icon: Icon(Icons.notifications)),
          IconButton(
            onPressed: () => authController.showLogoutDialog(context),
            icon: const Icon(Icons.logout_outlined),
            color: Colors.white,
          ),
          // IconButton(onPressed: () {
          //
          // }, icon: Icon(Icons.logout),
          // ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                'Sat',
                                style: TextStyle(fontSize: 20),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '07:00 - 19:00',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  'Main Tower Site',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '123 main street NY, USA',
                                  style: Theme.of(context).textTheme.bodySmall,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Clocked In: 07:09',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 31,
                                child: SSSFilledButton(
                                  buttonText: 'Clock In',
                                  onPressed: () {
                                    _showClockDialog(context, true);
                                  },
                                  bgColor: AppTheme.primaryBGButtonColor,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Clocked Out: 15:19',
                                style: Theme.of(context).textTheme.bodySmall,
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
                                    _showClockDialog(context, false);
                                  },
                                  textColor: AppTheme.primaryTextColor,
                                  bgColor: AppTheme.secondaryBGButtonColor,
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
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: menus
                    .map((item) => _DashboardMenuTile(item: item))
                    .toList(),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  final String image;
  final String title;
  final Widget Function() buildPage;
  const _MenuItem({
    required this.image,
    required this.title,
    required this.buildPage,
  });
}

class _DashboardMenuTile extends StatelessWidget {
  final _MenuItem item;
  const _DashboardMenuTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => item.buildPage()),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3 - 20,
        height: 107,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFF4F4F4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(item.image, height: 54),
            Text(
              item.title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
