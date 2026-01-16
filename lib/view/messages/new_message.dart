import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/view/messages/user_chat_view.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';

class NewMessageView extends StatefulWidget {
  const NewMessageView({super.key});

  @override
  State<NewMessageView> createState() => _NewMessageViewState();
}

class _NewMessageViewState extends State<NewMessageView> {
  @override
  Widget build(BuildContext context) {
    return SScaffold(
      appBar: ssAppBar('Message', context),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type',
                style: TextStyle(
                    color: AppTheme.primaryTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 8,
            ),
            DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: 'e.g. Staff',
                ),
                items: [
                  DropdownMenuItem(
                    child: Text('Staff'),
                    value: 'Staff',
                  ),
                  DropdownMenuItem(
                    child: Text('Manager'),
                    value: 'Manager',
                  ),
                  DropdownMenuItem(
                    child: Text('Supervisor'),
                    value: 'Supervisor',
                  ),
                ],
                onChanged: (v) {}),
            SizedBox(
              height: 24,
            ),
            Text('User',
                style: TextStyle(
                    color: AppTheme.primaryTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 8,
            ),
            DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: 'e.g. John Doe',
                ),
                items: [
                  DropdownMenuItem(
                    child: Text('John Doe'),
                    value: 'John Doe',
                  ),
                  DropdownMenuItem(
                    child: Text('Micheal Smith'),
                    value: 'Micheal Smith',
                  ),
                ],
                onChanged: (v) {}),
            SizedBox(
              height: 24,
            ),
            Text('Message',
                style: TextStyle(
                    color: AppTheme.primaryTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write message here...',
              ),
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
                width: double.infinity,
                child: SSSFilledButton(
                    buttonText: 'Send',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => UserChatView()));
                    })),
          ],
        ),
      ),
    );
  }
}
