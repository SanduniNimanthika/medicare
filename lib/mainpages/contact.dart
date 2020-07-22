import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:medicare/commanpages/responsive.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:medicare/commanpages/footer.dart';
import 'package:url_launcher/url_launcher.dart';


//main pages
import 'package:medicare/mainpages/homepage.dart';


class ContactPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:_customAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                //  color: Color(0xFFBBDEFB),
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
                        image: AssetImage("images/mainpages/contact/helpcenter.png"),
                        height: 60.0* SizeConfig.imageSizeMultiplier,
                        width: 83.3*SizeConfig.imageSizeMultiplier,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  child:Responsive(
                    landscapeLayout: LandscapeDisplay(),
                    portraitLayout: PortraitDisplay(),
                  )
              ),
              GetInTouch(),
              Container(constraints: BoxConstraints(
                  maxHeight: 85*(SizeConfig.isMobilePortrait? SizeConfig.heightMultiplier:(SizeConfig.widthMultiplier+1.5))
               ),
                color: Color(0xFFBBDEFB) ,
                child: Contact(),),
            ],
          ),
        ),
      ),
    );
  }
}

class PortraitDisplay extends StatelessWidget {

  //make a call
  void _makePhoneCall(int number) async {
    var url ="tel:${number.toString()}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ';
    }
  }

  // send email

  void _launchemail(String emailId) async {
    var url ="mailto:$emailId?  ";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ';
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        _topic(context, Strings.getintouch),
          GestureDetector(
          onTap:(){
          _makePhoneCall(033221547227);

           },
               child: _dial(context,Strings.num1, Strings.phoneimg)
          ),

        GestureDetector(
        onTap:(){
        _makePhoneCall(033225892291);

         },
           child:_dial(context,Strings.num2, Strings.phoneimg)
        ),
        GestureDetector(
        onTap:(){
        _launchemail("medicare@gmail.com");
        },
            child: _dial(context,Strings.email, Strings.emailimg)
        ),
          _topic(context,Strings.openhour),
          _dial(context, Strings.openhour1, Strings.openhourimg),
          _dial(context, Strings.openhour2,Strings.openhourimg),
          ]);
  }
}
class LandscapeDisplay extends StatelessWidget {

  //make a call
  void _makePhoneCall(int number) async {
    var url ="tel:${number.toString()}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ';
    }
  }

  // send email

  void _launchemail(String emailId) async {
    var url ="mailto:$emailId?  ";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child:  _topic(context, Strings.getintouch),
            ),
            Expanded(
                flex: 1,
                child:  _topic(context,Strings.openhour),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child:   GestureDetector(
                  onTap:(){
                    _makePhoneCall(033221547227);

                  },
                  child: _dial(context,Strings.num1, Strings.phoneimg)
              ),
            ),
            Expanded(
              flex: 1,
              child: _dial(context, Strings.openhour1, Strings.openhourimg),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child:   GestureDetector(
                  onTap:(){
                    _makePhoneCall(033225892291);

                  },
                  child:_dial(context,Strings.num2, Strings.phoneimg)
              ),
            ),
            Expanded(
              flex: 1,
              child: _dial(context, Strings.openhour2,Strings.openhourimg),
            ),
          ],
        ),
        Row(
          children: <Widget>[

            Expanded(
              flex: 1,
            child: GestureDetector(
                onTap:(){
                  _launchemail("medicare@gmail.com");
                },
                child: _dial(context,Strings.email, Strings.emailimg)
            ),),

          ],
        )
      ],
    );
  }
}


class Strings {
  Strings._();
  static const String getintouch="Get in touch";
  static const String num1="0332215477";
  static const String phoneimg="images/mainpages/contact/phoneblue.png";
  static const String num2="0332258991";
  static const String email="medicare@gmail.com";
  static const String emailimg="images/mainpages/contact/emailblue.png";

  static const String openhour="Our hours";
  static const String openhour1='''Mon-Sat   8.30 A.M  -  8.00 P.M''';
  static const String openhour2='''Sun   8.30 A.M  -  4.00 P.M''';
  static const String openhourimg="images/mainpages/contact/clock (2).png";


}




class GetInTouch extends StatelessWidget {


  //follow us

  void _launchurl(String url) async {

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ';
    }
  }
  @override
  Widget build(BuildContext context) {
    return
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _topic(context, "Our location"),
        _dial(context,"No: 05 ,\nKandy road ,\nNittambuwa.","images/mainpages/contact/location.png"),
       /* Container(
          height: MediaQuery.of(context).size.height-50.0,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target:LatLng(40.7128,-74.0060),zoom: 12.0),
              onMapCreated: mapCreated,
            ),
          ),*/

        _topic(context, "Follow us"),
        Padding(
          padding: EdgeInsets.only(left:10*SizeConfig.heightMultiplier,top:2*SizeConfig.heightMultiplier,right: 10*SizeConfig.heightMultiplier,bottom: 10*SizeConfig.heightMultiplier),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap:(){
                    _launchurl("google.com");

                  }, child: _media("images/mainpages/contact/fb (2).png")
              ),
              GestureDetector(
                  onTap:(){
                    _launchurl("google.com");

                  }, child: _media("images/mainpages/contact/twter.png")
              ),
              GestureDetector(
                  onTap:(){
                    _launchurl("google.com");

                  }, child: _media("images/mainpages/contact/instgram.png")
              ),
            ],
          ),
        )


      ],
    );

  }
}


Widget _topic(BuildContext context,String name){
  return Padding(
    padding: EdgeInsets.only(left:6*SizeConfig.widthMultiplier,top:6*SizeConfig.heightMultiplier,bottom: 4*SizeConfig.heightMultiplier),
    child: Text(name,
      style: Theme.of(context).textTheme.subtitle),
  );
}


Widget _dial(BuildContext context,String name,String img){
  return  Padding(
    padding:  EdgeInsets.only( left:6*SizeConfig.heightMultiplier,top:2*SizeConfig.heightMultiplier),
    child: ListTile(
      title:  Text(name,
        style:Theme.of(context).textTheme.display1,),

      leading: Image(
        image: AssetImage(img),
        height: 10* SizeConfig.imageSizeMultiplier,
        width: 10*SizeConfig.imageSizeMultiplier,
      ),
    ),
  );
}




Widget _media(String imgName){
  return  Image(
    image: AssetImage(imgName),
    height: 15* SizeConfig.imageSizeMultiplier,
    width: 15*SizeConfig.imageSizeMultiplier,
  );
}



Widget  _customAppBar(context){
  return PreferredSize(
    preferredSize: Size.fromHeight(12*SizeConfig.heightMultiplier),
    child: Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left:2.2*SizeConfig.widthMultiplier,right:7*SizeConfig.widthMultiplier),
        child: Center(
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));

                },),
              Text("Get in touch",
                style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),),

            ],
          ),
        ),
      ),),
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