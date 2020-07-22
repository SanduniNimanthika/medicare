import 'package:flutter/material.dart';
import 'package:medicare/mainpages/homepage.dart';
import 'package:medicare/mainpages/welcome.dart';
import 'package:medicare/module/user.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user==null){
      return Welcome();
    }else {
      return HomePage();
    }
  }
}
