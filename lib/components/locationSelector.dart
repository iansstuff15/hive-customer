import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:map_location_picker/map_location_picker.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  UserStateController userInfo = Get.find<UserStateController>();

  @override
  Widget build(BuildContext context) {
    String address = '';
    return Obx(() => StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('customer')
            .doc(userInfo.user.uid.value)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching data from Firestore'),
            );
          }

          var data = snapshot.data?.data() as Map<String, dynamic>?;
          if (data == null) {
            return Center(
              child: Text('Document does not exist'),
            );
          }
          return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return MapLocationPicker(
                      apiKey: "AIzaSyC-8kQimT2bQQaadrXDetyKYE6YKXDx8S4",
                      canPopOnNextButtonTaped: true,
                      currentLatLng: data['lat'] != null
                          ? LatLng(data['lat'], data['lng'])
                          : LatLng(37.7749, -122.4194),
                      // currentLatLng: LatLng(
                      //     _currentPosition?.latitude ?? 37.4219999,
                      //     _currentPosition?.latitude ?? -122.0840575),
                      onNext: (result) async {
                        print('results');
                        print(result!.formattedAddress.toString());

                        await FirebaseFirestore.instance
                            .collection('customer')
                            .doc(userInfo.user.uid.value)
                            .update({
                          'address': result!.formattedAddress.toString(),
                          'lat': result.geometry.location.lat,
                          'lng': result.geometry.location.lng
                        });
                      },
                    );
                  },
                ));
              },
              child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: AppSizes.mediumLarge,
                      ),
                      SizedBox(
                        width: AppSizes.extraSmall,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Location',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppSizes.tweenSmall),
                          ),
                          SizedBox(
                              width: AppSizes.getWitdth(context) * 0.75,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width:
                                            AppSizes.getWitdth(context) * 0.45,
                                        child: Text(
                                            data['address'] == null
                                                ? 'Please choose a location'
                                                : data['address'],
                                            style: TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppSizes.small,
                                              overflow: TextOverflow.ellipsis,
                                            ))),
                                    Text('change location')
                                  ]))
                        ],
                      )
                    ],
                  )));
        }));
  }
}
