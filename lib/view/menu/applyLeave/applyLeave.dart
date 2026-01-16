import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sssmobileapp/api_function.dart';
import 'package:sssmobileapp/model/leave_type_modle.dart';
import 'package:sssmobileapp/model/auth_models/login_user_model.dart';
import 'package:sssmobileapp/controller/user_profile_controller.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';

class ApplyLeaveView extends StatefulWidget {
  const ApplyLeaveView({super.key});

  @override
  State<ApplyLeaveView> createState() => _ApplyLeaveViewState();
}

class _ApplyLeaveViewState extends State<ApplyLeaveView> {
  String? selectedClient;
  String? selectedLocation;
  String? selectedShift = 'Morning';
  LeaveTypeModel? selectedLeaveType;
  DateTime? fromDate;
  DateTime? toDate;
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fromDate = DateTime(2025, 9, 2);
    toDate = DateTime(2025, 9, 3);
    getLeaveType();
  }

  List<LeaveTypeModel> leaveTypes = [];
  bool loadLeaveType = true;

  getLeaveType() async {
    try {
      var response = await ApiService.get('LeaveBalance/LeaveTypes');
      if (response.statusCode == 200 && response.data['IsSuccess']) {
        var data = response.data['Content'] as List;
        leaveTypes = data.map((e) => LeaveTypeModel.fromJson(e)).toList();
        if (leaveTypes.isNotEmpty) {
          selectedLeaveType = leaveTypes.first;
        }
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        loadLeaveType = false;
      });
    }
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate
          ? (fromDate ?? DateTime.now())
          : (toDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return SScaffold(
      appBar: ssAppBar('Apply Leave', context),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Client Field
              _buildLabel('Client'),
              SizedBox(height: 8),
              _buildDropdownField(
                'Select Client',
                selectedClient,
                ['Client A', 'Client B', 'Client C'],
                (value) {
                  setState(() {
                    selectedClient = value;
                  });
                },
              ),
              SizedBox(height: 20),

              // Location Field
              _buildLabel('Location'),
              SizedBox(height: 8),
              _buildDropdownField(
                'Select Location',
                selectedLocation,
                ['Location A', 'Location B', 'Location C'],
                (value) {
                  setState(() {
                    selectedLocation = value;
                  });
                },
              ),
              SizedBox(height: 20),

              // Shift Field
              _buildLabel('Shift'),
              SizedBox(height: 8),
              _buildDropdownField(
                'Morning',
                selectedShift,
                ['Morning', 'Evening', 'Night'],
                (value) {
                  setState(() {
                    selectedShift = value;
                  });
                },
              ),
              SizedBox(height: 20),

              // Leave Type Field
              _buildLabel('Leave Type'),
              SizedBox(height: 8),
              if (loadLeaveType)
                CircularProgressIndicator()
              else
                _buildDropdownField(
                  'Sick Leave',
                  selectedLeaveType!.leaveTypeName,
                  leaveTypes.map((e) => e.leaveTypeName).toList(),
                  (value) {
                    setState(() {
                      selectedLeaveType = leaveTypes.firstWhere(
                          (element) => element.leaveTypeName == value);
                    });
                  },
                ),
              SizedBox(height: 20),

              // Date Fields Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('From Date'),
                        SizedBox(height: 8),
                        _buildDateField(
                          _formatDate(fromDate),
                          () => _selectDate(context, true),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('To Date'),
                        SizedBox(height: 8),
                        _buildDateField(
                          _formatDate(toDate),
                          () => _selectDate(context, false),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Reason Field
              _buildLabel('Reason'),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFE5E5E5)),
                ),
                child: TextField(
                  controller: _reasonController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'I have bad fever.....',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFBDBDBD),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: SSSFilledButton(
                  buttonText: 'Submit',
                  onPressed: () async {
                    LoginUserModel userProfileModel =
                        Get.find<UserProfileController>().userData!;
                    var data = {
                      "ScheduleDetailId": 13666,
                      "UsersProfile_ID": userProfileModel.usersProfileId,
                      "Guards_ID": userProfileModel.guardsId,
                      "FromDate": fromDate!.toIso8601String(),
                      "ToDate": toDate!.toIso8601String(),
                      "ReasonOfLeave": "Family emergency",
                      "leave_type_id": selectedLeaveType!.leaveTypeId,
                      "WorkingDays": 5
                    };
                    var res =
                        await ApiService.post('ApplyLeave/LeaveRequest', data: data);
                    if (res.statusCode == 200) {
                      print(res.data);
                    }
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
        color: Colors.black87,
      ),
    );
  }

  Widget _buildDropdownField(
    String hintText,
    String? selectedValue,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE5E5E5)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            hintText,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFBDBDBD),
            ),
          ),
          value: selectedValue,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black87,
          ),
          items: items.map((String value) {
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
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDateField(String value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE5E5E5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value.isEmpty ? 'Select Date' : value,
              style: TextStyle(
                fontSize: 14,
                color: value.isEmpty ? Color(0xFFBDBDBD) : Colors.black87,
              ),
            ),
            Icon(
              Icons.calendar_today,
              size: 18,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
