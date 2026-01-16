import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/view/messages/group_chat_view.dart';
import 'package:sssmobileapp/view/messages/new_message.dart';
import 'package:sssmobileapp/view/messages/user_chat_view.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  List<String> tabs = ['All', 'Chats', 'Groups'];
  String selectedTab = 'All';

  @override
  Widget build(BuildContext context) {
    return SScaffold(
      appBar: ssAppBar('Message', context),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Row(
                  spacing: 4,
                  children: tabs.map((e) {
                    bool isSelected = selectedTab == e;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = e;
                        });
                      },
                      child: Container(
                        height: 29,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isSelected
                                ? AppTheme.backgroundColor
                                : Color(0xFFEFEFEF)),
                        child: Center(
                          child: Text(
                            e,
                            style: TextStyle(
                                fontSize: 10,
                                color: isSelected
                                    ? Colors.white
                                    : AppTheme.primaryTextColor),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Spacer(),
                SizedBox(
                    height: 29,
                    width: 142,
                    child: SSSFilledButton(
                        buttonText: '+ New Message',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => NewMessageView()));
                        }))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: 'Search message',
              ),
            ),
          ),
          Column(
            children: [
              Column(
                children: List.generate(2, (index) {
                  return GroupMessageTile(
                      bgColor: index.isEven
                          ? AppTheme.backgroundColor
                          : AppTheme.primaryBGButtonColor,
                      image: 'assets/images/group_message.png',
                      title: 'Group ${index + 1}',
                      message: 'Message ${index + 1}');
                }),
              ),
              Column(
                children: List.generate(2, (index) {
                  return ChatMessageTile(
                      date: index == 0 ? 'Today' : ' 12/09',
                      role: index.isEven ? 'Employee' : 'Manager',
                      image: 'assets/images/chat_message.jpg',
                      title: 'Chat ${index + 1}',
                      message: 'Message ${index + 1}');
                }),
              )
            ],
          )
        ],
      ),
    );
  }
}

class GroupMessageTile extends StatelessWidget {
  const GroupMessageTile(
      {super.key,
      required this.bgColor,
      required this.image,
      required this.title,
      required this.message});
  final Color bgColor;
  final String image;
  final String title;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => GroupChatView()));
        },
        child: ClipRRect(
          // borderRadius: BorderRadiusGeometry.circular(16),
          child: Dismissible(
            key: UniqueKey(),
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(color: Colors.red),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/delete_icon.png',
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/delete_icon.png',
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              image,
                              width: 37,
                              height: 37,
                              fit: BoxFit.cover,
                            )),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryTextColor),
                                ),
                                Text(
                                  message,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.secondaryColor),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Transform.rotate(
                    angle: 0.5 * 3.1416,
                    child: Text('Group',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatMessageTile extends StatelessWidget {
  const ChatMessageTile(
      {super.key,
      required this.image,
      required this.title,
      required this.message,
      required this.date,
      required this.role});
  final String image;
  final String title;
  final String message;
  final String date;
  final String role;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
      width: double.infinity - 40,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => UserChatView()));
        },
        child: ClipRRect(
          // borderRadius: BorderRadiusGeometry.circular(16),
          child: Dismissible(
            confirmDismiss: (direction) async {
              return showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Delete Message',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryTextColor),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Are you sure you want to delete this chat?\nThis action cannot be undone.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.primaryTextColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 38,
                              child: SSSFilledButton(
                                buttonText: 'Cancel',
                                onPressed: () => Navigator.pop(context, false),
                                bgColor: Color(0xFFDDDDDD),
                                textColor: AppTheme.primaryTextColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 38,
                              child: SSSFilledButton(
                                buttonText: 'Yes, Delete',
                                onPressed: () => Navigator.pop(context, true),
                                bgColor: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                      // actions: [
                      //   TextButton(
                      //     onPressed: () => Navigator.pop(context, false),
                      //     child: Text('Cancel'),
                      //   ),
                      //   TextButton(
                      //     onPressed: () => Navigator.pop(context, true),
                      //     child: Text('Delete'),
                      //   ),
                      // ],
                      );
                },
              );
            },
            key: UniqueKey(),
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(color: Colors.red),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/delete_icon.png',
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/delete_icon.png',
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        image,
                        width: 37,
                        height: 37,
                        fit: BoxFit.cover,
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryTextColor),
                          ),
                          Text(
                            message,
                            style: TextStyle(
                                fontSize: 12, color: AppTheme.secondaryColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(date,
                          style: TextStyle(
                              color: AppTheme.secondaryColor, fontSize: 12)),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(role,
                              style: TextStyle(
                                  color: AppTheme.secondaryColor, fontSize: 8)))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
