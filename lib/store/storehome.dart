import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:medicare/userdetails/home.dart';

class Storehome extends StatefulWidget {
  @override
  _StorehomeState createState() => _StorehomeState();
}

class _StorehomeState extends State<Storehome> {

  GlobalKey <ScaffoldState>_key=GlobalKey();
  @override
  Widget build(BuildContext context) {

    // image carousel
    Widget _imageCarousel= Carousel(

      boxFit: BoxFit.fill,
      images: [
        AssetImage("images/mainpages/welcome.png"),
        AssetImage("images/mainpages/welcome.png"),
        AssetImage("images/mainpages/welcome.png"),

      ],
      autoplay: true,
      autoplayDuration: Duration(seconds: 30),
      dotSize: 6.0,
      showIndicator: true,
      indicatorBgPadding: 8.0,
      dotBgColor: Colors.transparent,
    );
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(

          // linear background
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
                tileMode: TileMode.repeated,
              ),
            ),
            child: ListView(
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(top: 7*SizeConfig.heightMultiplier,bottom: 7*SizeConfig.heightMultiplier),
                  child: ListTile(
                    title:Text("Product Categories",
                        style: Theme.of(context).textTheme.title),

                  ),
                ),



                InkWell(
                  onTap: (){
                 //   Navigator.of(context).pop();
                 //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
                  },
                  child: ListTile(
                    title: Text("Skin Care",style: Theme.of(context).textTheme.subhead),
                  ),
                ),

                Divider(color: Colors.white,),


                //order instruction
                InkWell(
                  child: ListTile(
                    title: Text("How to order",style: Theme.of(context).textTheme.subhead),
                    leading: Icon(Icons.question_answer,color:Colors.white,size: 5*SizeConfig.heightMultiplier),
                  ),
                ),

                Divider(color: Colors.white,),


                // services
                InkWell(
                  onTap: (){
                //    Navigator.of(context).pop();
                //    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Services()));
                  },
                  child: ListTile(
                    title: Text("Our services",style: Theme.of(context).textTheme.subhead),
                    leading: Icon(Icons.shopping_basket,color: Colors.white,size: 5*SizeConfig.heightMultiplier),
                  ),
                ),

                Divider(color: Colors.white,),


                // questions
                InkWell(
                  onTap: (){
                //    Navigator.of(context).pop();
                //    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AskQ()));
                  },
                  child: ListTile(
                    title: Text(" FAQs",style: Theme.of(context).textTheme.subhead,),
                    leading: Icon(Icons.help,color: Colors.white,size: 5*SizeConfig.heightMultiplier),
                  ),
                ),

                Divider(color: Colors.white,),


                //contact
                InkWell(
                  onTap: (){
               //     Navigator.of(context).pop();
                //    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ContactPage()));
                  },
                  child: ListTile(
                    title: Text("Contact",style: Theme.of(context).textTheme.subhead),
                    leading: Icon(Icons.contacts,color: Colors.white,size: 5*SizeConfig.heightMultiplier),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: _customAppBar(_key, context),
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                child: _imageCarousel,
              height: (MediaQuery.of(context).size.height/5)*2,
              width: MediaQuery.of(context).size.width
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text("Product Categories",style: Theme.of(context).textTheme.subtitle,),
            ),
          ],
        ) ,


                    //floating button
        floatingActionButton:FloatingActionButton(
          onPressed: (){

            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserHome()));
          },
          elevation: 7.0,
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
                ),
                borderRadius: BorderRadius.circular(27.0)
            ),
            child: Center(
              child: Image(
                image: AssetImage("images/mainpages/pres.png"),
                height: 45.0,
              ),
            ),
          ),backgroundColor:Color(0xFFE3F2FD) ,),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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