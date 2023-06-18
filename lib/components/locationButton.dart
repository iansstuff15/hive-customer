import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:map_location_picker/map_location_picker.dart';

class LocationButton extends StatefulWidget {
  String? address;
  Function(GeocodingResult?) onNext;
  LocationButton(this.address, this.onNext);

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  Position? _currentPosition;
  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
        decoration: BoxDecoration(
            color: AppColors.container,
            borderRadius: BorderRadius.circular(AppSizes.small)),
        width: double.infinity,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.small),
          onTap: () async {
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
                    onNext: widget.onNext,
                  );
                },
              ),
            );
          },
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.mediumSmall, vertical: AppSizes.small),
              decoration: BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.address!),
                ],
              )),
        ));
  }
}
