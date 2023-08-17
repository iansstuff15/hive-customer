import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_customer/utilities/sizes.dart';

class OfferList extends StatefulWidget {
  String? docID;

  OfferList({this.docID});
  @override
  State<OfferList> createState() => _OfferListState();
}

class _OfferListState extends State<OfferList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
          return ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: AppSizes.getHeight(context) * 0.3,
                  maxWidth: AppSizes.getWitdth(context) * 0.5),
              child: ListView.separated(
                itemCount: documents.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: AppSizes.small),
                itemBuilder: (context, index) {
                  var docdata = documents[index].data();

                  return ListTile(
                    title: Text(docdata['name']),
                    subtitle: Text(docdata['description']),
                    trailing: Text('₱ ${docdata['price'].toString()}'),
                  );
                },
              ));
        } catch (e) {
          print('Error in StreamBuilder: $e');
        }
        return Text('Error');
      },
    );
  }
}
