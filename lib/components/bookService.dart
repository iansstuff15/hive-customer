import 'dart:developer';

import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppButton.dart';
import 'package:hive_customer/helper/firebase.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:intl/intl.dart';

class Offer {
  final int id;
  final String name;
  final double price;

  Offer({
    required this.id,
    required this.name,
    required this.price,
  });
}

class BookService extends StatefulWidget {
  String? docID;
  BookService({required this.docID});

  @override
  State<BookService> createState() => _BookServiceState();
}

class _BookServiceState extends State<BookService> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  List<dynamic> _selectedOffers = [];
  bool buttonState = true;
  bool _isDateSelectable(DateTime date) {
    // Your logic to determine if the date is selectable
    // For example, disable past dates:
    return date.isAfter(DateTime.now());
  }

  DateTime selectedDates = DateTime.now();
  List<DateTime> unselectableDates = [
    DateTime(2023, 11, 10),
    DateTime(2023, 11, 16),
    DateTime(2023, 11, 20),
  ];
  bool isDateSelectable(DateTime date) {
    // Return true if the date is selectable, otherwise false
    if (unselectableDates.contains(date)) {
      return false; // Date is not selectable
    }

    return true; // Date is selectable
  }

  String _formatDate(DateTime date) {
    // Use the intl package for date formatting
    return DateFormat('MM-dd-yyyy').format(date);
  }

  void checkState() {
    print("button state ${selectedDate != null && selectedTime != null}");
    if (_selectedOffers.length > 0 &&
        selectedDate != null &&
        selectedTime != null) {
      setState(() {
        buttonState = false;
      });
    } else {
      setState(() {
        buttonState = true;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDateTime != null) {
      print("docID ${widget.docID}");
      print("pickedDate: ${pickedDateTime}");
      print("formatted ${_formatDate(pickedDateTime)}");
      var reference = FirebaseManager()
          .db
          .collection("orders")
          .where("businessID", isEqualTo: widget.docID!)
          .where("status", isEqualTo: "Pending")
          .where("dateBooked", isEqualTo: _formatDate(pickedDateTime));
      QuerySnapshot<Map<String, dynamic>> querysnapshot = await reference.get();
      if (querysnapshot.docs.length == 0) {
        setState(() {
          selectedDate = pickedDateTime;
        });
        checkState();
      } else {
        ElegantNotification(
                icon: Icon(
                  Icons.error_rounded,
                  color: Colors.red,
                ),
                showProgressIndicator: false,
                displayCloseButton: false,
                title: Text("Error"),
                description: Text("Opps someone already booked that date"))
            .show(context);
        print("");
      }
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
      checkState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = BoardDateTimeController();

    DateTime date = DateTime.now();

    UserStateController userInfo = Get.find<UserStateController>();
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppSizes.getHeight(context) * 0.02,
              horizontal: AppSizes.small),
          child: Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: AppSizes.getWitdth(context) * 0.25),
                  decoration: BoxDecoration(
                      color: AppColors.textColor,
                      borderRadius:
                          BorderRadius.circular(AppSizes.mediumSmall)),
                  height: AppSizes.extraSmall,
                  width: AppSizes.getWitdth(context) * 0.5,
                ),
                SizedBox(
                  height: AppSizes.mediumSmall,
                ),
                Text(
                  "Book a service",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.mediumSmall,
                  ),
                ),
                SizedBox(
                  height: AppSizes.small,
                ),
                AppButton(
                  selectedDate != null
                      ? '${selectedDate!.month}-${selectedDate!.day}-${selectedDate!.year}'
                      : 'Choose date',
                  () => _selectDate(context),
                  width: double.infinity,
                  background: AppColors.textBox,
                ),
                SizedBox(
                  height: AppSizes.small,
                ),
                AppButton(
                  selectedTime != null
                      ? '${selectedTime!.hour}:${selectedTime!.minute} ${selectedTime!.period.name}'
                      : 'Choose time',
                  () => _selectTime(context),
                  width: double.infinity,
                  background: AppColors.textBox,
                ),
                SizedBox(
                  height: AppSizes.small,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('business')
                      .doc(widget.docID)
                      .collection('offers')
                      .snapshots(),
                  builder: (context, snapshot) {
                    try {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      // If there's data available, display it in a ListView
                      var documents = snapshot.data!.docs;
                      List<Offer> documentList = documents
                          .map((doc) => Offer(
                              id: 1,
                              name: '${doc['name']} ₱${doc['price']}',
                              price: doc['price']))
                          .toList();
                      var _items = documentList
                          .map((data) => MultiSelectItem(data, data.name))
                          .toList();
                      return MultiSelectBottomSheetField(
                        selectedColor: AppColors.primary,
                        initialChildSize: 0.4,
                        listType: MultiSelectListType.LIST,
                        searchable: true,
                        buttonText: Text("Choose offers to avail"),
                        title: Text("Busines Offers"),
                        items: _items,
                        onConfirm: (values) {
                          //   _selectedOffers = values;
                          // });
                          // print(_selectedOffers);
                          log(values.toString());

                          if (values != null) {
                            _selectedOffers = values;
                          }
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (value) {
                            setState(() {
                              _selectedOffers.remove(value);
                            });
                          },
                        ),
                      );
                    } catch (e) {
                      print('Error in StreamBuilder: $e');
                    }

                    return Text('Error');
                  },
                ),
                SizedBox(
                  height: AppSizes.small,
                ),
                Obx(() => AppButton(
                      "Book for ${userInfo.user.email}",
                      () {
                        CollectionReference orderCollectionRef =
                            FirebaseFirestore.instance.collection('orders');
                        print('selected details');
                        print(selectedDate.toString());
                        print(selectedTime.toString());
                        print('selected offers ' + _selectedOffers.toString());
                        log(_selectedOffers.toString());
                        orderCollectionRef
                            .add({
                              'customerID': userInfo.user.uid.value,
                              'businessID': widget.docID,
                              "timeBooked":
                                  '${selectedTime!.hour}:${selectedTime!.minute} ${selectedTime!.period.name}',
                              "dateBooked":
                                  '${selectedDate!.month}-${selectedDate!.day}-${selectedDate!.year}',
                              "status": 'Pending',
                              "totalPrice": _selectedOffers.fold(
                                  0.0,
                                  (previousValue, element) =>
                                      previousValue + element.price),
                              "order": _selectedOffers.map((element) => {
                                    'name': element.name,
                                    'price': element.price
                                  })
                            })
                            .then((value) async {
                              await orderCollectionRef
                                  .doc(value.id)
                                  .update({"uid": value.id});
                            })
                            .then((value) => FirebaseManager().logAction(
                                "Created Order", userInfo.user.uid.value))
                            .then((value) => {});
                        ;
                        ElegantNotification(
                                icon: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                showProgressIndicator: false,
                                displayCloseButton: false,
                                title: Text("Sucess"),
                                description:
                                    Text("Successfully booked service"))
                            .show(context);
                        Get.back();
                      },
                      width: double.infinity,
                    ))
              ]))),
    );
  }
}
