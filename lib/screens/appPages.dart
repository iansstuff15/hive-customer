import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:hive_customer/components/AppLayout.dart';
import 'package:hive_customer/screens/profile.dart';

import 'home.dart';

class AppPages extends StatelessWidget {
  static String id = 'pages';

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return AppLayout(PageView(
      controller: controller,
      children: <Widget>[
        Home(),
        Center(
          child: Text('Third Page'),
        ),
        Profile()
      ],
    ));
    ;
  }
}
