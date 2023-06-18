import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_customer/components/AppInput.dart';
import 'package:hive_customer/components/AppLayout.dart';
import 'package:hive_customer/components/transactionListItem.dart';
import 'package:hive_customer/utilities/colors.dart';
import 'package:hive_customer/utilities/sizes.dart';

class Transactions extends StatefulWidget {
  static String id = 'transactions';

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List<String> tags = [];

  TextEditingController searchText = TextEditingController();

  List<String> options = [
    'Completed',
    'Pending',
    'Cancelled',
  ];

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            backgroundColor: AppColors.primary,
            collapsedHeight: AppSizes.getHeight(context) * 0.18,
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
                        Text('Transactions',
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
                        SizedBox(height: AppSizes.extraSmall),
                        ChipsChoice<String>.multiple(
                          value: tags,
                          onChanged: (val) => setState(() => tags = val),
                          choiceStyle: C2ChipStyle.filled(
                            selectedStyle: C2ChipStyle(
                              backgroundColor: AppColors.textBox,
                            ),
                          ),
                          choiceItems: C2Choice.listFrom<String, String>(
                            source: options,
                            value: (i, v) => v,
                            label: (i, v) => v,
                          ),
                        ),
                      ],
                    ))),
            automaticallyImplyLeading: false,
            expandedHeight: AppSizes.getHeight(context) * 0.4,
            flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              final double opacity =
                  (((constraints.biggest.height * 0.2) / constraints.maxHeight))
                      .clamp(0.0, 1.0);
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                ),
                child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      'assets/transactions.png',
                      fit: BoxFit.scaleDown,
                    )),
              );
            }),
            floating: true,
            pinned: true,
            snap: false,
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                    decoration: BoxDecoration(
                        color: AppColors.container,
                        borderRadius: BorderRadius.circular(AppSizes.small)),
                    margin: EdgeInsets.symmetric(
                        vertical: AppSizes.extraSmall,
                        horizontal: AppSizes.mediumSmall),
                    padding: EdgeInsets.all(AppSizes.small),
                    child: TransactionListItem());
              },
              childCount: 15,
            ),
          ),
          // Add other sliver widgets here, such as SliverList or SliverGrid
        ],
      ),
      safeTop: false,
    );
  }
}
