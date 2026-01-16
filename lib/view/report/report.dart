import 'package:flutter/material.dart';
import 'package:sssmobileapp/view/report/incident_report.dart';
import 'package:sssmobileapp/view/report/violation_report.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SScaffold(
      appBar: ssAppBar('Reports', context),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildReportOption(
              context,
              'Incident Sheet Report',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IncidentReportView(),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            _buildReportOption(
              context,
              'Employee Violation Report',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViolationReportView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportOption(BuildContext context, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}