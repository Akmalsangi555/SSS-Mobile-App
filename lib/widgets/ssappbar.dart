import 'package:flutter/material.dart';
import 'package:sssmobileapp/view/notification/notification_view.dart';

// AppBar ssAppBar(String titleOfPage, BuildContext context) {
//   return AppBar(
//     leadingWidth: 70,
//     title: Text(titleOfPage),
//     actions: [
//       IconButton(
//           onPressed: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (_) => NotificationView()));
//           },
//           icon: Icon(Icons.notifications)),
//       // IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
//     ],
//   );
// }

AppBar ssAppBar(String titleOfPage, BuildContext context) {
  bool isNavigating = false;

  return AppBar(
    leadingWidth: 70,
    title: Text(titleOfPage),
    actions: [
      IconButton(
        onPressed: () async {
          if (!isNavigating) {
            isNavigating = true;
            await Navigator.push(context,
              MaterialPageRoute(builder: (_) => const NotificationView()),
            );
            // Reset after navigation completes
            Future.delayed(const Duration(milliseconds: 500), () {
              isNavigating = false;
            });
          }
        },
        icon: const Icon(Icons.notifications),
      ),
    ],
  );
}
