import 'package:flutter/material.dart';
import 'package:medicare/notifier/perscriptionnotifer.dart';
import 'package:medicare/services/authentication.dart';
import 'package:medicare/module/user.dart';
import 'package:provider/provider.dart';
import 'package:medicare/notifier/productnoti.dart';
import 'package:medicare/notifier/catergorynoti.dart';
import 'package:medicare/notifier/subcatnoti.dart';
import 'package:medicare/commanpages/textstyle.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:medicare/notifier/cartnotifier.dart';
import 'package:medicare/mainpages/splash.dart';
import 'package:medicare/notifier/odernotifer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => CatergoryNotifier(),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => SubCatergoryNotifier(),
                  ),

                  ChangeNotifierProvider(
                    create: (context) => ProductNotifier(),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => ProductCartNotifier(),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => ProductOrderHistoryNotifier(),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => PerscriptionOrderHistoryNotifier(),
                  ),
            StreamProvider<User>.value(
            value: AuthService().user)],
                child: MaterialApp(
                  title: 'Ecommerce application',
                  theme:  AppTheme.lightTheme,
                  home: Splash(),
                  debugShowCheckedModeBanner: false,
                )
            );
          },
        );
      },
    );
  }
}




