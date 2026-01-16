import 'package:flutter/material.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';

class MyScheduleShiftsView extends StatelessWidget {
  const MyScheduleShiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SScaffold(
      appBar: ssAppBar('My Schedule/Shifts', context),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Today Shift Section
              Text(
                'Today Shift',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12),
              _buildShiftCard(
                borderColor: Color(0xFFFFA726),
                clientName: 'Meezan Bank',
                clientLocation: 'NY Branch Main Tower',
                locationAddress: 'NY Branch Main Tower, 123 5th Avenue, New York, NY 10001, USA',
                fromDate: '28/09/2025',
                toDate: '28/09/2025',
                shift: 'Morning',
                startTime: '07:00:00',
                endTime: '19:00:00',
              ),
              SizedBox(height: 24),

              // Upcoming Shifts Section
              Text(
                'Upcoming Shifts',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12),
              _buildShiftCard(
                borderColor: Color(0xFF4CAF50),
                clientName: 'Swiftex',
                clientLocation: 'Construction Site Main Door',
                locationAddress: 'NY Branch Main Tower, 123 5th Avenue, New York, NY 10001, USA',
                fromDate: '29/09/2025',
                toDate: '29/09/2025',
                shift: 'Morning',
                startTime: '07:00:00',
                endTime: '19:00:00',
              ),
              SizedBox(height: 16),
              _buildShiftCard(
                borderColor: Color(0xFF424242),
                clientName: 'World Bank',
                clientLocation: 'Bank Avenue 2nd Floor',
                locationAddress: 'NY Branch Main Tower, 123 5th Avenue, New York, NY 10001, USA',
                fromDate: '30/09/2025',
                toDate: '30/09/2025',
                shift: 'Morning',
                startTime: '07:00:00',
                endTime: '19:00:00',
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShiftCard({
    required Color borderColor,
    required String clientName,
    required String clientLocation,
    required String locationAddress,
    required String fromDate,
    required String toDate,
    required String shift,
    required String startTime,
    required String endTime,
  }) {
    return Container(
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
      child: Row(
        children: [
          // Colored left border
          Container(
            width: 8,
            height: 200,
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildRow('Client Name:', clientName),
                  SizedBox(height: 8),
                  _buildRow('Client Location:', clientLocation),
                  SizedBox(height: 8),
                  _buildRow('Location Address', locationAddress, isAddress: true),
                  SizedBox(height: 8),
                  _buildRow('From Date:', fromDate),
                  SizedBox(height: 8),
                  _buildRow('To Date:', toDate),
                  SizedBox(height: 8),
                  _buildRow('Shift:', shift),
                  SizedBox(height: 8),
                  _buildRow('Start Time:', startTime),
                  SizedBox(height: 8),
                  _buildRow('End Time:', endTime),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isAddress = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}