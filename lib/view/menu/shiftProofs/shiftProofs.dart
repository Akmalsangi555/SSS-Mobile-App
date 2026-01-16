import 'package:flutter/material.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';

class ShiftProofsView extends StatelessWidget {
  const ShiftProofsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> shiftProofs = [
      {
        'date': '08-Oct-2025',
        'time': '07:01 AM',
        'location': 'Main Tower, NY',
        'remarks': 'Started patrol on time. Weather clear.',
        'status': 'Clock In',
        'statusColor': Color(0xFF00C853),
        'imagePath': 'assets/images/user_profile.png',
      },
      {
        'date': '08-Oct-2025',
        'time': '07:01 AM',
        'location': 'Main Tower, NY',
        'remarks': 'Started patrol on time. Weather clear.',
        'status': 'Clock Out',
        'statusColor': Color(0xFFFF1744),
        'imagePath': 'assets/images/user_profile.png',
      },
      {
        'date': '08-Oct-2025',
        'time': '07:01 AM',
        'location': 'Main Tower, NY',
        'remarks': 'Started patrol on time. Weather clear.',
        'status': 'Clock In',
        'statusColor': Color(0xFF00C853),
        'imagePath': 'assets/images/user_profile.png',
      },
    ];

    return SScaffold(
      appBar: ssAppBar('Shift Proofs', context),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: shiftProofs.map((proof) {
              return Container(
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow('Date:', proof['date']),
                            SizedBox(height: 6),
                            _buildInfoRow('Time:', proof['time']),
                            SizedBox(height: 6),
                            _buildInfoRow('Location:', proof['location']),
                            SizedBox(height: 6),
                            _buildInfoRow('Remarks:', proof['remarks']),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  'Status: ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  proof['status'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: proof['statusColor'],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          proof['imagePath'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: Icon(Icons.person,
                                  size: 50, color: Colors.grey[600]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}