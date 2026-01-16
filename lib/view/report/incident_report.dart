import 'package:flutter/material.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';
import 'package:image_picker/image_picker.dart';

class IncidentReportView extends StatefulWidget {
  const IncidentReportView({super.key});

  @override
  State<IncidentReportView> createState() => _IncidentReportViewState();
}

class _IncidentReportViewState extends State<IncidentReportView> {
  String? selectedPriority = 'High';
  String? selectedEmployeeName;
  String? selectedFacilityType;
  DateTime? selectedDateTime;
  String? selectedDayOfWeek;
  String? selectedReportPreparedBy;
  String? selectedTypeOfIncident;
  String? selectedIncidentTitle;
  String? selectedEmergencyResponders;
  String? selectedReviewedBy;
  DateTime? reviewDate;

  final TextEditingController _postPositionController = TextEditingController();
  final TextEditingController _facilityNameController = TextEditingController();
  final TextEditingController _pageNumberController = TextEditingController();
  final TextEditingController _personsInvolvedController =
      TextEditingController();
  final TextEditingController _injuriesController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _securityDirectorController =
      TextEditingController();
  final TextEditingController _dispositionController = TextEditingController();

  String? uploadedPicture;
  String? uploadedSignature;

  @override
  void initState() {
    super.initState();
    selectedDateTime = DateTime(2025, 9, 2, 0, 0, 0);
    reviewDate = DateTime(2025, 9, 2);
    _pageNumberController.text = '3';
  }

