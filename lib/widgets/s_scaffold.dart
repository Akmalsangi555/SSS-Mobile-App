
import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';

class SScaffold extends StatelessWidget {
  const SScaffold(
      {super.key,
        required this.child,
        this.titleOfPage,
        this.appBar,
        this.bottomNavigationBar,
        this.showBackButton = true,
        this.floatingActionButton});
  final Widget child;
  final String? titleOfPage;
  final AppBar? appBar;
  final bool showBackButton;
  final BottomNavigationBar? bottomNavigationBar;
  final FloatingActionButton? floatingActionButton;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: appBar ??
            (titleOfPage != null ?
            AppBar(
              backgroundColor: Colors.transparent,
              title: Text(titleOfPage!),
              leading: showBackButton ?
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.pop(context),
              ) : null,
              automaticallyImplyLeading: showBackButton,
            ) : null),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Container(
          margin: EdgeInsets.only(top: 16),
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Column(
            children: [
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
