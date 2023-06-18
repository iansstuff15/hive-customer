import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/components/AppLayout.dart';
import 'package:hive_customer/components/deleteConfirm.dart';
import 'package:hive_customer/screens/updateItemPage.dart';
import 'package:hive_customer/statemanagement/offersInfo/offerInfoController.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';
import 'package:sliver_app_bar_builder/sliver_app_bar_builder.dart';

class Services extends StatelessWidget {
  static String id = 'services';
  OfferInfoController _offerInfoController = Get.find<OfferInfoController>();
  TextEditingController searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            backgroundColor: AppColors.primary,
            collapsedHeight: AppSizes.getHeight(context) * 0.08,
            bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(60.0), // Set the height of the title
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 16.0,
                        bottom: 16.0), // Set the position of the title
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Services',
                            style: TextStyle(
                              color: AppColors.textBox,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: AppSizes.extraSmall),
                        SizedBox(
                          width: AppSizes.getWitdth(context) * 0.9,
                          child: AppInput(
                              "Search", TextInputType.text, searchText),
                        ),
                      ],
                    ))),
            automaticallyImplyLeading: false,
            expandedHeight: AppSizes.getHeight(context) * 0.4,
            flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              final double opacity = constraints.biggest.height /
                  (AppSizes.getHeight(context) * 0.4);
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                ),
                child: Opacity(
                    opacity: 0.25,
                    child: Image.asset(
                      'assets/services.png',
                      fit: BoxFit.scaleDown,
                    )),
              );
            }),
            floating: true,
            pinned: true,
            snap: false,
          ),

          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  OfferInfoController _offerInfoControllerInList =
                      Get.find<OfferInfoController>();
                  return Container(
                      decoration: BoxDecoration(
                        color: AppColors.container,
                        borderRadius: BorderRadius.circular(AppSizes.small),
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: AppSizes.extraSmall,
                        horizontal: AppSizes.mediumSmall,
                      ),
                      padding: EdgeInsets.symmetric(vertical: AppSizes.small),
                      child: ListTile(
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(UpdatePage.id, arguments: {
                                    'name': _offerInfoControllerInList
                                        .offerInfo.offerList[index].name,
                                    'description': _offerInfoControllerInList
                                        .offerInfo.offerList[index].description,
                                    'price': _offerInfoControllerInList
                                        .offerInfo.offerList[index].price,
                                    'uid': _offerInfoControllerInList
                                        .offerInfo.offerList[index].uid
                                  });
                                },
                                child: const Icon(
                                  Icons.edit,
                                  size: 20,
                                )),
                            GestureDetector(
                              child: const Icon(
                                Icons.delete,
                                size: 20,
                              ),
                              onTap: () {
                                Get.bottomSheet(
                                    DeleteConfirm(_offerInfoControllerInList
                                        .offerInfo.offerList[index].uid),
                                    backgroundColor:
                                        AppColors.scaffoldBackground,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                AppSizes.mediumLarge),
                                            topRight: Radius.circular(
                                                AppSizes.mediumLarge))));
                              },
                            )
                          ],
                        ),
                        title: Obx(() => Text(_offerInfoControllerInList
                            .offerInfo.offerList[index].name!)),
                        subtitle: Text(_offerInfoControllerInList
                            .offerInfo.offerList[index].description!),
                        trailing: Text(
                            '₱ ${_offerInfoControllerInList.offerInfo.offerList[index].price!}'),
                      ));
                },
                childCount: _offerInfoController.offerInfo.offerList.length,
              ),
            ),
          )
          // Add other sliver widgets here, such as SliverList or SliverGrid
        ],
      ),
      safeTop: false,
    );
  }
}
