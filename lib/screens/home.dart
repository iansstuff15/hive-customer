// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/components/AppLayout.dart';
import 'package:hive_customer/components/ServiceButton.dart';
import 'package:hive_customer/components/businessItemList.dart';
import 'package:hive_customer/components/businessListItem.dart';
import 'package:hive_customer/components/chart/bar_charts.dart';
import 'package:hive_customer/components/customerSection.dart';
import 'package:hive_customer/components/applocation.dart';
import 'package:hive_customer/components/locationSelector.dart';
import 'package:hive_customer/components/servicesGrid.dart';
import 'package:hive_customer/components/transactionsGrid.dart';
import 'package:hive_customer/components/card.dart';
import 'package:hive_customer/components/earningsSection.dart';
import 'package:hive_customer/screens/search.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:map_location_picker/map_location_picker.dart';
import 'package:widget_marker_google_map/widget_marker_google_map.dart';
import '../statemanagement/businessInfo/businessInfoController.dart';

class Home extends StatefulWidget {
  static String id = 'home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double mapBottomPadding = 0;
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: const LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  DateTime now = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    UserStateController userInfo = Get.find<UserStateController>();
    final BusinessInfoController businessInfoController =
        BusinessInfoController();
    late GoogleMapController mapController;
    loc.LocationData? currentLocation;
    bool _isLocationEnabled = false;

    loc.Location location = loc.Location();
    LatLng _center = const LatLng(37.7749, -122.4194);

    void _getLocation() async {
      try {
        final loc.LocationData locationData = await location.getLocation();
        setState(() {
          currentLocation = locationData;
          _isLocationEnabled = true;
        });
      } catch (e) {
        print('Error: $e');
      }
    }

    @override
    void initState() {
      super.initState();
      _getLocation();
    }

    return Scaffold(
      body: AppLayout(Container(
          child: Stack(
        children: <Widget>[
          StreamBuilder<DocumentSnapshot>(
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
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('businessStatus')
                        .snapshots(),
                    builder: (context, snapshot) {
                      log("snapshot.toString()");
                      log(snapshot.toString());
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      // If there's data available, display it in a ListView
                      var documents = snapshot.data!.docs;
                      List<WidgetMarker> createmaker() {
                        if (documents.isNotEmpty) {
                          List<WidgetMarker> temp = [];
                          for (var entry in documents) {
                            var doc = entry.data();
                            temp.add(WidgetMarker(
                              position: LatLng(doc['lat'], doc['lng']),
                              markerId: 'cafe',
                              widget: Container(
                                child: GestureDetector(
                                  child: Container(
                                    padding:
                                        EdgeInsets.all(AppSizes.extraSmall),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(
                                          AppSizes.extraLarge),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            AppSizes.extraLarge),
                                        child: Image.network(
                                          'https://firebasestorage.googleapis.com/v0/b/hive-5eb83.appspot.com/o/images%2Ftef97nTr8cR5KJrxSMFvLqS0ck62%2Fprofile?alt=media&token=311cdd4d-f25a-46d9-b492-718c3ac76bc7',
                                          width: AppSizes.large,
                                          height: AppSizes.large,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                              ),
                            ));
                          }
                        }
                        return [];
                      }

                      return WidgetMarkerGoogleMap(
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                        },
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        initialCameraPosition: data['lat'] != null
                            ? CameraPosition(
                                target: LatLng(
                                  data['lat'],
                                  data['lng'],
                                ),
                                zoom: 15.0,
                              )
                            : CameraPosition(
                                target: LatLng(37.7749, -122.4194),
                                zoom: 15.0,
                              ),
                        widgetMarkers: createmaker(),
                      );
                    });
              }),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(children: [
              GestureDetector(
                  onTap: () => {Get.toNamed(AppSearch.id)},
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: AppSizes.small),
                    margin: EdgeInsets.symmetric(horizontal: AppSizes.small),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AppSizes.tweenSmall),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7))
                        ]),
                    child: Text(
                      "Search for a service",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
              SizedBox(
                height: AppSizes.small,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    LocationSelector(),
                    SizedBox(
                      height: AppSizes.small,
                    ),
                    Text(
                      'Find Services',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.small,
                    ),
                    SizedBox(
                        height: AppSizes.extraLarge * 1.3,
                        child: BusinessItemList(
                          typeFilter: 'all',
                          nameFilter: '',
                          limit: 2,
                        )),
                    SizedBox(
                      height: AppSizes.small,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ServiceButton(
                          label: 'Water Station',
                          icon: SvgPicture.asset(
                            'assets/waterStation.svg',
                            width: AppSizes.medium,
                            height: AppSizes.medium,
                          ),
                        ),
                        ServiceButton(
                            label: 'Technician',
                            icon: SvgPicture.asset(
                              'assets/transactions.svg',
                              width: AppSizes.medium,
                              height: AppSizes.medium,
                            )),
                        ServiceButton(
                            label: 'Plumbing',
                            icon: SvgPicture.asset(
                              'assets/plumbing.svg',
                              width: AppSizes.medium,
                              height: AppSizes.medium,
                            )),
                      ],
                    )
                  ],
                ),
              )
            ]),
          )
        ],
      ))),
    );
  }
}
