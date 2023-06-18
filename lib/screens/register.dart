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
import 'package:hive_customer/data%20models/offers.dart';
import 'package:hive_customer/data%20models/storeInfo.dart';
import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/screens/appPages.dart';
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
  TextEditingController businessName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController businessEmail = TextEditingController();
  TextEditingController productName = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  String address = "Please choose an address";

  String autocompletePlace = "null";
  List<Offers> offersList = [];
  String? businessType = ' ';
  TimeOfDay now = TimeOfDay.now();
  double? businessLat = 0;
  double? businessLng = 0;
  File? _profilePicFile;

  String? mondayStart = 'Start';
  String? tuesdayStart = 'Start';
  String? wednesdayStart = 'Start';
  String? thursdayStart = 'Start';
  String? fridayStart = 'Start';
  String? saturdayStart = 'Start';
  String? sundayStart = 'Start';

  String? mondayEnd = 'End';
  String? tuesdayEnd = 'End';
  String? wednesdayEnd = 'End';
  String? thursdayEnd = 'End';
  String? fridayEnd = 'End';
  String? saturdayEnd = 'End';
  String? sundayEnd = 'End';

  void _directUpdateImage(File? file) async {
    if (file == null) return;

    setState(() {
      _profilePicFile = file;
    });
  }

  Future<String> showTimeSelector() async {
    final TimeOfDay? picked_s = await showTimePicker(
      context: context,
      initialTime: now,
    );
    log(picked_s!.format(context).toString());
    return picked_s!.format(context);
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
                              FirebaseManager().registerStore(
                                  _userStateController.user.uid.toString(),
                                  StoreInfo(
                                      businessName: businessName.text,
                                      description: description.text,
                                      phone: phone.text,
                                      businessEmail: businessEmail.text,
                                      address: address,
                                      offersList: offersList,
                                      businessLat: businessLat,
                                      businessLng: businessLng,
                                      businessType: businessType,
                                      profilePicFile: _profilePicFile,
                                      mondayStart: mondayStart,
                                      mondayEnd: mondayEnd,
                                      tuesdayEnd: tuesdayEnd,
                                      tuesdayStart: tuesdayStart,
                                      wednesdayStart: wednesdayStart,
                                      wednesdayEnd: wednesdayEnd,
                                      thursdayStart: thursdayStart,
                                      thursdayEnd: thursdayEnd,
                                      fridayStart: fridayStart,
                                      fridayEnd: fridayEnd,
                                      saturdayStart: saturdayStart,
                                      saturdayEnd: saturdayEnd,
                                      sundayStart: sundayStart,
                                      sundayEnd: sundayEnd));

                              bl.close();
                              Get.toNamed(AppPages.id);
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
                                AppInput('Business Name', TextInputType.name,
                                    businessName),
                                SizedBox(
                                  height: AppSizes.small,
                                ),
                                AppInput('Description', TextInputType.name,
                                    description),
                                SizedBox(
                                  height: AppSizes.small,
                                ),
                                AppInput(
                                  'Phone',
                                  TextInputType.phone,
                                  phone,
                                ),
                                SizedBox(
                                  height: AppSizes.small,
                                ),
                                AppInput('Business Email',
                                    TextInputType.emailAddress, businessEmail),
                              ],
                            ),
                          )
                        : Container(),
                    widget.position == 1
                        ? SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BusinessTypeSelector(
                                    'Water Refilling Station',
                                    'assets/waterRefilling.jpg',
                                    businessType, () {
                                  setState(() {
                                    businessType = 'Water Refilling Station';
                                  });
                                }),
                                SizedBox(
                                  height: AppSizes.tweenSmall,
                                ),
                                BusinessTypeSelector('Plumber',
                                    'assets/plumber.jpg', businessType, () {
                                  setState(() {
                                    businessType = 'Plumber';
                                  });
                                }),
                                SizedBox(
                                  height: AppSizes.tweenSmall,
                                ),
                                BusinessTypeSelector('Technician',
                                    'assets/technician.jpg', businessType, () {
                                  setState(() {
                                    businessType = 'Technician';
                                  });
                                }),
                              ],
                            ),
                          )
                        : Container(),
                    widget.position == 2
                        ? SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Monday",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSizes.small),
                                ),
                                SizedBox(
                                  height: AppSizes.tweenSmall,
                                ),
                                Row(
                                  children: [
                                    AppTextButton(mondayStart, () async {
                                      String response =
                                          await showTimeSelector();

                                      setState(() {
                                        mondayStart = response;
                                      });
                                    },
                                        background: AppColors.container,
                                        width:
                                            AppSizes.getWitdth(context) * 0.4),
                                    SizedBox(
                                      width: AppSizes.small,
                                    ),
                                    AppTextButton(
                                      mondayEnd,
                                      () async {
                                        String response =
                                            await showTimeSelector();

                                        setState(() {
                                          mondayEnd = response;
                                        });
                                      },
                                      background: AppColors.container,
                                      width: AppSizes.getWitdth(context) * 0.4,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: AppSizes.small,
                                ),
                                Text(
                                  "Tuesday",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSizes.small),
                                ),
                                SizedBox(
                                  height: AppSizes.tweenSmall,
                                ),
                                Row(
                                  children: [
                                    AppTextButton(tuesdayStart, () async {
                                      String response =
                                          await showTimeSelector();

                                      setState(() {
                                        tuesdayStart = response;
                                      });
                                    },
                                        background: AppColors.container,
                                        width:
                                            AppSizes.getWitdth(context) * 0.4),
                                    SizedBox(
                                      width: AppSizes.small,
                                    ),
                                    AppTextButton(
                                      tuesdayEnd,
                                      () async {
                                        String response =
                                            await showTimeSelector();

                                        setState(() {
                                          tuesdayEnd = response;
                                        });
                                      },
                                      background: AppColors.container,
                                      width: AppSizes.getWitdth(context) * 0.4,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: AppSizes.small,
                                ),
                                Text(
                                  "Wednesday",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSizes.small),
                                ),
                                SizedBox(
                                  height: AppSizes.tweenSmall,
                                ),
                                Row(
                                  children: [
                                    AppTextButton(wednesdayStart, () async {
                                      String response =
                                          await showTimeSelector();

                                      setState(() {
                                        wednesdayStart = response;
                                      });
                                    },
                                        background: AppColors.container,
                                        width:
                                            AppSizes.getWitdth(context) * 0.4),
                                    SizedBox(
                                      width: AppSizes.small,
                                    ),
                                    AppTextButton(
                                      wednesdayEnd,
                                      () async {
                                        String response =
                                            await showTimeSelector();

                                        setState(() {
                                          wednesdayEnd = response;
                                        });
                                      },
                                      background: AppColors.container,
                                      width: AppSizes.getWitdth(context) * 0.4,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: AppSizes.small,
                                ),
                                Text(
                                  "Thursday",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSizes.small),
                                ),
                                SizedBox(
                                  height: AppSizes.tweenSmall,
                                ),
                                Row(
                                  children: [
                                    AppTextButton(thursdayStart, () async {
                                      String response =
                                          await showTimeSelector();

                                      setState(() {
                                        thursdayStart = response;
                                      });
                                    },
                                        background: AppColors.container,
                                        width:
                                            AppSizes.getWitdth(context) * 0.4),
                                    SizedBox(
                                      width: AppSizes.small,
                                    ),
                                    AppTextButton(
                                      thursdayEnd,
                                      () async {
                                        String response =
                                            await showTimeSelector();

                                        setState(() {
                                          thursdayEnd = response;
                                        });
                                      },
                                      background: AppColors.container,
                                      width: AppSizes.getWitdth(context) * 0.4,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: AppSizes.small,
                                ),
                                Text(
                                  "Friday",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSizes.small),
                                ),
                                SizedBox(
                                  height: AppSizes.tweenSmall,
                                ),
                                Row(
                                  children: [
                                    AppTextButton(fridayStart, () async {
                                      String response =
                                          await showTimeSelector();

                                      setState(() {
                                        fridayStart = response;
                                      });
                                    },
                                        background: AppColors.container,
                                        width:
                                            AppSizes.getWitdth(context) * 0.4),
                                    SizedBox(
                                      width: AppSizes.small,
                                    ),
                                    AppTextButton(
                                      fridayEnd,
                                      () async {
                                        String response =
                                            await showTimeSelector();

                                        setState(() {
                                          fridayEnd = response;
                                        });
                                      },
                                      background: AppColors.container,
                                      width: AppSizes.getWitdth(context) * 0.4,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: AppSizes.small,
                                ),
                                Text(
                                  "Saturday",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSizes.small),
                                ),
                                SizedBox(
                                  height: AppSizes.tweenSmall,
                                ),
                                Row(
                                  children: [
                                    AppTextButton(saturdayStart, () async {
                                      String response =
                                          await showTimeSelector();

                                      setState(() {
                                        saturdayStart = response;
                                      });
                                    },
                                        background: AppColors.container,
                                        width:
                                            AppSizes.getWitdth(context) * 0.4),
                                    SizedBox(
                                      width: AppSizes.small,
                                    ),
                                    AppTextButton(
                                      saturdayEnd,
                                      () async {
                                        String response =
                                            await showTimeSelector();

                                        setState(() {
                                          saturdayEnd = response;
                                        });
                                      },
                                      background: AppColors.container,
                                      width: AppSizes.getWitdth(context) * 0.4,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: AppSizes.small,
                                ),
                                Text(
                                  "Sunday",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSizes.small),
                                ),
                                SizedBox(
                                  height: AppSizes.tweenSmall,
                                ),
                                Row(
                                  children: [
                                    AppTextButton(sundayStart, () async {
                                      String response =
                                          await showTimeSelector();

                                      setState(() {
                                        sundayStart = response;
                                      });
                                    },
                                        background: AppColors.container,
                                        width:
                                            AppSizes.getWitdth(context) * 0.4),
                                    SizedBox(
                                      width: AppSizes.small,
                                    ),
                                    AppTextButton(
                                      sundayEnd,
                                      () async {
                                        String response =
                                            await showTimeSelector();

                                        setState(() {
                                          sundayEnd = response;
                                        });
                                      },
                                      background: AppColors.container,
                                      width: AppSizes.getWitdth(context) * 0.4,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    widget.position == 3
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                AppTextButton(
                                  "+",
                                  () {
                                    Get.bottomSheet(
                                        SingleChildScrollView(
                                            child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  AppSizes.getHeight(context) *
                                                      0.02,
                                              horizontal: AppSizes.small),
                                          child: Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // SizedBox(
                                              //   height: AppSizes.e,
                                              // ),

                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal:
                                                        AppSizes.getWitdth(
                                                                context) *
                                                            0.25),
                                                decoration: BoxDecoration(
                                                    color: AppColors.textColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSizes
                                                                .mediumSmall)),
                                                height: AppSizes.extraSmall,
                                                width: AppSizes.getWitdth(
                                                        context) *
                                                    0.5,
                                              ),
                                              SizedBox(
                                                height: AppSizes.mediumSmall,
                                              ),
                                              Text(
                                                "Add your product",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: AppSizes.small,
                                                ),
                                              ),
                                              Text(
                                                "Information",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        AppSizes.mediumSmall,
                                                    color: AppColors.primary),
                                              ),
                                              SizedBox(
                                                height: AppSizes.mediumSmall,
                                              ),
                                              AppInput(
                                                  "Name",
                                                  TextInputType.text,
                                                  productName),
                                              SizedBox(
                                                height: AppSizes.small,
                                              ),
                                              AppInput(
                                                "Description",
                                                TextInputType.multiline,
                                                productDescription,
                                                maxLines: 3,
                                              ),
                                              SizedBox(
                                                height: AppSizes.small,
                                              ),
                                              AppInput(
                                                  "Price (Php)",
                                                  TextInputType.number,
                                                  productPrice),
                                              SizedBox(
                                                height: AppSizes.tweenSmall,
                                              ),
                                              AppButton(
                                                "Add Item",
                                                () {
                                                  setState(() {
                                                    offersList!.add(Offers(
                                                        productName.text,
                                                        productDescription.text,
                                                        double.parse(
                                                            productPrice
                                                                .text)));
                                                  });

                                                  Get.back();
                                                },
                                                width: double.infinity,
                                              )
                                            ],
                                          )),
                                        )),
                                        backgroundColor:
                                            AppColors.scaffoldBackground,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    AppSizes.mediumLarge),
                                                topRight: Radius.circular(
                                                    AppSizes.mediumLarge))));
                                  },
                                  width: double.infinity,
                                  background: AppColors.container,
                                ),
                                SizedBox(
                                  height: AppSizes.tweenSmall,
                                ),
                                SizedBox(
                                  height: AppSizes.getHeight(context) * .6,
                                  child: ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return OfferListItem(
                                        offersList![index],
                                        ondelete: (p0) => {
                                          setState(
                                            () => {offersList.removeAt(index)},
                                          )
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: AppSizes.extraSmall,
                                    ),
                                    itemCount: offersList!.length,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    widget.position == 4
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                LocationButton(
                                  address,
                                  (GeocodingResult? result) {
                                    if (result != null) {
                                      setState(() {
                                        address =
                                            result.formattedAddress.toString();
                                        businessLat =
                                            result.geometry.location.lat;
                                        businessLng =
                                            result.geometry.location.lng;
                                      });
                                    }
                                  },
                                )
                              ],
                            ),
                          )
                        : Container(),
                    widget.position == 5
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
