import 'package:flutter/material.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';

class ViewPayStubView extends StatefulWidget {
  const ViewPayStubView({super.key});

  @override
  State<ViewPayStubView> createState() => _ViewPayStubViewState();
}

class _ViewPayStubViewState extends State<ViewPayStubView> {
  String? selectedMonth = 'September';

  @override
  Widget build(BuildContext context) {
    return SScaffold(
      appBar: ssAppBar('View Pay Stub', context),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Button
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFA726),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'View Pay Stub',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Salary Summary Title
              Center(
                child: Text(
                  'Salary Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Select Month
              Text(
                'Select Month',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFE5E5E5)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedMonth,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black87,
                    ),
                    items: [
                      'January', 'February', 'March', 'April', 'May', 'June',
                      'July', 'August', 'September', 'October', 'November', 'December'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMonth = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Pay Slip Container
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFE5E5E5)),
                ),
                child: Column(
                  children: [
                    // Logo and Header
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'assets/logo.png', // Add your logo here
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Security Services System',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Pay Slip Statement',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF757575),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Employee Info
                    _buildInfoRow('Guard Name:', 'Jaxson Stark'),
                    SizedBox(height: 10),
                    _buildInfoRow('Client Site:', 'Main Tower NY'),
                    SizedBox(height: 10),
                    _buildInfoRow('Pay Period:', '2025-09'),
                    SizedBox(height: 20),

                    Divider(color: Color(0xFFE5E5E5)),
                    SizedBox(height: 16),

                    // Salary Details
                    _buildPaymentRow('Basic Salary:', '\$1500', false),
                    SizedBox(height: 10),
                    _buildPaymentRow('Overtime Pay:', '\$200', false),
                    SizedBox(height: 10),
                    _buildPaymentRow('Bonuses:', '\$50', false),
                    SizedBox(height: 10),
                    _buildPaymentRow('Deductions:', '-\$100', false),
                    SizedBox(height: 16),

                    Divider(color: Color(0xFFE5E5E5)),
                    SizedBox(height: 16),

                    // Total Net Pay
                    _buildPaymentRow('Total Net Pay:', '\$1650', true),
                  ],
                ),
              ),
              SizedBox(height: 32),

              // Download Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: SSSFilledButton(
                  buttonText: 'Download Pay Slip (PDF)',
                  onPressed: () {
                    // Handle download
                  },
                  bgColor: Color(0xFFFFA726),
                  textColor: Colors.white,
                ),
              ),
              SizedBox(height: 12),

              // Back Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: SSSFilledButton(
                  buttonText: 'Back',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  bgColor: Color(0xFFE0E0E0),
                  textColor: Colors.black87,
                ),
              ),
              SizedBox(height: 16),

              // Footer Text
              Center(
                child: Text(
                  'For detailed pay info, contact HR or site supervisor.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentRow(String label, String value, bool isTotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 14 : 13,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: isTotal ? Color(0xFFFFA726) : Colors.black87,
          ),
        ),
      ],
    );
  }
}