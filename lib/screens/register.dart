import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bottom_loader/bottom_loader.dart';
import 'package:editable_image/editable_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/components/AppTextButton.dart';
import 'package:hive_customer/components/businessTypeSelector.dart';
import 'package:hive_customer/components/locationButton.dart';
import 'package:hive_customer/components/offerListItem.dart';

import 'package:hive_customer/data%20models/user.dart';
import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/screens/appPages.dart';
import 'package:hive_customer/screens/home.dart';
import 'package:hive_customer/screens/login.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:map_location_picker/map_location_picker.dart';
import '../statemanagement/user/userController.dart';
import '../utilities/sizes.dart';

class Register extends StatefulWidget {
  static String id = 'register';
  int position = 0;
  List<String> steps = [
    'Basic Information',
    "Account credentials",
    "Images",
  ];
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final UserStateController _userStateController =
      Get.put(UserStateController());
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  File? _profilePicFile;

  void _directUpdateImage(File? file) async {
    if (file == null) return;

    setState(() {
      _profilePicFile = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    BottomLoader bl = BottomLoader(context,
        isDismissible: false,
        showLogs: false,
        loader: CircularProgressIndicator(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSizes.small),
                topRight: Radius.circular(AppSizes.small))));
    return Scaffold(
      bottomNavigationBar: SizedBox(
          height: widget.position == 0
              ? AppSizes.getHeight(context) * 0.06
              : AppSizes.getHeight(context) * 0.12,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.mediumSmall),
              child: Column(
                children: [
                  widget.position != widget.steps.length
                      ? AppButton(
                          widget.position != widget.steps.length - 1
                              ? "Next"
                              : "Finish Setup",
                          () async {
                            if (widget.position != widget.steps.length - 1) {
                              setState(() {
                                widget.position++;
                              });
                            } else {
                              await bl.display();
                              FirebaseManager().registerUser(
                                Customer(
                                    firstName: firstName.text,
                                    lastName: lastName.text,
                                    phone: phone.text,
                                    email: email.text,
                                    imageUrl: '///'),
                                password.text,
                                _profilePicFile!,
                              );
                              bl.close();

                              Get.toNamed(Login.id);
                            }
                          },
                          width: double.infinity,
                        )
                      : Container(),
                  SizedBox(
                    height: AppSizes.extraSmall,
                  ),
                  widget.position != 0
                      ? AppTextButton(
                          "Previous",
                          () {
                            setState(() {
                              widget.position--;
                            });
                          },
                          background: AppColors.container,
                          width: double.infinity,
                        )
                      : Container(),
                ],
              ))),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mediumSmall, vertical: AppSizes.small),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () => Get.back(), child: Icon(Icons.arrow_back)),
                    Text(
                      "Setup Your Account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.small,
                      ),
                    ),
                    Text(
                      widget.steps[widget.position],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.mediumSmall,
                          color: AppColors.primary),
                    ),
                    SizedBox(
                      height: AppSizes.small,
                    ),
                    LinearProgressIndicator(
                      value: (double.parse(widget.position.toString()) + 1) /
                          (double.parse(widget.steps.length.toString())),
                      color: AppColors.primary,
                      backgroundColor: AppColors.container,
                    ),
                    SizedBox(
                      height: AppSizes.medium,
                    ),
                    widget.position == 0
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                AppInput('First Name', TextInputType.name,
                                    firstName),
                                SizedBox(
                                  height: AppSizes.small,
                                ),
                                AppInput(
                                    'Last Name', TextInputType.name, lastName),
                                SizedBox(
                                  height: AppSizes.small,
                                ),
                                AppInput(
                                  'Phone',
                                  TextInputType.phone,
                                  phone,
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    widget.position == 1
                        ? Column(
                            children: [
                              AppInput(
                                  'Email', TextInputType.emailAddress, email),
                              SizedBox(
                                height: AppSizes.small,
                              ),
                              AppInput(
                                'Password',
                                TextInputType.text,
                                password,
                                obsure: true,
                              ),
                            ],
                          )
                        : Container(),
                    widget.position == 2
                        ? SingleChildScrollView(
                            child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Profile Picture",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSizes.small),
                                ),
                                EditableImage(
                                  onChange: (file) => _directUpdateImage(file),
                                  image: _profilePicFile != null
                                      ? Image.file(_profilePicFile!,
                                          fit: BoxFit.cover)
                                      : null,
                                  size: 150.0,
                                  imagePickerTheme: ThemeData(
                                    primaryColor: Colors.white,
                                    shadowColor: Colors.transparent,
                                    backgroundColor: Colors.white70,
                                    iconTheme: const IconThemeData(
                                        color: Colors.black87),
                                    fontFamily: 'Georgia',
                                  ),
                                  imageBorder: Border.all(
                                      color: Colors.black87, width: 2.0),
                                  editIconBorder: Border.all(
                                      color: Colors.black87, width: 2.0),
                                ),
                              ],
                            ),
                          ))
                        : Container(),
                  ],
                ),
              ))),
    );
  }
}
