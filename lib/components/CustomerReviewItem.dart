import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

class CustomerReviewItem extends StatefulWidget {
  String? customerID;
  String? businessID;
  double? starRating;
  String? content;
  String? date;
  CustomerReviewItem(
      {required this.businessID,
      required this.customerID,
      required this.content,
      required this.date,
      required this.starRating});
  @override
  State<CustomerReviewItem> createState() => _CustomerReviewItemState();
}

class _CustomerReviewItemState extends State<CustomerReviewItem> {
  @override
  Widget build(BuildContext context) {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('customer')
        .doc(widget.customerID);
    return Container(
        child: StreamBuilder<DocumentSnapshot>(
      stream: documentReference.snapshots(),
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
        return Column(
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.tweenSmall),
                    child: Image.network(
                      data['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: AppSizes.extraSmall,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data['lastName']}, ${data['firstName']}",
                        style: TextStyle(fontSize: AppSizes.small),
                      ),
                      SizedBox(
                        height: AppSizes.extraSmall,
                      ),
                      Text(
                        "${widget.date}",
                        style: TextStyle(fontSize: AppSizes.tweenSmall),
                      ),
                      RatingStars(
                        value: widget.starRating!,
                        onValueChanged: (v) {},
                        starBuilder: (index, color) => Icon(
                          Icons.star,
                          color: color,
                          size: AppSizes.tweenSmall,
                        ),
                        starCount: 5,
                        starSize: 10,
                        maxValue: 5,
                        starSpacing: 0,
                        maxValueVisibility: true,
                        valueLabelVisibility: false,
                        animationDuration: Duration(milliseconds: 1000),
                        starOffColor: const Color(0xffe7e8ea),
                        starColor: AppColors.primary,
                      ),
                      SizedBox(
                        height: AppSizes.extraSmall,
                      ),
                      SizedBox(
                          width: AppSizes.getWitdth(context) * 0.75,
                          child: Text(
                            widget.content!,
                            softWrap: true,
                            style: TextStyle(fontSize: AppSizes.tweenSmall),
                          )),
                      SizedBox(
                        height: AppSizes.small,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        );
      },
    ));
  }
}
