import 'package:medicare/commanpages/commonWidgets.dart';
import 'package:medicare/module/user.dart';
import 'package:medicare/userdetails/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:medicare/perscriptionOder/uploadperscription.dart';
import 'package:medicare/database/perscription.dart';
import 'package:medicare/mainpages/tabhomepage.dart';
import 'package:intl/intl.dart';

class Preview extends StatefulWidget {
  final String fullname;
  final String firstlineaddress;
  final String telenumber;
  final String email;
  final String hometown;
  final int days;

  final String specialDescription;
  final String images;

  Preview(
      {Key key,
      @required this.fullname,
      @required this.firstlineaddress,
      @required this.telenumber,
      @required this.email,
      @required this.hometown,
      @required this.days,
      @required this.images,
      @required this.specialDescription})
      : super(key: key);
  @override
  _PreviewState createState() => _PreviewState(
      specialDescription: specialDescription,
      fullname: fullname,
      firstlineaddress: firstlineaddress,
      email: email,
      days: days,
      telenumber: telenumber,
      hometown: hometown,
      images: images);
}

class _PreviewState extends State<Preview> {
  String fullname;
  final String firstlineaddress;
  final String telenumber;
  final String email;
  final String hometown;
  final int days;

  final String specialDescription;
  final String images;
  String perscriptionkey;
  PerscriptionOrder _perscriptionOrder = PerscriptionOrder();
  _PreviewState(
      {Key key,
      @required this.fullname,
      @required this.firstlineaddress,
      @required this.telenumber,
      @required this.email,
      @required this.hometown,
      @required this.days,
      @required this.images,
      @required this.specialDescription});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:a');
    final String formatted = formatter.format(now);

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height / 2,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text("Submit Your Order",
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            color: Color(0xFF185a9d),
                          )),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF185a9d),
                    ),
                    onPressed: () {
                      if(user==null){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return PerscriptionUpload(back:"Customer");
                            }));
                      }else{
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return PerscriptionUpload(back:"User");
                      }));
                    }}
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                    images,
                    fit: BoxFit.fill,
                  )),
                ),
              ];
            },
            body: Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text(
                        fullname,
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      firstlineaddress,
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      hometown,
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      telenumber,
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(
                      email,
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Row(
                      children: <Widget>[
                        Text(
                          days.toString(),
                          style: Theme.of(context).textTheme.display1,
                        ),
                        Text(
                          '(optional)'.toString(),
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '(optional)'.toString(),
                          style: Theme.of(context).textTheme.display1,
                        ),
                        Text(
                          specialDescription,
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ],
                    ),
                  ),
                  // button
                  Padding(
                    padding: EdgeInsets.only(
                        top: 34, bottom: 20, left: 15, right: 15),
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
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    height: 170.0,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 20.0),
                                          child: Text(
                                            "We will send you to an email  about \n prices of your orders",
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(30.0),
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                            elevation: 4.0,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(22.0),
                                              onTap: () async {
                                                _perscriptionOrder
                                                    .createPerscriptionOrder(
                                                        fullname,
                                                        firstlineaddress,
                                                        telenumber,
                                                        email,
                                                        hometown,
                                                        days,
                                                        specialDescription,
                                                        images,
                                                        'pending',
                                                        formatted);
                                                if (user == null) {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Tabcontroller(0)),
                                                      (route) => false);
                                                } else {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UserHome()),
                                                      (route) => false);
                                                }
                                              },
                                              child:buttonContainer(context, "Okey", 43, 100)

                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: buttonContainer(context, "Submit", 43, null)

                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
