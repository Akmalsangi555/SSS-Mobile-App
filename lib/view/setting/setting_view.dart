import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:sssmobileapp/api_function.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/model/auth_models/login_user_model.dart';
import 'package:sssmobileapp/controller/user_profile_controller.dart';
import 'package:sssmobileapp/utils/api_url/app_urls.dart';
import 'package:sssmobileapp/widgets/bottom_nav.dart';
import 'package:sssmobileapp/widgets/filled_button.dart';
import 'package:sssmobileapp/widgets/ssappbar.dart';
import 'package:sssmobileapp/widgets/s_scaffold.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? selectedGender;
  XFile? selectedImage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoginUserModel userProfileModel =
        Get.find<UserProfileController>().userData!;
    _emailController.text = userProfileModel.email;
    _nameController.text = userProfileModel.fullName;
    _passwordController.text = userProfileModel.phone ?? '';
    selectedGender = userProfileModel.gender;
  }

  @override
  Widget build(BuildContext context) {
    LoginUserModel userProfileModel =
        Get.find<UserProfileController>().userData!;
    return SScaffold(
        appBar: ssAppBar('Setting', context),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: selectedImage != null
                                  ? FileImage(File(selectedImage!.path))
                                  : userProfileModel.profilePhoto != null
                                      ? NetworkImage(AppUrls.linkUrl +
                                          userProfileModel.profilePhoto!)
                                      : AssetImage(
                                          'assets/images/user_m_profile.png')),
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.grey.shade200, width: 2),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var f = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (f != null) {
                            setState(() {
                              selectedImage = f;
                            });
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: AppTheme.backgroundColor.withValues(alpha: .5),
                                boxShadow: [
                                  // BoxShadow(
                                  //   color: Colors.black.withValues(alpha: 0.5),
                                  //   blurRadius: 8,
                                  // )
                                ],
                                border: Border.all(color: Colors.white),
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                              size: 18,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(userProfileModel.fullName,
                      style: TextStyle(
                          color: AppTheme.primaryTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text(userProfileModel.email,
                      style: TextStyle(
                        color: AppTheme.secondaryColor,
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            label: Text('Name'),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            label: Text('Email'),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            label: Text('Phone'),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            label: Text('Password'),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            label: Text('Confirm Password'),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        DropdownButtonFormField(
                            value: selectedGender,
                            decoration: InputDecoration(
                              hintText: 'Male',
                            ),
                            items: [
                              DropdownMenuItem(
                                child: Text('Male'),
                                value: 'Male',
                              ),
                              DropdownMenuItem(
                                child: Text('Female'),
                                value: 'Female',
                              ),
                            ],
                            onChanged: (v) {
                              setState(() {
                                selectedGender = v;
                              });
                            })
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SSSFilledButton(
                          buttonText: 'Return to Home',
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => BottomNav()));
                          },
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: SSSFilledButton(
                          bgColor: AppTheme.primaryBGButtonColor,
                          buttonText: 'Save',
                          onPressed: () async {
                            var imageBytes = await selectedImage!.readAsBytes();
                            var res = await ApiService.post('endpoint', data: {
                              "Id": userProfileModel.usersProfileId,
                              "UsersProfileType_ID":
                                  userProfileModel.usersProfileTypeId,
                              "FullName": _nameController.text,
                              "Email": _emailController.text,
                              "Phone": _phoneController.text,
                              "Gender": selectedGender,
                              "Photo": "data:image/jpeg;base64,/$imageBytes",
                              "NewPassword": _passwordController.text,
                              "ConfirmPassword":
                                  _confirmPasswordController.text,
                            });
                            ApiService.showDialogOnApi(context, res.data['IsSuccess']);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