  @override
  void dispose() {
    _postPositionController.dispose();
    _facilityNameController.dispose();
    _pageNumberController.dispose();
    _personsInvolvedController.dispose();
    _injuriesController.dispose();
    _titleController.dispose();
    _securityDirectorController.dispose();
    _dispositionController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          // Auto-fill day of week
          List<String> weekDays = [
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday'
          ];
          selectedDayOfWeek = weekDays[selectedDateTime!.weekday - 1];
        });
      }
    }
  }

  Future<void> _selectReviewDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: reviewDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        reviewDate = picked;
      });
    }
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '00/00/0000 00:00:00';
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:00';
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '00/00/0000';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _pickImage(bool isSignature) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        if (isSignature) {
          uploadedSignature = image.path;
        } else {
          uploadedPicture = image.path;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SScaffold(
      appBar: ssAppBar('Incident Report', context),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information Section
              _buildSectionHeader('Basic Information'),
              SizedBox(height: 16),

              _buildLabel('Priority:'),
              SizedBox(height: 8),
              _buildPriorityButtons(),
              SizedBox(height: 16),

              _buildLabel('Employee Name'),
              SizedBox(height: 8),
              _buildDropdownField(
                '(select from staff list)',
                selectedEmployeeName,
                ['Employee 1', 'Employee 2', 'Employee 3'],
                (value) => setState(() => selectedEmployeeName = value),
              ),
              SizedBox(height: 16),

              _buildLabel('Facility Type'),
              SizedBox(height: 8),
              _buildDropdownField(
                'Corporate / Residential / Construction',
                selectedFacilityType,
                ['Corporate', 'Residential', 'Construction'],
                (value) => setState(() => selectedFacilityType = value),
              ),
              SizedBox(height: 16),

              _buildLabel('Date & Time'),
              SizedBox(height: 8),
              _buildDateTimeField(
                _formatDateTime(selectedDateTime),
                () => _selectDateTime(context),
              ),
              SizedBox(height: 16),

              _buildLabel('Day of the Week'),
              SizedBox(height: 8),
              _buildTextField(
                'Auto-filled after selecting date',
                enabled: false,
                value: selectedDayOfWeek,
              ),
              SizedBox(height: 16),

              _buildLabel('Post / Position'),
              SizedBox(height: 8),
              _buildTextField(
                'Enter post/position',
                controller: _postPositionController,
              ),
              SizedBox(height: 24),

              // Incident Details Section
              _buildSectionHeader('Incident Details'),
              SizedBox(height: 16),

              _buildLabel('Facility Name'),
              SizedBox(height: 8),
              _buildTextField(
                'Auto-filled',
                controller: _facilityNameController,
                enabled: false,
              ),
              SizedBox(height: 16),

              _buildLabel('Report Prepared By (Print)'),
              SizedBox(height: 8),
              _buildDropdownField(
                '(auto-fill guard name)',
                selectedReportPreparedBy,
                ['Guard 1', 'Guard 2', 'Guard 3'],
                (value) => setState(() => selectedReportPreparedBy = value),
              ),
              SizedBox(height: 16),

              _buildLabel('Type of Incident'),
              SizedBox(height: 8),
              _buildDropdownField(
                '(e.g., Theft, Injury, Damage, Conflict, Other)',
                selectedTypeOfIncident,
                ['Theft', 'Injury', 'Damage', 'Conflict', 'Other'],
                (value) => setState(() => selectedTypeOfIncident = value),
              ),
              SizedBox(height: 16),

              _buildLabel('Incident Title'),
              SizedBox(height: 8),
              _buildDropdownField(
                '....',
                selectedIncidentTitle,
                ['Title 1', 'Title 2', 'Title 3'],
                (value) => setState(() => selectedIncidentTitle = value),
              ),
              SizedBox(height: 16),

              _buildLabel('Page Number / Total Pages'),
              SizedBox(height: 8),
              _buildTextField(
                '3',
                controller: _pageNumberController,
              ),
              SizedBox(height: 16),

              _buildLabel('Attach Picture/Video'),
              SizedBox(height: 8),
              _buildUploadButton(
                'Upload media',
                uploadedPicture != null ? 'File chosen' : 'No file chosen',
                () => _pickImage(false),
              ),
              SizedBox(height: 16),

              _buildLabel('Persons Involved'),
              SizedBox(height: 8),
              _buildTextField(
                'Visitor, Staff...',
                controller: _personsInvolvedController,
              ),
              SizedBox(height: 16),

              _buildLabel('Emergency Responders'),
              SizedBox(height: 8),
              _buildDropdownField(
                '(NYPD, DHSPD, EMS, FDNY, etc.)',
                selectedEmergencyResponders,
                ['NYPD', 'DHSPD', 'EMS', 'FDNY', 'Other'],
                (value) => setState(() => selectedEmergencyResponders = value),
              ),
              SizedBox(height: 16),

              _buildLabel('Injuries'),
              SizedBox(height: 8),
              _buildDropdownField(
                'Describe any injuries sustained.',
                selectedIncidentTitle,
                ['None', 'Minor', 'Severe'],
                (value) => setState(() {}),
              ),
              SizedBox(height: 24),

              // Review & Approval Section
              _buildSectionHeader('Review & Approval'),
              SizedBox(height: 16),

              _buildLabel('Report Reviewed By (Print)'),
              SizedBox(height: 8),
              _buildTextField(
                'Michael',
                enabled: false,
                value: 'Michael',
              ),
              SizedBox(height: 16),

              _buildLabel('Title'),
              SizedBox(height: 8),
              _buildTextField(
                '....',
                controller: _titleController,
              ),
              SizedBox(height: 16),

              _buildLabel('Date'),
              SizedBox(height: 8),
              _buildDateTimeField(
                _formatDate(reviewDate),
                () => _selectReviewDate(context),
              ),
              SizedBox(height: 16),

              _buildLabel('Digital Signature Upload'),
              SizedBox(height: 8),
              _buildUploadButton(
                'Open Camera',
                uploadedSignature != null ? 'File chosen' : 'No file chosen',
                () => _pickImage(true),
              ),
              SizedBox(height: 16),

              _buildLabel('Security Director / Officer Attached'),
              SizedBox(height: 8),
              _buildTextField(
                'Director/Officer Name',
                controller: _securityDirectorController,
              ),
              SizedBox(height: 16),

              _buildLabel('Disposition / Action Taken'),
              SizedBox(height: 8),
              _buildMultilineTextField(
                'Action or follow-up taken by management or corporate.',
                controller: _dispositionController,
              ),
              SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: SSSFilledButton(
                        buttonText: 'Cancel',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        bgColor: Color(0xFFE0E0E0),
                        textColor: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: SSSFilledButton(
                        buttonText: 'Save Report',
                        onPressed: () {
                          // Handle save
                        },
                        bgColor: Color(0xFFFFA726),
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildPriorityButtons() {
    return Row(
      children: [
        _buildPriorityButton('Low', selectedPriority == 'Low'),
        SizedBox(width: 12),
        _buildPriorityButton('Mid', selectedPriority == 'Mid'),
        SizedBox(width: 12),
        _buildPriorityButton('High', selectedPriority == 'High'),
      ],
    );
  }

  Widget _buildPriorityButton(String label, bool isSelected) {
    Color bgColor;
    Color textColor;

    if (isSelected) {
      if (label == 'Low') {
        bgColor = Colors.grey;
        textColor = Colors.white;
      } else if (label == 'Mid') {
        bgColor = Colors.orange;
        textColor = Colors.white;
      } else {
        bgColor = Colors.green;
        textColor = Colors.white;
      }
    } else {
      bgColor = Colors.white;
      textColor = Colors.black87;
    }

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedPriority = label),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE5E5E5)),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
        ),
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

  Widget _buildTextField(String hintText,
      {TextEditingController? controller, bool enabled = true, String? value}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE5E5E5)),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: value ?? hintText,
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
          color: enabled ? Colors.black87 : Color(0xFFBDBDBD),
        ),
      ),
    );
  }

  Widget _buildMultilineTextField(String hintText,
      {TextEditingController? controller}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE5E5E5)),
      ),
      child: TextField(
        controller: controller,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: hintText,
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
    );
  }

  Widget _buildDateTimeField(String value, VoidCallback onTap) {
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
              value,
              style: TextStyle(
                fontSize: 14,
                color: value == '00/00/0000 00:00:00' || value == '00/00/0000'
                    ? Color(0xFFBDBDBD)
                    : Colors.black87,
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

  Widget _buildUploadButton(
      String buttonText, String fileText, VoidCallback onTap) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE5E5E5)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: 16,
                    color: Colors.black87,
                  ),
                  SizedBox(width: 8),
                  Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            fileText,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFBDBDBD),
            ),
          ),
        ],
      ),
    );
  }
}
