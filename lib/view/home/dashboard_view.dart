// import 'package:flutter/material.dart';
// import 'package:sssmobileapp/config/style.dart';
// import 'package:sssmobileapp/widgets/filled_button.dart';
// import 'package:sssmobileapp/widgets/s_scaffold.dart';
// import 'package:sssmobileapp/component/ClockInOutDialog.dart';

// class DashboardView extends StatelessWidget {
//   const DashboardView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, String>> menus = [
//       {
//         'images': 'assets/images/attendance_history.png',
//         'title': 'Attendance History',
//       },
//       {
//         'images': 'assets/images/incident_report.png',
//         'title': 'Incident Report',
//       },
//       {
//         'images': 'assets/images/messages.png',
//         'title': 'Messages',
//       },
//       {
//         'images': 'assets/images/writes_up.png',
//         'title': 'Write-Ups',
//       },
//       {
//         'images': 'assets/images/view_pay_sub.png',
//         'title': 'View Pay Sub',
//       },
//       {
//         'images': 'assets/images/my_shifts.png',
//         'title': 'My Shifts',
//       },
//       {
//         'images': 'assets/images/my_petrol.png',
//         'title': 'My Petrol',
//       },
//       {
//         'images': 'assets/images/apply_leave.png',
//         'title': 'Apply Leave/Call Out',
//       },
//       {
//         'images': 'assets/images/leave_balance.png',
//         'title': 'My Leave Balance'
//       },
//     ];
//     return SScaffold(
//       appBar: AppBar(
//         leadingWidth: 70,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 13.0),
//           child: ClipRRect(
//               borderRadius: BorderRadius.circular(100),
//               child: Image.asset(
//                 'assets/images/user_profile.png',
//                 width: 57,
//                 height: 57,
//                 fit: BoxFit.cover,
//               )),
//         ),
//         title: Text('Hi, Jaxson'),
//         actions: [
//           IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
//           IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
//         ],
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: AppTheme.notificationBackgroundColor,
//                 ),
//                 child: RichText(
//                     text: TextSpan(children: [
//                   TextSpan(
//                       text: 'Note:',
//                       style: TextStyle(fontWeight: FontWeight.bold)),
//                   TextSpan(
//                       text:
//                           'Please select your shift before clocking in. Otherwise, time will be counted without a shift.')
//                 ], style: TextStyle(color: AppTheme.primaryTextColor))),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Color(0xFFF4F4F4),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Clock In/Out',
//                       style:
//                           TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(
//                       height: 4,
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         color: Colors.white,
//                       ),
//                       child: Row(
//                         children: [
//                           Column(
//                             children: [
//                               Text(
//                                 '25',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 20),
//                               ),
//                               Text(
//                                 'Sat',
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 56,
//                             child: VerticalDivider(
//                               thickness: 1,
//                               width: 32,
//                               color: AppTheme.secondaryColor,
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   '07:00 - 19:00',
//                                   style: Theme.of(context).textTheme.bodySmall,
//                                 ),
//                                 Text(
//                                   'Main Tower Site',
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   '123 main street NY, USA',
//                                   style: Theme.of(context).textTheme.bodySmall,
//                                 )
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 8,
//                           ),
//                           Image.asset(
//                             'assets/images/checkboxes.png',
//                             width: 15,
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 16,
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Clocked In: 07:09',
//                                 style: Theme.of(context).textTheme.bodySmall,
//                               ),
//                               SizedBox(
//                                 height: 4,
//                               ),
//                               SizedBox(
//                                 width: double.infinity,
//                                 height: 31,
//                                 child: SSSFilledButton(
//                                   buttonText: 'Clock In',
//                                   onPressed: () {
//                                      _showClockDialog(context, true);
//                                   },
//                                   bgColor: AppTheme.primaryBGButtonColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: 16,
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Clocked Out: 15:19',
//                                 style: Theme.of(context).textTheme.bodySmall,
//                               ),
//                               SizedBox(
//                                 height: 4,
//                               ),
//                               SizedBox(
//                                 width: double.infinity,
//                                 height: 31,
//                                 child: SSSFilledButton(
//                                   buttonText: 'Clock Out',
//                                   onPressed: () {
//                                      _showClockDialog(context, false);
//                                   },
//                                   textColor: AppTheme.primaryTextColor,
//                                   bgColor: AppTheme.secondaryBGButtonColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               Wrap(
//                   spacing: 8,
//                   runSpacing: 8,
//                   children: menus
//                       .map((e) => Container(
//                             width: MediaQuery.of(context).size.width / 3 - 20,
//                             height: 107,
//                             padding: EdgeInsets.all(4),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               color: Color(0xFFF4F4F4),
//                             ),
//                             child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Image.asset(
//                                     e['images'].toString(),
//                                     height: 54,
//                                   ),
//                                   Text(
//                                     e['title'].toString(),
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold),
//                                     textAlign: TextAlign.center,
//                                   )
//                                 ]),
//                           ))
//                       .toList()),
//               SizedBox(
//                 height: 30,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/view/auth/signin.dart';
import 'package:sssmobileapp/utils/custom_text.dart';
import 'package:sssmobileapp/view_model/auth_controller/auth_controller.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';
import 'package:sssmobileapp/component/ClockInOutDialog.dart';
import 'package:sssmobileapp/view/messages/messages_view.dart';
import 'package:sssmobileapp/view/report/incident_report.dart';
import 'package:sssmobileapp/utils/local_storage/shared_pref.dart';
import 'package:sssmobileapp/view/menu/applyLeave/applyLeave.dart';
import 'package:sssmobileapp/view/viewPayStub/ViewPayStubView.dart';
import 'package:sssmobileapp/view/notification/notification_view.dart';
import 'package:sssmobileapp/view/menu/myLeaveBalance/myLeaveBalance.dart';
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

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> menus = [
      {
        'images': 'assets/images/attendance_history.png',
        'title': 'Attendance History',
      },
      {
        'images': 'assets/images/incident_report.png',
        'title': 'Incident Report',
      },
      {
        'images': 'assets/images/messages.png',
        'title': 'Messages',
      },
      {
        'images': 'assets/images/writes_up.png',
        'title': 'Write-Ups',
      },
      { 
        'images': 'assets/images/view_pay_sub.png',
        'title': 'View Pay Sub',
      },
      {
        'images': 'assets/images/my_shifts.png',
        'title': 'My Shifts',
      },
      {
        'images': 'assets/images/my_petrol.png',
        'title': 'My Petrol',
      },
      {
        'images': 'assets/images/apply_leave.png',
        'title': 'Apply Leave/Call Out',
      },
      {
        'images': 'assets/images/leave_balance.png',
        'title': 'My Leave Balance'
      },
    ];

    // // Get user data from SharedPreferences
    // final String userName = SharedPrefs.getUserName() ?? 'User';
    // final String? userPhotoUrl = SharedPrefs.getProfilePhoto();

    final AuthController authController = Get.find<AuthController>();

    return SScaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 13.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/user_profile.png',
                width: 57,
                height: 57,
                fit: BoxFit.cover,
              )),
        ),
        title: Text('Hi, Jaxson'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                context, MaterialPageRoute(builder: (_) => NotificationView()));
          }, icon: Icon(Icons.notifications)),
          IconButton(
            onPressed: () => authController.showLogoutDialog(context),
            icon: const Icon(Icons.logout_outlined),
            color: Colors.white,),
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
                      .map((e) => GestureDetector(
                        onTap: (){
                          String title=e['title'].toString();
                          if (title  == 'My Leave Balance') {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyLeavesBalanceView(),
        ),
      );
    } 
     else if (title == 'Apply Leave/Call Out') {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ApplyLeaveView(),
        ),
      );
    } 
     else if (title == 'Messages') {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MessagesView(),
        ),
      );
    } 

      else if (title == 'Incident Report') {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const IncidentReportView(),
        ),
      );
    } 

        else if (title == 'View Pay Sub') {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ViewPayStubView(),
        ),
      );
    } 

      else if (title == 'Write-Ups') {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ViewRespondWriteUpView(),
        ),
      );
    }  
    

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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      e['images'].toString(),
                                      height: 54,
                                    ),
                                    Text(
                                      e['title'].toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                            ),
                      ))
                      .toList()),
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
