
import 'package:flutter/material.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';
import 'package:file_picker/file_picker.dart';

class UploadDocumentView extends StatefulWidget {
  const UploadDocumentView({super.key});

  @override
  State<UploadDocumentView> createState() => _UploadDocumentViewState();
}

class _UploadDocumentViewState extends State<UploadDocumentView> {
  String? selectedDocumentType;
  final TextEditingController _documentNameController = TextEditingController();
  String? uploadedFileName;

  @override
  void dispose() {
    _documentNameController.dispose();
    super.dispose();
  }

  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      setState(() {
        uploadedFileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SScaffold(
      appBar: ssAppBar('Upload Document', context),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Upload Document',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),

              // Description
              Text(
                'Can upload new certifications/licenses or renewed ones.',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF9E9E9E),
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24),

              // Document Type
              Text(
                'Document Type',
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
                    hint: Text(
                      'Select document type',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                    value: selectedDocumentType,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black87,
                    ),
                    items: [
                      'License',
                      'Certification',
                      'ID Proof',
                      'Training Certificate',
                      'Other'
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
                        selectedDocumentType = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Document Name
              Text(
                'Document Name',
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
                child: TextField(
                  controller: _documentNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter document name',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF9E9E9E),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    isDense: true,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black87,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Upload Area
              GestureDetector(
                onTap: _pickDocument,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFFFFA726),
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.drive_folder_upload,
                        size: 60,
                        color: Color(0xFFFFA726),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Upload Document',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Supported Format: JPEG, PNG, PDF',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                      if (uploadedFileName != null) ...[
                        SizedBox(height: 12),
                        Text(
                          uploadedFileName!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFFFA726),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),

              // Upload Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: SSSFilledButton(
                  buttonText: 'Upload',
                  onPressed: () {
                    // Handle upload
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}