import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/footer.dart';
import 'package:medicare/mainpages/tabhomepage.dart';
import 'package:medicare/userdetails/home.dart';
import 'package:medicare/userdetails/settings/myaccount.dart';
import 'package:medicare/commanpages/commonWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicare/services/authentication.dart';
import 'package:medicare/services/database.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height / 5 * 2,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF185a9d),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return UserHome();
                      }));
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                    "https://media.consumeraffairs.com/files/news/Cybersecurity_and_digital_security_concept_HYWARDS_Getty_Images.jpg",
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
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Myaccount()));
                        },
                        child: listbar(
                            context,
                            "Update your personal information",
                            Icons.account_circle)),
                  ),
                  Divider(),
                  listbar(context, "Change your password", Icons.vpn_key),
                  Divider(),
                  InkWell(
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                elevation: 0.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: SingleChildScrollView(
                                    child: Container(
                                        color: Color(0xFFE3F2FD),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20.0, bottom: 20.0),
                                              child: Text('Delete Account',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10.0, bottom: 20.0),
                                              child: Text(
                                                  'After you delete an account, it\'s permanently deleted. Accounts can\'t be undeleted.',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
                                                          color: Colors.red)),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    elevation: 7.0,
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xFFE3F2FD),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xFF185a9d),
                                                                style:
                                                                    BorderStyle
                                                                        .solid,
                                                                width: 2.0)),
                                                        child: Center(
                                                          child: Text("Back",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subhead
                                                                  .copyWith(
                                                                      color: Color(
                                                                          0xFF185a9d))),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    elevation: 7.0,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        FirebaseUser user =
                                                            await FirebaseAuth
                                                                .instance
                                                                .currentUser();
                                                        await DatabaseService(
                                                                uid: user.uid)
                                                            .deleteuser();
                                                        user.delete();

                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    Tabcontroller(
                                                                        2)));
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                style:
                                                                    BorderStyle
                                                                        .solid,
                                                                width: 2.0)),
                                                        child: Center(
                                                          child: Text("Delete",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subhead
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                        )),
                                  ),
                                ),
                              );
                            });
                      },
                      child:
                          listbar(context, "Delete your Account", Icons.delete))
                ],
              ),
            )),
      ),
    );
  }
}
