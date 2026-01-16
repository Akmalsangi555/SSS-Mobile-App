import 'package:flutter/material.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';
import 'package:image_picker/image_picker.dart';

// Main List Screen

class ViewRespondWriteUpView extends StatelessWidget {
  const ViewRespondWriteUpView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> writeUps = [
      {
        'title': 'Late Arrival',
        'date': '03-Oct-2025',
        'issuedBy': 'Supervisor John',
        'responseRequired': true,
      },
      {
        'title': 'Uniform Not Proper',
        'date': '20-Sep-2025',
        'issuedBy': 'Manager Lisa',
        'responseRequired': false,
      },
    ];

    return SScaffold(
      appBar: ssAppBar('View & Respond t...', context),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: writeUps.map((writeUp) {
            return Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    writeUp['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Date: ${writeUp['date']} | Issued By: ${writeUp['issuedBy']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF757575),
                    ),
                  ),
                  SizedBox(height: 12),
                  if (writeUp['responseRequired'])
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFFEF5350),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Response Required',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFA726),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Optional Response',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: SSSFilledButton(
                      buttonText: 'View Details',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WriteUpDetailsView(
                              title: writeUp['title'],
                              date: writeUp['date'],
                              issuedBy: writeUp['issuedBy'],
                              responseRequired: writeUp['responseRequired'],
                            ),
                          ),
                        );
                      },
                      bgColor: Color(0xFFFFA726),
                      textColor: Colors.white,
                    ),
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

// Write-Up Details Screen
class WriteUpDetailsView extends StatefulWidget {
  final String title;
  final String date;
  final String issuedBy;
  final bool responseRequired;

  const WriteUpDetailsView({
    super.key,
    required this.title,
    required this.date,
    required this.issuedBy,
    required this.responseRequired,
  });

  @override
  State<WriteUpDetailsView> createState() => _WriteUpDetailsViewState();
}

class _WriteUpDetailsViewState extends State<WriteUpDetailsView> {
  final TextEditingController _responseController = TextEditingController();
  String? uploadedDocument;

  @override
  void dispose() {
    _responseController.dispose();
    super.dispose();
  }

  Future<void> _pickDocument() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    
    if (image != null) {
      setState(() {
        uploadedDocument = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SScaffold(
      appBar: ssAppBar('View & Respond t...', context),
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
                    'Write-Up Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Title with Badge
              Row(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFA726),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Response Required',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Info Container
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _buildInfoRow('Date Issued:', widget.date),
                    SizedBox(height: 8),
                    _buildInfoRow('Issued By:', widget.issuedBy),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Pending Response',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFEF5350),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Description
              Text(
                'Description:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'You arrived 30 minutes late for your morning shift at Main Tower Site. Please explain the reason for your delay. This response is required by the office.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Your Response
              Text(
                'Your Response:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFE5E5E5)),
                ),
                child: TextField(
                  controller: _responseController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Write your explaination here...',
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
              SizedBox(height: 20),

              // Attach Document
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFE5E5E5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Attach any supporting document (optional)',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF757575),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _pickDocument,
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
                                  'Open Camera',
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
                          uploadedDocument != null ? 'File chosen' : 'No file chosen',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF757575),
                          ),
                        ),
                      ],
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
                  buttonText: 'Submit Response',
                  onPressed: () {
                    // Handle submit
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

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}