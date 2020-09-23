
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:medicare/userdetails/cart.dart';
import 'package:medicare/userdetails/services.dart';
import 'package:medicare/services/authentication.dart';

import 'package:medicare/userdetails/myaccount.dart';
import 'package:medicare/module/user.dart';
import 'package:provider/provider.dart';
import 'package:medicare/services/database.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();

}


class _UserHomeState extends State<UserHome> {

  final DatabaseService databaseService = DatabaseService();
  final AuthService _auth=AuthService();

  GlobalKey <ScaffoldState>_key=GlobalKey();
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context, listen: false);
    return  SafeArea(
      child: StreamBuilder<User>(
        stream: DatabaseService(uid: user.userkey).profileData,
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
                  tileMode: TileMode.repeated,
                ),
              ),
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10.0),
                child:CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),

                )
            );
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
                    accountName: Text(profile.fullname),
                    accountEmail: Text(profile.email),
                    currentAccountPicture: GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: Colors.white70,
                       child: Icon(Icons.person,color: Colors.blueGrey,size: 50,)
                      ),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
                        tileMode: TileMode.repeated,
                      ),
                    ),
                  ),// homepage


                          //home

                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserHome()));
                      },
                    child: ListTile(
                      title: Text("New order",style: Theme.of(context).textTheme.display1),
                      leading: Icon(Icons.shopping_basket,color:Colors.blueGrey ,size: 5*SizeConfig.heightMultiplier),
                    ),
                  ),

                  Divider(color: Colors.blueGrey,),

                                    //history

                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductCartlist()));},
                      child: ListTile(
                        title: Text("My Cart",style: Theme.of(context).textTheme.display1),
                        leading: Icon(Icons.shopping_cart,color:Colors.blueGrey,size: 5*SizeConfig.heightMultiplier),
                      ),
                    ),

                  Divider(color: Colors.blueGrey),


                                    //details
                  InkWell(
                    onTap: (){

                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Myaccount()));},
                    child: ListTile(
                      title: Text("My account",style: Theme.of(context).textTheme.display1),
                      leading: Icon(Icons.person,color: Colors.blueGrey,size: 5*SizeConfig.heightMultiplier),
                    ),),
                  Divider(color: Colors.blueGrey),


                                      //cart
                 InkWell(
                   onTap: (){
                   // Navigator.of(context).pop();
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AskQ()));
                    },
                   child: ListTile(
                     title: Text(" Favourite",style: Theme.of(context).textTheme.display1,),
                     leading: Icon(Icons.favorite,color: Colors.blueGrey,size: 5*SizeConfig.heightMultiplier),
                   ),
                 ),

                  Divider(color: Colors.blueGrey,),


                                  //logout
                  InkWell(
                    onTap: ()async{
                      await _auth.signOut(context);



                         },
                    child: ListTile(
                      title: Text("Logout",style: Theme.of(context).textTheme.display1),
                      leading: Icon(Icons.arrow_back,color: Colors.blueGrey,size: 5*SizeConfig.heightMultiplier),
                      ),
                     ),
                   ],
                      ),),),
            appBar: _customAppBar(_key,context),
            body:Services(),

          );
        }
      ),
    );
  }
}



Widget  _customAppBar(GlobalKey<ScaffoldState> globalKey,BuildContext context){
  return PreferredSize(
    preferredSize: Size.fromHeight(12*SizeConfig.heightMultiplier),
    child: Material(
      elevation: 0.0,
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
        ),
        child: Padding(
          padding:  EdgeInsets.only(left:2.2*SizeConfig.widthMultiplier,right:5*SizeConfig.widthMultiplier ),
          child: Center(
            child: Row(

              children: <Widget>[
                IconButton(icon: Icon(Icons.list,color: Colors.white,size: 5*SizeConfig.heightMultiplier,),
                  onPressed: (){
                    globalKey.currentState.openDrawer();

                  },),



              ],
            ),
          ),
        ),),
    ),
  );
}


