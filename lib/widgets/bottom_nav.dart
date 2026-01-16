import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/view/attendance/attendance_view.dart';
import 'package:sssmobileapp/view/home/dashboard_view.dart';
import 'package:sssmobileapp/view/menu/menu_veiw.dart';
import 'package:sssmobileapp/view/messages/messages_view.dart';
import 'package:sssmobileapp/view/setting/setting_view.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({
    super.key,
  });
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: navItems[selectedIndex].page,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    // height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: SafeArea(
                      top: false,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: navItems.map((item) {
                          Color color = selectedIndex == navItems.indexOf(item)
                              ? AppTheme.backgroundColor
                              : AppTheme.primaryTextColor;
                          return Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = navItems.indexOf(item);
                                  });
                                },
                                child: Container(
                                  color: Colors.white,
                                  child: NavItem(
                                      image: item.image,
                                      title: item.title,
                                      color: color),
                                )),
                          );
                        }).toList(),
                      ),
                    )),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 46),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: AppTheme.backgroundColor,
                  border: Border.all(
                    color: Colors.white,
                    width: 5,
                  ),
                  shape: BoxShape.circle),
              child: Image.asset(
                'assets/images/message_icon.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.image,
    required this.title,
    required this.color,
  });
  final String image;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          image,
          width: 24,
          color: title == 'Messages' ? Colors.white : color,
        ),
        Text(title, style: TextStyle(color: color, fontSize: 12))
      ],
    );
  }
}

class NavItemData {
  final String image;
  final String title;
  final Widget page;
  NavItemData({required this.image, required this.title, required this.page});
}

List<NavItemData> navItems = [
  NavItemData(
      image: 'assets/images/home_icon.png',
      title: 'Home',
      page: DashboardView()),
  NavItemData(
      image: 'assets/images/attendance_icon.png',
      title: 'Attendance',
      page: AttendanceView()),
  NavItemData(
      image: 'assets/images/message_icon.png',
      title: 'Messages',
      page: MessagesView()),
  NavItemData(
      image: 'assets/images/setting_icon.png',
      title: 'Settings',
      page: SettingView()),
  NavItemData(
      image: 'assets/images/more_icon.png', title: 'Menu', page: MenuView()),
];
