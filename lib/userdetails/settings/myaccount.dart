import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:medicare/commanpages/commonWidgets.dart';

import 'package:medicare/commanpages/configue.dart';
import 'package:medicare/module/user.dart';
import 'package:medicare/userdetails/settings/settings.dart';
import 'package:provider/provider.dart';
import 'package:medicare/services/database.dart';

class Myaccount extends StatefulWidget {
  @override
  _MyaccountState createState() => _MyaccountState();
}

class _MyaccountState extends State<Myaccount> {
  final DatabaseService databaseService = DatabaseService();

  final _formKey = GlobalKey<FormState>();

  String _currentName;

  String _currenttelenumber;
  String _currentaddress;
  String _currenthometown;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder<User>(
                stream: DatabaseService(uid: user.userkey).profileData,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10.0),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        ));
                  }
                  final profile = snapshot.data;
                  return NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                            expandedHeight:
                                MediaQuery.of(context).size.height / 5 * 2,
                            floating: false,
                            pinned: true,
                            leading: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Settings()));
                                }),
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            flexibleSpace: FlexibleSpaceBar(
                                background: ClipPath(
                                    clipper: ClippingPath(),
                                    child: Container(
                                      height:
                                          (MediaQuery.of(context).size.height /
                                              5 *
                                              2),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          gradient: linearcolor()),
                                      child: Center(
                                        child: Container(
                                          height: 120,
                                          width: 120,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              'https://c-sf.smule.com/z0/account/icon/v4_defpic.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                    )))),
                      ];
                    },
                    body: Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: ListView(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 40.0),
                              child: listbar(context, profile.fullname,
                                  Icons.account_circle)),
                          Divider(),
                          listbar(context, profile.address, Icons.home),
                          Divider(),
                          listbar(context, profile.hometown, Icons.location_on),
                          Divider(),
                          listbar(context, profile.telenumber, Icons.phone),
                          Divider(),
                          listbar(context, profile.email, Icons.email),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 5 * SizeConfig.heightMultiplier,
                                right: 5 * SizeConfig.heightMultiplier,
                                top: 5 * SizeConfig.heightMultiplier,
                                bottom: 5 * SizeConfig.heightMultiplier),
                            child: Material(
                              borderRadius: BorderRadius.circular(
                                  5 * SizeConfig.heightMultiplier),
                              elevation: 4.0,
                              child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            elevation: 0.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: SingleChildScrollView(
                                                child: Container(
                                                    color: Color(0xFFE3F2FD),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Form(
                                                          key: _formKey,
                                                          child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      top: 20.0,
                                                                      bottom:
                                                                          20.0),
                                                                  child: Text(
                                                                      'Edit Profile',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .subtitle),
                                                                ),
                                                                TextFormField(
                                                                    initialValue:
                                                                        profile
                                                                            .fullname,
                                                                    decoration: new InputDecoration(
                                                                        labelText:
                                                                            "Full Name",
                                                                        labelStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .display1,
                                                                        fillColor: Colors
                                                                            .white,
                                                                        prefixIcon: Icon(Icons.person,
                                                                            color: Colors
                                                                                .blueGrey),
                                                                        focusedBorder:
                                                                            outline(),
                                                                        enabledBorder:
                                                                            outline()),
                                                                    validator: (input) => input
                                                                            .isEmpty
                                                                        ? 'Please type your full name here'
                                                                        : null,
                                                                    onChanged:
                                                                        (input) {
                                                                      setState(
                                                                          () {
                                                                        _currentName =
                                                                            input;
                                                                      });
                                                                    },
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .display1),

                                                                // TP NUMBER
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top: 5 *
                                                                        SizeConfig
                                                                            .heightMultiplier,
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    child: new Center(
                                                                        child: new TextFormField(
                                                                            initialValue: (profile.telenumber == 'telenumber') ? null : profile.telenumber,
                                                                            decoration: new InputDecoration(labelText: "Telephone Number", prefixIcon: Icon(Icons.phone, color: Colors.blueGrey), labelStyle: Theme.of(context).textTheme.display1, fillColor: Colors.white, focusedBorder: outline(), enabledBorder: outline()),
                                                                            validator: (input) => input.length != 10 ? 'Your telephone number is incorrect' : null,
                                                                            onChanged: (input) {
                                                                              setState(() {
                                                                                _currenttelenumber = input;
                                                                              });
                                                                            },
                                                                            keyboardType: TextInputType.phone,
                                                                            style: Theme.of(context).textTheme.display1)),
                                                                  ),
                                                                ),

                                                                //Address
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top: 5 *
                                                                        SizeConfig
                                                                            .heightMultiplier,
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    child: new Center(
                                                                        child: new TextFormField(
                                                                            initialValue: (profile.address == 'address') ? null : profile.address,
                                                                            decoration: new InputDecoration(labelText: "Address", prefixIcon: Icon(Icons.home, color: Colors.blueGrey), labelStyle: Theme.of(context).textTheme.display1, fillColor: Colors.white, focusedBorder: outline(), enabledBorder: outline()),
                                                                            validator: (input) => input.isEmpty ? 'Please type your address here' : null,
                                                                            onChanged: (input) {
                                                                              setState(() {
                                                                                _currentaddress = input;
                                                                              });
                                                                            },
                                                                            keyboardType: TextInputType.text,
                                                                            style: Theme.of(context).textTheme.display1)),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top: 5 *
                                                                        SizeConfig
                                                                            .heightMultiplier,
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    child: new Center(
                                                                        child: new TextFormField(
                                                                            initialValue: (profile.hometown == 'hometown') ? null : profile.hometown,
                                                                            decoration: new InputDecoration(labelText: "Hometown", prefixIcon: Icon(Icons.location_on, color: Colors.blueGrey), labelStyle: Theme.of(context).textTheme.display1, fillColor: Colors.white, focusedBorder: outline(), enabledBorder: outline()),
                                                                            validator: (input) => input.isEmpty ? 'Please type your address here' : null,
                                                                            onChanged: (input) {
                                                                              setState(() {
                                                                                _currenthometown = input;
                                                                              });
                                                                            },
                                                                            keyboardType: TextInputType.text,
                                                                            style: Theme.of(context).textTheme.display1)),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top: 7 *
                                                                        SizeConfig
                                                                            .heightMultiplier,
                                                                    bottom: 3 *
                                                                        SizeConfig
                                                                            .heightMultiplier,
                                                                  ),
                                                                  child:
                                                                      Material(
                                                                    borderRadius:
                                                                        BorderRadius.circular(5 *
                                                                            SizeConfig.heightMultiplier),
                                                                    elevation:
                                                                        4.0,
                                                                    child: InkWell(
                                                                        onTap: () async {
                                                                          if (_formKey
                                                                              .currentState
                                                                              .validate()) {
                                                                            await DatabaseService(uid: user.userkey).updateUserData(
                                                                                _currentName ?? profile.fullname,
                                                                                profile.email,
                                                                                _currenttelenumber ?? profile.telenumber,
                                                                                _currentaddress ?? profile.address,
                                                                                _currenthometown ?? profile.hometown);
                                                                            Navigator.pop(context);
                                                                          }
                                                                        },
                                                                        child: buttonContainer(context, 'Save', 43, null)),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      bottom: 5 *
                                                                          SizeConfig
                                                                              .heightMultiplier),
                                                                  child:
                                                                      Material(
                                                                    borderRadius:
                                                                        BorderRadius.circular(4 *
                                                                            SizeConfig.heightMultiplier),
                                                                    elevation:
                                                                        7.0,
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: buttonContainerWithBlue(context, 'Cancle', 43, null)),
                                                                  ),
                                                                ),
                                                              ])),
                                                    )),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: buttonContainer(
                                      context, "Edit", 43, 100)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })));
  }

  outline() {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: Color(0xFF185a9d), style: BorderStyle.solid, width: 1),
      borderRadius: new BorderRadius.circular(22.0),
    );
  }
}

class ClippingPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, size.height / 1.5);
    path.lineTo(
      size.width,
      0.0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldCliper) => false;
}
