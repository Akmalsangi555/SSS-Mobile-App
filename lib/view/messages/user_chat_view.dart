import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';

class UserChatView extends StatelessWidget {
  const UserChatView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> messages = [
      {
        'message':
            'Dear Guard, please report to the client site at 9:00 AM sharp tomorrow. Make sure to wear full uniform and carry your ID card.',
        'type': 'received',
        'date': 'Wed 05:03AM',
      },
      {
        'message': 'Yes',
        'type': 'sent',
        'date': null,
      },
      {
        'message':
            'Reminder: Kindly update your attendance daily through the mobile app. Any missed check-ins will not be counted for duty hours.',
        'type': 'received',
        'date': 'Wed 05:03AM',
      },
      {
        'message': 'Thanks!',
        'type': 'sent',
        'date': null,
      },
    ];
    return SScaffold(
        appBar: ssAppBar('Write Message', context),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                              messages[index]['type'] == 'received'
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: messages[index]['type'] == 'received'
                                      ? Color(0xFFF2F1F9)
                                      : AppTheme.backgroundColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                messages[index]['message'],
                                style: TextStyle(
                                    color: messages[index]['type'] == 'received'
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                          ],
                        ),
                        messages[index]['date'] != null
                            ? Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(messages[index]['date']),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type a message',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.backgroundColor,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
