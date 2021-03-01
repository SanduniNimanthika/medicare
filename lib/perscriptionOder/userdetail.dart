import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/commonWidgets.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:medicare/perscriptionOder/previeworder.dart';
import 'package:medicare/perscriptionOder/uploadperscription.dart';
import 'package:medicare/mainpages/loading.dart';
import 'package:medicare/module/user.dart';
import 'dart:async';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:medicare/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Details extends StatefulWidget {
  final File img;
  final int days;
  Details({Key key, @required this.img, @required this.days}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState(img: img, days: days);
}

class _DetailsState extends State<Details> {
  String fullname = '';
  String email = '';
  String specialDescription = '';
  String firstlineaddress = '';
  String hometown = '';
  String password = '';
  String telenumber = '';
  bool loading = false;
  final File img;
  final int days;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseService databaseService = DatabaseService();
  _DetailsState({Key key, @required this.img, @required this.days});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user == null){
      return  SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.8,
                  child: Container(
                    height: MediaQuery.of(context).size.height + 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: linearcolor()
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return PerscriptionUpload(back: 'customer',);
                          }));
                    },
                  ),
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 5 * SizeConfig.heightMultiplier,
                          left: 6 * SizeConfig.heightMultiplier,
                          right: 6 * SizeConfig.heightMultiplier,
                          top: 55),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          //name
                          Opacity(
                            opacity: 0.6,
                            child: new Container(
                              child: new Center(
                                  child: new TextFormField(
                                      decoration: form(context, 'Fullname',
                                          Icons.person),


                                      validator: (input) => input.isEmpty
                                          ? 'Please type your full name here'
                                          : null,
                                      onChanged: (input) {




                                        setState(() {

                                          fullname = input;
                                        });
                                      },
                                      keyboardType: TextInputType.text,
                                      style: Theme.of(context)
                                          .textTheme
                                          .display1)),
                            ),
                          ),

                          //Address
                          Opacity(
                            opacity: 0.6,
                            child: Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Container(
                                child: new Center(
                                    child: new TextFormField(

                                        decoration: form(
                                            context, "Address", Icons.home),
                                        validator: (input) => input.isEmpty
                                            ? 'Please type your address here'
                                            : null,
                                        onChanged: (input) {
                                          setState(() {
                                            firstlineaddress = input;
                                          });
                                        },
                                        keyboardType: TextInputType.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1)),
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: .6,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 25,
                              ),
                              child: Container(
                                child: new Center(
                                    child: new TextFormField(

                                        decoration: form(context,
                                            "Hometown", Icons.home),
                                        validator: (input) => input.isEmpty
                                            ? 'Please type your address here'
                                            : null,
                                        onChanged: (input) {
                                          setState(() {
                                            hometown = input;

                                          });
                                        },
                                        keyboardType: TextInputType.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1)),
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: .6,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 25,
                              ),
                              child: Container(
                                child: new Center(
                                    child: new TextFormField(

                                        decoration: form(context,
                                            "Email", Icons.email),

                                        onChanged: (input) {
                                          setState(() {
                                            email = input;

                                          });
                                        },
                                        keyboardType: TextInputType.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1)),
                              ),
                            ),
                          ),

                          // TP NUMBER
                          Opacity(
                            opacity: 0.6,
                            child: Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Container(
                                child: new Center(
                                    child: new TextFormField(

                                        decoration: form(
                                            context,
                                            "Telephone Number",
                                            Icons.phone),
                                        validator: (input) => input
                                            .length !=
                                            10
                                            ? 'Your telephone number is incorrect'
                                            : null,
                                        onChanged: (input) {
                                          setState(() {
                                            telenumber = input;
                                          });
                                        },
                                        keyboardType: TextInputType.phone,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1)),
                              ),
                            ),
                          ),

                          Opacity(
                            opacity: 0.6,
                            child: Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Container(
                                child: new Center(
                                    child: new TextFormField(
                                        decoration: form(
                                            context,
                                            "Special Description(optional)",
                                            Icons.add),
                                        onChanged: (input) {
                                          setState(() {
                                            specialDescription = input;

                                          });
                                        },
                                        keyboardType: TextInputType.text,
                                        maxLines: 7,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1)),
                              ),
                            ),
                          ),

                          // button
                          Padding(
                            padding: EdgeInsets.only(top: 34, bottom: 20),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Material(
                                  borderRadius: BorderRadius.circular(
                                      4 * SizeConfig.heightMultiplier),
                                  elevation: 7.0,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder:
                                              (BuildContext context) {
                                            return PerscriptionUpload();
                                          }));
                                    },
                                    child: Container(
                                      height: 40,
                                      width:
                                      15 * SizeConfig.heightMultiplier,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFE3F2FD),
                                          borderRadius:
                                          BorderRadius.circular(4 *
                                              SizeConfig
                                                  .heightMultiplier),
                                          border: Border.all(
                                              color: Color(0xFF185a9d),
                                              style: BorderStyle.solid,
                                              width: 2.0)),
                                      child: Center(
                                        child: Text("back",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead
                                                .copyWith(
                                                color:
                                                Color(0xFF185a9d))),
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  borderRadius: BorderRadius.circular(
                                      5 * SizeConfig.heightMultiplier),
                                  elevation: 4.0,
                                  child: InkWell(
                                    onTap: () async {
                                      if (_formKey.currentState
                                          .validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        print(fullname);
                                        String imageUrl;

                                        final FirebaseStorage storage =
                                            FirebaseStorage.instance;
                                        final String picture =
                                            '1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
                                        StorageUploadTask task = storage
                                            .ref()
                                            .child(picture)
                                            .putFile(img);

                                        StorageTaskSnapshot snapshot =
                                        await task.onComplete.then(
                                                (snapshot) => snapshot);
                                        task.onComplete
                                            .then((snapshot) async {
                                          imageUrl = await snapshot.ref
                                              .getDownloadURL();
                                          print(firstlineaddress);

                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (BuildContext context) {
                                                return Preview(fullname: fullname,
                                                    firstlineaddress: firstlineaddress,
                                                    telenumber: telenumber,
                                                    email: email==null?"":email,
                                                    hometown: hometown,
                                                    days: days==null?0:days, images: imageUrl
                                                    , specialDescription: specialDescription.isEmpty?'':specialDescription);
                                              }));

                                        });

                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width:
                                      15 * SizeConfig.heightMultiplier,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            const Color(0xFF185a9d),
                                            const Color(0xFF43cea2)
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            5 *
                                                SizeConfig
                                                    .heightMultiplier),
                                      ),
                                      child: Center(
                                        child: Text("Preview",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }else{
    return StreamBuilder<User>(
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

          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.8,
                      child: Container(
                        height: MediaQuery.of(context).size.height + 130,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: linearcolor()
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return PerscriptionUpload(back: "User",);
                          }));
                        },
                      ),
                    ),
                    Container(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: 5 * SizeConfig.heightMultiplier,
                              left: 6 * SizeConfig.heightMultiplier,
                              right: 6 * SizeConfig.heightMultiplier,
                              top: 55),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              //name
                              Opacity(
                                opacity: 0.6,
                                child: new Container(
                                  child: new Center(
                                      child: new TextFormField(
                                          decoration: form(context, 'Fullname',
                                              Icons.person),

                                          initialValue: profile.fullname,
                                          validator: (input) => input.isEmpty
                                              ? 'Please type your full name here'
                                              : null,
                                          onChanged: (input) {
                                            print(input);



                                            setState(() {
                                              fullname=profile.fullname;
                                              fullname = input;
                                            });
                                          },
                                          keyboardType: TextInputType.text,
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1)),
                                ),
                              ),

                              //Address
                              Opacity(
                                opacity: 0.6,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: Container(
                                    child: new Center(
                                        child: new TextFormField(
                                            initialValue:(profile.address=='address')?null: profile.address,
                                            decoration: form(
                                                context, "Address", Icons.home),
                                            validator: (input) => input.isEmpty
                                                ? 'Please type your address here'
                                                : null,
                                            onChanged: (input) {
                                              setState(() {
                                                firstlineaddress = input;
                                              });
                                            },
                                            keyboardType: TextInputType.text,
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1)),
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: .6,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 25,
                                  ),
                                  child: Container(
                                    child: new Center(
                                        child: new TextFormField(
                                            initialValue: (profile.hometown=='hometown')?null:profile.hometown,
                                            decoration: form(context,
                                                "Hometown", Icons.home),
                                            validator: (input) => input.isEmpty
                                                ? 'Please type your hometown here'
                                                : null,
                                            onChanged: (input) {
                                              setState(() {
                                                hometown = input;

                                              });
                                            },
                                            keyboardType: TextInputType.text,
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1)),
                                  ),
                                ),
                              ),

                              // TP NUMBER
                              Opacity(
                                opacity: 0.6,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: Container(
                                    child: new Center(
                                        child: new TextFormField(
                                            initialValue: (profile.telenumber=='telenumber')?null:profile.telenumber,
                                            decoration: form(
                                                context,
                                                "Telephone Number",
                                                Icons.phone),
                                            validator: (input) => input
                                                        .length !=
                                                    10
                                                ? 'Your telephone number is incorrect'
                                                : null,
                                            onChanged: (input) {
                                              setState(() {
                                                telenumber = input;
                                              });
                                            },
                                            keyboardType: TextInputType.phone,
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1)),
                                  ),
                                ),
                              ),

                              Opacity(
                                opacity: 0.6,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: Container(
                                    child: new Center(
                                        child: new TextFormField(
                                            decoration: form(
                                                context,
                                                "Special Description(optional)",
                                                Icons.add),
                                            onChanged: (input) {
                                              setState(() {
                                                specialDescription = input;

                                              });
                                            },
                                            keyboardType: TextInputType.text,
                                            maxLines: 7,
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1)),
                                  ),
                                ),
                              ),

                              // button
                              Padding(
                                padding: EdgeInsets.only(top: 34, bottom: 20),
                                child: Material(
                                  borderRadius: BorderRadius.circular(
                                      5 * SizeConfig.heightMultiplier),
                                  elevation: 4.0,
                                  child: InkWell(
                                    onTap: () async {

                                      if (_formKey.currentState
                                          .validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        print(fullname);
                                        String imageUrl;

                                        final FirebaseStorage storage =
                                            FirebaseStorage.instance;
                                        final String picture =
                                            '1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
                                        StorageUploadTask task = storage
                                            .ref()
                                            .child('/perscriptions/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg')
                                            .putFile(img);

                                        StorageTaskSnapshot snapshot =
                                            await task.onComplete.then(
                                                (snapshot) => snapshot);
                                        task.onComplete
                                            .then((snapshot) async {
                                          imageUrl = await snapshot.ref
                                              .getDownloadURL();
                                          print(firstlineaddress);

                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (BuildContext context) {
                                                return Preview(fullname: fullname.isEmpty?profile.fullname:fullname,
                                                    firstlineaddress: firstlineaddress.isEmpty?profile.address:firstlineaddress,
                                                    telenumber: telenumber.isEmpty?profile.telenumber:telenumber,
                                                    email: profile.email,
                                                    hometown: hometown.isEmpty?profile.hometown:hometown,
                                                    days: days==null?0:days, images: imageUrl
                                                    , specialDescription: specialDescription.isEmpty?'':specialDescription);
                                              }));

                                        });

                                      }
                                    },
                                    child:buttonContainer(context,'Preview', 43, 130)

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }}
}




