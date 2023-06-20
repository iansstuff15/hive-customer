import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

class OfferListItem extends StatefulWidget {
  void Function(BuildContext)? ondelete;
  void Function(BuildContext)? onEdit;

  @override
  State<OfferListItem> createState() => _OfferListItemState();
}

class _OfferListItemState extends State<OfferListItem> {
  void doNothing(BuildContext context) {
    // do something
  }
  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: widget.ondelete,
            foregroundColor: AppColors.primary,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      // endActionPane: ActionPane(
      //   motion: ScrollMotion(),
      //   children: [
      //     SlidableAction(
      //       // An action can be bigger than the others.
      //       flex: 2,
      //       onPressed: widget.onEdit,

      //       foregroundColor: AppColors.primary,
      //       icon: Icons.edit,
      //       label: 'Edit',
      //     ),
      //   ],
      // ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.medium, vertical: AppSizes.tweenSmall),
          decoration: BoxDecoration(
              color: AppColors.container,
              borderRadius: BorderRadius.circular(AppSizes.tweenSmall)),
          margin: EdgeInsets.only(bottom: AppSizes.tweenSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          )),
    );
  }
}
