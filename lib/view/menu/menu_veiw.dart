// import 'package:flutter/material.dart';
// import 'package:sssmobileapp/config/style.dart';
// import 'package:sssmobileapp/widgets/ssappbar.dart';
// import 'package:sssmobileapp/widgets/s_scaffold.dart';

// class MenuView extends StatelessWidget {
//   const MenuView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> menuOptions = [
//       {'title': 'Home Dashboard', 'route': '/home'},
//       {'title': 'My Shifts / Schedule', 'route': '/profile'},
//       {'title': 'Apply Leave / Call Out', 'route': '/profile'},
//       {'title': 'Reports', 'route': '/profile'},
//       {'title': 'View Pay Stub', 'route': '/profile'},
//       {'title': 'View & Respond to Write-Ups', 'route': '/profile'},
//       {'title': 'Messages / Chat', 'route': '/profile'},
//       {'title': 'Shift Proofs', 'route': '/profile'},
//       {'title': 'Uploads', 'route': '/profile'},
//     ];
//     return SScaffold(
//       appBar: ssAppBar('Menu', context),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(bottom: 16),
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.shade200,
//                       blurRadius: 4,
//                     )
//                   ],
//                   color: Colors.white,
//                 ),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                         backgroundImage:
//                             AssetImage('assets/images/user_m_profile.png')),
//                     SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Jaxson Stark',
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             'guard@guard.com',
//                             style: TextStyle(color: AppTheme.secondaryColor),
//                           ),
//                         ],
//                       ),
//                     ),
//                     IconButton(
//                         onPressed: () {},
//                         icon: Icon(Icons.keyboard_arrow_right))
//                   ],
//                 ),
//               ),
//               Column(
//                 children: menuOptions.map((e) {
//                   return Container(
//                     width: double.infinity,
//                     margin: EdgeInsets.only(bottom: 16),
//                     padding: EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.shade200,
//                           blurRadius: 4,
//                         )
//                       ],
//                       color: Colors.white,
//                     ),
//                     child: Text(
//                       e['title'],
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   );
//                 }).toList(),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/view/UploadDocument/UploadDocumentView.dart';
import 'package:sssmobileapp/view/ViewRespondWriteUp/ViewRespondWriteUpView.dart';
import 'package:sssmobileapp/view/menu/CallOutView/callOutView.dart';
import 'package:sssmobileapp/view/menu/myShifts/myShifts.dart';
import 'package:sssmobileapp/view/menu/shiftProofs/shiftProofs.dart';
import 'package:sssmobileapp/view/messages/messages_view.dart';
import 'package:sssmobileapp/view/report/report.dart';
import 'package:sssmobileapp/view/viewPayStub/ViewPayStubView.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

 
  void _onMenuItemTap(BuildContext context, String title, String route) {
    if (title == 'Apply Leave / Call Out') {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CallOutView(),
        ),
      );
    } 
     else if (title == 'Shift Proofs') {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ShiftProofsView(),
        ),
      );
    } 

      else if (title == 'Reports') {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ReportsView(),
        ),
      );
    } 
    
      else if (title == 'Messages / Chat') {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MessagesView(),
        ),
      );
    } 

    else if (title == 'My Shifts / Schedule') {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyScheduleShiftsView(),
        ),
      );
    }

      else if (title == 'View Pay Stub') {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ViewPayStubView(),
        ),
      );
    } 

      else if (title == 'View & Respond to Write-Ups') {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ViewRespondWriteUpView(),
        ),
      );
    }  

     else if (title == 'Uploads') {
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UploadDocumentView(),
        ),
      );
    }  
    
    else if (route.isNotEmpty) {
      // Use named route for other items (original logic)
      Navigator.pushNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menuOptions = [
      {'title': 'Home Dashboard', 'route': '/home'},
      {'title': 'My Shifts / Schedule', 'route': '/profile'},
      // Keep the route, but the navigation function will ignore it for this item
      {'title': 'Apply Leave / Call Out', 'route': '/profile'}, 
      {'title': 'Reports', 'route': '/profile'},
      {'title': 'View Pay Stub', 'route': '/profile'},
      {'title': 'View & Respond to Write-Ups', 'route': '/profile'},
      {'title': 'Messages / Chat', 'route': '/profile'},
      {'title': 'Shift Proofs', 'route': '/profile'},
      {'title': 'Uploads', 'route': '/profile'},
    ];
    
    return SScaffold(
      appBar: ssAppBar('Menu', context),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
        
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 4,
                    )
                  ],
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/user_m_profile.png')),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Jaxson Stark',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'guard@guard.com',
                            style: TextStyle(color: AppTheme.secondaryColor),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.keyboard_arrow_right))
                  ],
                ),
              ),
              // Menu Options List (Modified Tapping)
              Column(
                children: menuOptions.map((option) {
                  return InkWell(
                    // 3. 🎯 Pass both title and route to the handler
                    onTap: () => _onMenuItemTap(context, option['title'], option['route']),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 4,
                          )
                        ],
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              option['title'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}