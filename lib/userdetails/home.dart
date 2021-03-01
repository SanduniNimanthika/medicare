import 'package:flutter/material.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:medicare/mainpages/tabhomepage.dart';
import 'package:medicare/userdetails/cart.dart';
import 'package:medicare/userdetails/ordertab.dart';
import 'package:medicare/userdetails/services.dart';
import 'package:medicare/services/authentication.dart';
import 'package:medicare/userdetails/history.dart';
import 'package:medicare/userdetails/settings/myaccount.dart';
import 'package:medicare/module/user.dart';
import 'package:medicare/userdetails/settings/settings.dart';
import 'package:provider/provider.dart';
import 'package:medicare/services/database.dart';
import 'package:medicare/commanpages/commonWidgets.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final DatabaseService databaseService = DatabaseService();
  final AuthService _auth = AuthService();

  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return SafeArea(
      child: StreamBuilder<User>(
          stream: DatabaseService(uid: user.userkey).profileData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {

              return Tabcontroller(1);
              /*Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF185a9d),
                        const Color(0xFF43cea2)
                      ],
                      tileMode: TileMode.repeated,
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10.0),
                  child:InkWell(
                    onTap: (){

                    },
                    child: Container(child: Text("fgfg")),
                  )
                /* CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  )*/
              );*/
            }
            final profile = snapshot.data;
            return Scaffold(
              key: _key,
              drawer: Drawer(
                // linear background
                child: Container(
                  color: Color(0xFFE3F2FD),
                  child: ListView(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        accountName: Text(profile.fullname,style:Theme.of(context).textTheme.display1.copyWith(color:Colors.white70) ,),
                        accountEmail: Text(profile.email,style: Theme.of(context).textTheme.display1.copyWith(color:Colors.white70),),
                        currentAccountPicture: GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                backgroundColor: Colors.white70,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.blueGrey,
                                  size: 50,
                                )),
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF185a9d),
                              const Color(0xFF43cea2)
                            ],
                            tileMode: TileMode.repeated,
                          ),
                        ),
                      ), // homepage

                      //home

                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserHome()));
                          },
                          child: listbar(
                              context, "New order", Icons.shopping_basket)),

                      Divider(
                        color: Colors.blueGrey,
                      ),

                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductCartlist()));
                          },
                          child:
                              listbar(context, "My cart", Icons.shopping_cart)),

                      Divider(
                        color: Colors.blueGrey,
                      ),

                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OrderTab()));
                          },
                          child: listbar(context, "My history", Icons.history)),

                      Divider(color: Colors.blueGrey),

                      InkWell(
                          onTap: () {
                            // Navigator.of(context).pop();
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AskQ()));
                          },
                          child: listbar(
                            context,
                            " Favourite",
                            Icons.favorite,
                          )),
                      //details

                      Divider(
                        color: Colors.blueGrey,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Settings()));
                          },
                          child: listbar(
                              context, "Account Security", Icons.settings)),
                      Divider(color: Colors.blueGrey),

                      //logout
                      InkWell(
                          onTap: () async {
                            await _auth.signOut(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Tabcontroller(1)));
                          },
                          child: listbar(context, "Logout", Icons.arrow_back)),
                    ],
                  ),
                ),
              ),
              appBar: _customAppBar(_key, context),
              body: Services(),
            );
          }),
    );
  }
}

Widget _customAppBar(GlobalKey<ScaffoldState> globalKey, BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(12 * SizeConfig.heightMultiplier),
    child: Material(
      elevation: 0.0,
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          gradient: linearcolor()
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: 2.2 * SizeConfig.widthMultiplier,
              right: 5 * SizeConfig.widthMultiplier),
          child: Center(
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.list,
                    color: Colors.white,
                    size: 5 * SizeConfig.heightMultiplier,
                  ),
                  onPressed: () {
                    globalKey.currentState.openDrawer();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
