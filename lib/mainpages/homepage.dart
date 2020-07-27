import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import 'package:medicare/commanpages/textstyle.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:medicare/commanpages/responsive.dart';




        //mainpages
import 'package:medicare/mainpages/services.dart';
import 'package:medicare/mainpages/AskQ.dart';
import 'package:medicare/mainpages/contact.dart';
import 'package:medicare/loginSignup/welcome.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey <ScaffoldState>_key=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: buildDrawer(context),
        appBar: _customAppBar(_key,context),
        backgroundColor: AppTheme.appBackgroundColor,
        body: SingleChildScrollView(
                child: Column(
                    children: <Widget>[

                                           //head

                      Container(
                          decoration: BoxDecoration(
                           // color: Color(0xFFBBDEFB),
                          ),
                          constraints: BoxConstraints(
                            maxHeight: 40*(SizeConfig.isMobilePortrait? SizeConfig.heightMultiplier:SizeConfig.widthMultiplier)),
                          child: Stack(
                            children: <Widget>[
                              FractionallySizedBox(
                                alignment: Alignment.topCenter,
                                heightFactor: 0.9,
                                child: ClipPath(
                                  clipper: ClippingPath(),
                                  child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      end: Alignment.bottomRight,
                                      colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
                                  ),
                            ),
                                )
                              ),
                              Center(
                                child: Image(
                                  image: AssetImage("images/mainpages/familyhealth.png"),
                                  height: 83.3* SizeConfig.imageSizeMultiplier,
                                  width: 83.3*SizeConfig.imageSizeMultiplier,
                                ),
                              ),
                            ],
                          ),
                        ),



                                          // body

                      
                          Container(
                              constraints: BoxConstraints(
                                  maxHeight: 300*(SizeConfig.isMobilePortrait? SizeConfig.heightMultiplier:(SizeConfig.widthMultiplier+1.5))
                              ),
                            child:Responsive(
                              landscapeLayout: LandscapeDisplay(),
                              portraitLayout: PortraitDisplay(),
                            )
                          ),

                    ],
                  ),
              ),

      ),
    );
  }
}



                            //portrait

class  PortraitDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        Expanded(
          flex: 2,
            child:_bodyDescription(context,Strings.welcometitle ,
                Strings.welcomedes)),
        Expanded(
          flex: 1,
          child:Image(
            image: AssetImage("images/mainpages/welcome.png"),
            height: 40* SizeConfig.imageSizeMultiplier,
            width: 40*SizeConfig.imageSizeMultiplier,
          ),
        ),


        Expanded(
          flex: 2,
          child:_bodyDescription(context,Strings.pretitle,
             Strings.predes)
        ),
        Expanded(
          flex: 2,
          child:Column(
            children: <Widget>[
              Image(
                image: AssetImage("images/mainpages/prescription.png"),
                height: 40* SizeConfig.imageSizeMultiplier,
                width: 40*SizeConfig.imageSizeMultiplier,
              ),
              Material(
                borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                elevation: 7.0,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Welcome()));
                  },
                  child: Container(
                    height: 6.7*SizeConfig.heightMultiplier,
                    width: 29*SizeConfig.heightMultiplier,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
                      borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                    ),
                    child: Center(
                      child: Text("Upload perscription",
                          style:Theme.of(context).textTheme.subhead),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
          Expanded(
          flex: 2,
            child:_bodyDescription(context, Strings.healthtitle,
              Strings.healthdes)
    ),
          Expanded
          (
            flex: 2,
              child:Column(
              children: <Widget>[
                Image(
                image: AssetImage("images/mainpages/OnlineStore.png"),
                height: 40* SizeConfig.imageSizeMultiplier,
                width: 60*SizeConfig.imageSizeMultiplier,
                ),
                Material(
                  borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                  elevation: 7.0,
                  child: InkWell(
                    onTap: (){
                    //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Welcome()));
                    },
                    child: Container(
                      height: 6.7*SizeConfig.heightMultiplier,
                      width: 15*SizeConfig.heightMultiplier,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
                        borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                      ),
                      child: Center(
                        child: Text("Shop now",
                            style:Theme.of(context).textTheme.subhead),
                      ),
                    ),
                  ),
                )
              ],
              ),
          ),
          

          Expanded(
            flex: 6,
           child: Whychoose()
         ),
      ],
    );
  }
}



                            //landscape

class LandscapeDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage("images/mainpages/welcome.png"),
                    height: 40* SizeConfig.heightMultiplier,
                    width: 40*SizeConfig.heightMultiplier,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                    children:<Widget>[
                      Column(
                        children: <Widget>[
                          _bodyDescription(context, Strings.welcometitle, Strings.welcomedes),
                        ],
                      )]),
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Column(
                    children:<Widget>[
                      Column(
                        children: <Widget>[
                          _bodyDescription(context, Strings.pretitle, Strings.predes),
                            Material(
                            borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                            elevation: 7.0,
                                child: InkWell(
                                    onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Welcome()));
                                    },
                                  child: Container(
                                      height: 6.7*SizeConfig.heightMultiplier,
                                      width: 29*SizeConfig.heightMultiplier,
                                      decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
                                      borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                                      ),
                                        child: Center(
                                         child: Text("Upload perscription",
                                            style:Theme.of(context).textTheme.subhead),
                                            ),
                                            ),
                                            ),
                                            )
                                                                ],
                      )]),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding:  EdgeInsets.only(right:3*SizeConfig.heightMultiplier),
                  child: Image(
                    image: AssetImage("images/mainpages/prescription.png"),
                    height: 40* SizeConfig.heightMultiplier,
                    width: 40*SizeConfig.heightMultiplier,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: 3*SizeConfig.heightMultiplier),
                  child: Image(
                    image: AssetImage("images/mainpages/OnlineStore.png"),
                    height: 50* SizeConfig.heightMultiplier,
                    width: 50*SizeConfig.heightMultiplier,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                    children:<Widget>[
                      Column(
                        children: <Widget>[
                          _bodyDescription(context, Strings.healthtitle, Strings.healthdes),
                          Material(
                            borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                            elevation: 7.0,
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Welcome()));
                              },
                              child: Container(
                                height: 6.7*SizeConfig.heightMultiplier,
                                width: 15*SizeConfig.heightMultiplier,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
                                  borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                                ),
                                child: Center(
                                  child: Text("Shop now",
                                      style:Theme.of(context).textTheme.subhead),
                                ),
                              ),
                            ),
                          )
                        ],
                      )]),
              )
            ],
          ),
        ),
        Expanded(
            flex: 4,
            child: Whychoose()
        ),
      ],
    );
  }
}


                       //string of page

class Strings {
  Strings._();
  static const String welcometitle="Welcome to Medicare";
  static const String welcomedes="\t Medicare is the only online pharmacy in compliance with "
  "regulatory guidelines (National Medicines Regulatory Authority)in Sri Lanka. Medicare is the pharmacy of the future which allows online purchase of prescription"
      " medication and health product with door-step delivery.";

  static const String pretitle= "Prescription medication";
  static const String predes= "\t      Upload photo of your prescription  issued "
      "by a SLMC registered doctor. We deliver medicine to your doorstep."
      "MedicarePharmacy works with your doctor or pharmacist to take care of transfers, refill requests, and more. ";

  static const String healthtitle="Health care product";
  static const String healthdes= "\t      Enhance your physical and mental with our health care products."
      "Checkout our product store and order as you wish.WE produce products with supposed health benefits, such as a supplement, herbal medicine , probiotic , etc.";

}



                            //body des

Widget _bodyDescription (BuildContext context,String topic,String des){
  return Padding(
    padding:  EdgeInsets.all(6*SizeConfig.widthMultiplier),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(topic,
          style: Theme.of(context).textTheme.subtitle,),

        Padding(
          padding:  EdgeInsets.only(left: 3*SizeConfig.widthMultiplier,top: 2.5*SizeConfig.heightMultiplier),
            child: Text(des,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.display1,),
        ),
      ],
    ),
  );
}






                         // why choose
