import 'package:medicare/commanpages/commonWidgets.dart';
import 'package:medicare/userdetails/home.dart';
import 'package:flutter/material.dart';
import 'package:medicare/userdetails/history.dart' as firstpage;
import 'package:medicare/perscriptionOder/perscriptionhistory.dart'as secondpage;
class OrderTab extends StatefulWidget {
  @override
  _OrderTabState createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab>with SingleTickerProviderStateMixin{
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
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

        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  gradient: linearcolor()
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserHome()));

                      },
                    ),
                  ),
                  TabBar(
                    indicatorColor: Colors.amber,
                    labelColor: Colors.white,
                    controller: controller,
                    tabs: <Widget>[
                      tab("https://icons-for-free.com/iconfiles/png/512/buy+cart+online+shopping+shop+shopping+shopping+basket+icon-1320191078019322255.png"),
                      tab('https://image.flaticon.com/icons/png/512/1560/1560913.png'),

                    ],
                  ),
                ],
              ),
            ),
          ),
          body: new TabBarView(
            controller: controller,
            children: <Widget>[
              new firstpage.History(),
              new secondpage.PerscriptionHistory()
            ],
          ),
        ),
      ),
    );
  }
}

Widget tab(String name){
  return Tab(
    icon: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Image(
          image: NetworkImage(
              name
          ),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}