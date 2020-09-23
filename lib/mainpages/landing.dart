

import 'package:flutter/material.dart';
import 'package:medicare/mainpages/tabhomepage.dart';
import 'package:medicare/module/user.dart';
import 'package:medicare/userdetails/home.dart';
import 'package:provider/provider.dart';
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null){
      return  Tabcontroller(0);
    }else{
      return  Container(
        //child: AdminPanel(),

        child:UserHome()
      );

    }
  }
}