class Whychoose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5*SizeConfig.widthMultiplier),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text("Why choose us",
              style: Theme.of(context).textTheme.subtitle,),
          ),
        ),
        _chooseus(context, "images/mainpages/1-delivery.png",
            "Receive fast delivary",
            "We deliver medication to your doorstep within 24 hours."),
        _chooseus(context,"images/mainpages/cost.png" ,"Lowest price ",
            "Medicines are priced exactly the same as your regular pharmacy."
                "Our products are also sold at the authorized retail price with the added convenience of paying online through Credit/Debit Cards,"
                " Mobile Wallets or Internet Banking." ),
        _chooseus(context, "images/mainpages/cll.png", "licensed pharmacists",
            "Our pharmacists are standing by to answer all of your questions."),
        _chooseus(context, "images/mainpages/pre.png", "We handle your prescriptions for you",
            "Medicare Pharmacy works with your doctor or pharmacist to take care of transfers, refill requests, and more."),

      ],
    );
  }
}

Widget _chooseus (BuildContext context,String img,String name,String des){
  return Padding(
    padding: EdgeInsets.all(1*SizeConfig.heightMultiplier),
    child: Card(
      borderOnForeground: true,
      elevation: 0.8,
      color: Color(0xFFBBDEFB),
      
      child: ListTile(
        contentPadding: EdgeInsets.all(2*SizeConfig.heightMultiplier),
        leading:   Image(
          image: AssetImage(img),
          height: 15* SizeConfig.imageSizeMultiplier,
          width: 15*SizeConfig.imageSizeMultiplier,
        ),
        title: Text( name,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.bold)),

        subtitle:Text( des,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.display1,),

      ),
    ),
  );

}






                        //Drawer
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
          padding:  EdgeInsets.only(left:2.2*SizeConfig.widthMultiplier,right:2.2*SizeConfig.widthMultiplier ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(Icons.list,color: Colors.white,size: 5*SizeConfig.heightMultiplier,),
                  onPressed: (){
                    globalKey.currentState.openDrawer();

                  },),
                Material(
                  elevation: 7.0,
                  borderRadius: BorderRadius.circular(2.2*SizeConfig.heightMultiplier),
                  color: Colors.white70,

                  child: InkWell(
                    onTap: (){},
                    child: Container(
                      height: 6*SizeConfig.heightMultiplier,
                      width: 14*SizeConfig.heightMultiplier,
                      child: Center(
                        child: Text("Sign in",
                            style: Theme.of(context).textTheme.display1.copyWith(color:Color(0xFF1565C0) )),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),),
    ),
  );
}


Widget buildDrawer( context){

  return Drawer(

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
        children: <Widget>[ // homepage
          Padding(
            padding: EdgeInsets.only(top: 7*SizeConfig.heightMultiplier,bottom: 7*SizeConfig.heightMultiplier),
            child: InkWell(
              onTap: (){
                Navigator.of
                  (context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
              },
              child: ListTile(
                title:Text("Medicare",
                    style: Theme.of(context).textTheme.headline),
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/mainpages/pharmacylogo.jpg"),
                ),
              ),
            ),
          ),


          // homepage
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
            },
            child: ListTile(
              title: Text("Home",style: Theme.of(context).textTheme.subhead),
              leading: Icon(Icons.home,color: Colors.white,size: 5*SizeConfig.heightMultiplier),
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
              Navigator.of(context).pop();
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Services()));
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
              Navigator.of(context).pop();
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AskQ()));
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
              Navigator.of(context).pop();
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ContactPage()));
            },
            child: ListTile(
              title: Text("Contact",style: Theme.of(context).textTheme.subhead),
              leading: Icon(Icons.contacts,color: Colors.white,size: 5*SizeConfig.heightMultiplier),
            ),
          ),
        ],
      ),
    ),
  );

}




class ClippingPath extends CustomClipper<Path>{
  @override
  Path getClip (Size size){
    var path= Path();
    path.lineTo(0.0, size.height/1.5);
    var firstControlPoint=Offset(size.width/4,size.height);
    var firstEndPoint=Offset(size.width/2.25,size.height/1.5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint=Offset(size.width-(size.width/3.25),size.height/3.0);
    var secondEndPoint=Offset(size.width,size.height/1.2);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height/1.5);
    path.lineTo(size.width,0.0,);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldCliper)=>false;
}