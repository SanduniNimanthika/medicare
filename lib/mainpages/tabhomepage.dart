import 'package:flutter/material.dart';
import 'package:medicare/mainpages/homepage.dart' as firstpage;
import 'package:medicare/mainpages/AskQ.dart'as secondpage;
import 'package:medicare/mainpages/contact.dart' as thirdpage;
import 'package:medicare/loginSignup/welcome.dart' as fourthpage;
import 'package:medicare/commanpages/configue.dart';


class Tabcontroller extends StatefulWidget {
 final int selectedPage;
  Tabcontroller( this.selectedPage);
  @override
  _TabcontrollerState createState() => _TabcontrollerState(selectedPage);
}

class _TabcontrollerState extends State<Tabcontroller>with SingleTickerProviderStateMixin{
final  int selectedPage;
  _TabcontrollerState(this.selectedPage);
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller=new TabController(length: 4, vsync: this);
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: selectedPage,
        length: 4,
        child: Scaffold(
          appBar:PreferredSize(
            preferredSize: Size.fromHeight(14*SizeConfig.heightMultiplier),
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],

                ),
              ),
              child:TabBar(
                indicatorColor: Colors.amber,
                labelColor:Colors.white,
                controller: controller,
                tabs: <Widget>[
                  new Tab(icon: new Icon(Icons.home,),),
                  new Tab(icon: new Icon(Icons.help),),
                  new Tab(icon: new Icon(Icons.phone),),
                  new Tab(icon: new Icon(Icons.account_circle),),

                ],
              ),),
          ) ,
         /* bottomNavigationBar:Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF185a9d),
                  const Color(0xFF43cea2)
                ],
              ),
            ),
            child: TabBar(
              indicatorColor: Colors.amber,
              labelColor:Colors.white,
              controller: controller,
              tabs: <Widget>[
                new Tab(icon: new Icon(Icons.home,),),
                new Tab(icon: new Icon(Icons.help),),
                new Tab(icon: new Icon(Icons.phone),),
                new Tab(icon: new Icon(Icons.account_circle),),

              ],
            ),
          ) ,*/
          body: new TabBarView(
            controller: controller,
            children: <Widget>[
              new firstpage.HomePage(),
              new secondpage.AskQ(),
              new thirdpage.ContactPage(),
              new fourthpage.Welcome(),
            ],
          ),
        ),
      ),
    );
  }
}


