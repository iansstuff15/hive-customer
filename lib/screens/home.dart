// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/components/AppLayout.dart';
import 'package:hive_customer/components/ServiceButton.dart';
import 'package:hive_customer/components/chart/bar_charts.dart';
import 'package:hive_customer/components/customerSection.dart';
import 'package:hive_customer/components/location.dart';
import 'package:hive_customer/components/servicesGrid.dart';
import 'package:hive_customer/components/transactionsGrid.dart';
import 'package:hive_customer/components/card.dart';
import 'package:hive_customer/components/earningsSection.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../statemanagement/businessInfo/businessInfoController.dart';

class Home extends StatefulWidget {
  static String id = 'home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  double mapBottomPadding = 0;
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: const LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  late GoogleMapController mapController;
  late Position currentPosition;
  DateTime now = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    final BusinessInfoController businessInfoController =
        BusinessInfoController();

    return Scaffold(
      body: AppLayout(Container(
          child: Stack(
        children: <Widget>[
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapBottomPadding, top: 30),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              mapController = controller;
              log('on map create');
              setState(() {});

              setupPositionLocator();
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
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
                  Row(
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
                                    Text('Ultrices neque ornare',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppSizes.small)),
                                    Text('change location')
                                  ]))
                        ],
                      )
                    ],
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceButton(
                        label: 'Water Station',
                        icon: SvgPicture.asset(
                          'assets/waterStation.svg',
                          width: AppSizes.extraSmall,
                          height: AppSizes.extraSmall,
                        ),
                      ),
                      ServiceButton(
                          label: 'Car Services',
                          icon: SvgPicture.asset('assets/waterStation.svg')),
                      ServiceButton(
                          label: 'Technician',
                          icon: SvgPicture.asset('assets/waterStation.svg'))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ))),
    );
  }

  void setupPositionLocator() async {
    log('in setup position method');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    log(await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation)
        .toString());
    currentPosition = position;
    log(position.toString());
    log(currentPosition.toString());
    LatLng pos = LatLng(position.latitude, position.longitude);
    log(position.latitude.toString());
    log(position.longitude.toString());
    CameraPosition cp = new CameraPosition(target: pos, zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
    // String address =
    //     await HelperMethods.findCoordinateAddress(position, context);
  }
}
