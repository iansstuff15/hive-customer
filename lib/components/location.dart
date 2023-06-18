import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/data%20models/location.dart';
import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:map_location_picker/map_location_picker.dart';

import '../statemanagement/businessInfo/businessInfoController.dart';

class AppLocation extends StatefulWidget {
  const AppLocation({super.key});

  @override
  State<AppLocation> createState() => _AppLocationState();
}

class _AppLocationState extends State<AppLocation> {
  Position? _currentPosition;
  BusinessInfoController _businessInfoController =
      Get.find<BusinessInfoController>();
  UserStateController _userStateController = Get.find<UserStateController>();
  @override
  Widget build(BuildContext context) {
    return Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.medium),
        ),
        child: InkWell(
            borderRadius: BorderRadius.circular(AppSizes.medium),
            onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MapLocationPicker(
                          apiKey: "AIzaSyBwFupxXpUCpRbcY2rNUMw8zbY01OxPiF4",
                          canPopOnNextButtonTaped: true,
                          currentLatLng: LatLng(
                              _currentPosition?.latitude ?? 37.4219999,
                              _currentPosition?.latitude ?? -122.0840575),
                          onNext: (GeocodingResult? result) {
                            if (result != null) {
                              UserLocation data = UserLocation(
                                  address: result.formattedAddress,
                                  lat: result.geometry.location.lat,
                                  lng: result.geometry.location.lng);
                              FirebaseManager().updateLocation(
                                  _userStateController.user.uid.value, data);
                            }
                          },
                        );
                      },
                    ),
                  )
                },
            child: Container(
                decoration: BoxDecoration(
                    color: AppColors.container,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppSizes.small))),
                padding: EdgeInsets.all(AppSizes.small),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: AppSizes.mediumLarge,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: AppSizes.getWitdth(context) * 0.7,
                            ),
                            child: Obx(() => Text(
                                  _businessInfoController.businessInfo.address
                                      .toString(),
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w700,
                                      fontSize: AppSizes.small),
                                ))),
                        Obx(() => Text(
                              '${_businessInfoController.businessInfo.businessLat.toString()}, ${_businessInfoController.businessInfo.businessLng.toString()}',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                                fontSize: AppSizes.small,
                                overflow: TextOverflow.ellipsis,
                              ),
                              softWrap: false,
                              maxLines: 1,
                            ))
                      ],
                    )
                  ],
                ))));
  }
}
