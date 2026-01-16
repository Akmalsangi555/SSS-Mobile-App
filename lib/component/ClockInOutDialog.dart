import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:sssmobileapp/api_function.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/model/auth_models/login_user_model.dart';
import 'package:sssmobileapp/controller/user_profile_controller.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';

class ClockInOutDialog extends StatefulWidget {
  final bool isClockIn;

  const ClockInOutDialog({
    super.key,
    required this.isClockIn,
  });

  @override
  State<ClockInOutDialog> createState() => _ClockInOutDialogState();
}

class _ClockInOutDialogState extends State<ClockInOutDialog> {
  final TextEditingController _remarksController = TextEditingController();
  String _selectedFileName = 'No file chosen';
  Uint8List? selectedFileData;

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  void _openCamera() async {
    // Implement camera functionality here
    var imagePicker = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagePicker != null) {
      selectedFileData = await imagePicker.readAsBytes();
      setState(() {
        _selectedFileName = imagePicker.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: Text(
                widget.isClockIn ? 'Clock In' : 'Clock Out',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryTextColor,
                ),
              ),
            ),
            SizedBox(height: 12),

            // Subtitle
            Center(
              child: Text(
                'Please confirm your action and add optional proof.',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B6B6B),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24),

            // Capture Photo Label
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Capture Photo ',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.primaryTextColor,
                    ),
                  ),
                  TextSpan(
                    text: '(compulsory)',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFFF0000),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),

            // Camera Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
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
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _selectedFileName,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B6B6B),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Remarks Label
            Text(
              widget.isClockIn ? 'Remarks (Optional)' : 'Closing remarks',
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.primaryTextColor,
              ),
            ),
            SizedBox(height: 8),

            // Remarks TextField
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _remarksController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Write here....',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Color(0xFFB0B0B0),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.primaryTextColor,
                ),
              ),
            ),
            SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: SSSFilledButton(
                      buttonText: 'Cancel',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      bgColor: Color(0xFFE0E0E0),
                      textColor: Color(0xFF6B6B6B),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: SSSFilledButton(
                      buttonText: 'Confirm',
                      onPressed: () async {
                        LoginUserModel userData =
                            Get.find<UserProfileController>().userData!;
                        var data = {
                          "UserId": userData.usersProfileId,
                          "OrganizationID": userData.organizationId,
                          "BranchID": userData.branchId,
                          "Submit": widget.isClockIn ? "checkin" : "checkout",
                          "Remarks": _remarksController.text,
                          "Base64Image": selectedFileData == null
                              ? null
                              : "data:image/jpeg;base64,/${base64Encode(selectedFileData!)}",
                          "Latitude": "25.8607",
                          "Longitude": "65.0011",
                          "DateTimeFromMobile":
                              DateTime.now().toIso8601String(),
                        };
                        var res = await ApiService.post('CheckInOut/ClockInClockOut',
                            data: data);
                        print(res.data);
                        if (res.statusCode == 200 && res.data['IsSuccess']) {
                          Navigator.of(context).pop();
                        } else {
                          ApiService.showSnackBarOnDialog(
                              context, res.data['Message']);
                        }
                        // Handle confirmation logic
                      },
                      bgColor: Color(0xFFFFA726),
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
