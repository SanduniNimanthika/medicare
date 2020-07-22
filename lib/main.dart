import 'package:flutter/material.dart';
import 'package:medicare/mainpages/authentication.dart';
import 'package:medicare/module/user.dart';
import 'package:provider/provider.dart';

      // Comman
import 'package:medicare/commanpages/textstyle.dart';
import 'package:medicare/commanpages/configue.dart';

// main pages
import 'package:medicare/mainpages/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return StreamProvider<User>.value(
              value: AuthService().user,
              child: MaterialApp(
                title: 'Ecommerce application',
                theme:  AppTheme.lightTheme,
                home: HomePage(),
                debugShowCheckedModeBanner: false,
              ),
            );
          },
        );
      },
    );
  }
}