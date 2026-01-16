import 'package:flutter/material.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';

class ViolationReportView extends StatelessWidget {
  const ViolationReportView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> violations = [
      {
        'action': 'Verbal Warning',
        'guard': 'Liam Harper',
        'employee': 'Ethan Carter',
      },
      {
        'action': 'Written Warning',
        'guard': 'Noah Hayes',
        'employee': 'Olivia Bennett',
      },
      {
        'action': 'Suspension',
        'guard': 'Lucas Reed',
        'employee': 'Ava Foster',
      },
    ];

    return SScaffold(
      appBar: ssAppBar('Violation Report', context),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: violations.map((violation) {
            return Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Action: ${violation['action']}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Guard: ${violation['guard']}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF757575),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Employee: ${violation['employee']}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF757575),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xFF757575),
                    size: 24,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}