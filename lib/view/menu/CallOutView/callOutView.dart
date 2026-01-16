import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';

class CallOutView extends StatefulWidget {
  const CallOutView({super.key});

  @override
  State<CallOutView> createState() => _CallOutViewState();
}

class _CallOutViewState extends State<CallOutView> {
  String? selectedSite;
  String? selectedEmergencyType;
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _openCamera() {
    // Implement camera functionality
  }

  @override
  Widget build(BuildContext context) {
    return SScaffold(
      appBar: ssAppBar('Call Out', context),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Guard Name Field
              _buildLabel('Guard Name'),
              SizedBox(height: 8),
              _buildDisabledField('Auto-filled from login profile'),
              SizedBox(height: 20),

              // Client / Site Name Field
              _buildLabel('Client / Site Name'),
              SizedBox(height: 8),
              _buildDropdownField(
                'Select from dropdown (assigned location)',
                selectedSite,
                (value) {
                  setState(() {
                    selectedSite = value;
                  });
                },
              ),
              SizedBox(height: 20),

              // Shift Date Field
              _buildLabel('Shift Date'),
              SizedBox(height: 8),
              _buildDisabledField(
                  'Auto-filled or selectable (the shift you are calling out from)'),
              SizedBox(height: 20),

              // Shift Time Field
              _buildLabel('Shift Time'),
              SizedBox(height: 8),
              _buildDisabledField('Auto-filled (e.g., 07:00 AM - 07:00 PM)'),
              SizedBox(height: 24),

              // Warning Message
              Text(
                'You can only call out up to 4 hours before shift start.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFFF0000),
                  fontWeight: FontWeight.w500,
                ),
                // textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),

              // Emergency Type Field
              _buildLabel('Emergency Type'),
              SizedBox(height: 8),
              _buildDropdownField(
                'Dropdown (e.g., Medical, Family, Accident, Personal, Other)',
                selectedEmergencyType,
                (value) {
                  setState(() {
                    selectedEmergencyType = value;
                  });
                },
              ),
              SizedBox(height: 20),

              // Reason / Description Field
              _buildLabel('Reason / Description'),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: TextField(
                  controller: _reasonController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText:
                        'I\'m unable to attend my shift today due to a sudden personal emergency. It\'s an urgent situation that needs my immediate attention. Seek approval for emergency call-out leave, please.',
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFB0B0B0),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.primaryTextColor,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Upload Proof Field
              _buildLabel('Upload Proof (Optional)'),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B6B6B),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _openCamera,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Color(0xFF6B6B6B),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Open Camera',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF6B6B6B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: SSSFilledButton(
                  buttonText: 'Submit',
                  onPressed: () {
                    // Handle submit
                  },
                  bgColor: Color(0xFFFFA726),
                  textColor: Colors.white,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppTheme.primaryTextColor,
      ),
    );
  }

  Widget _buildDisabledField(String hintText) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Text(
        hintText,
        style: TextStyle(
          fontSize: 13,
          color: Color(0xFFB0B0B0),
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String hintText,
    String? selectedValue,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            hintText,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFFB0B0B0),
              fontStyle: FontStyle.italic,
            ),
          ),
          value: selectedValue,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF6B6B6B),
          ),
          items: [], // Add your items here
          onChanged: onChanged,
        ),
      ),
    );
  }
}