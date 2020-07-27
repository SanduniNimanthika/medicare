
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:medicare/loginSignup/Signup.dart';
import 'package:medicare/services/authentication.dart';
import 'package:medicare/mainpages/services.dart';
import 'package:medicare/loginSignup/signin.dart';


class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:_customAppBar(context) ,
        body:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height:MediaQuery.of(context).size.height/5*3,

                child: Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: ClippingPath(),
                      child: Container(
                        height: MediaQuery.of(context).size.height/5*3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:AssetImage("images/mainpages/5555.jpg"),)
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Image.asset("images/mainpages/Online-Pharmacy.png"),
                      ),
                    )
                  ],
                ),
              ),
              Button(),
              Padding(
                padding: EdgeInsets.only(bottom: 7*SizeConfig.heightMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account?\t",
                      style: Theme.of(context).textTheme.display1,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signup()));
                      },
                      child: Text("Create an account",
                          style:Theme.of(context).textTheme.subhead.copyWith(color:Color(0xFF185a9d) )),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}



class Button extends StatelessWidget {

final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.only(top:5*SizeConfig.heightMultiplier,
              left:6*SizeConfig.heightMultiplier,right: 6*SizeConfig.heightMultiplier ),
          child: Material(
            borderRadius: BorderRadius.circular(5*SizeConfig.heightMultiplier),
            elevation: 4.0,
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signin()));
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
                  borderRadius: BorderRadius.circular(5*SizeConfig.heightMultiplier),
                ),
                child: Center(
                  child: Text("Login",
                      style:Theme.of(context).textTheme.subhead),
                ),
              ),
            ),
          ),
        ),



        Padding(
          padding:  EdgeInsets.only(top:7*SizeConfig.heightMultiplier,bottom: 7*SizeConfig.heightMultiplier,
              left: 6*SizeConfig.heightMultiplier,right: 6*SizeConfig.heightMultiplier),
          child: Material(
            borderRadius: BorderRadius.circular(5*SizeConfig.heightMultiplier),
            elevation: 7.0,
            child: InkWell(
              onTap: ()async {
                dynamic result=await _auth.signInAnos(context);
                if (result==null){
                  print("error");
                }else
                  print("Signed in");
                  print(result);
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                    color: Color(0xFFE3F2FD),
                 borderRadius: BorderRadius.circular(5*SizeConfig.heightMultiplier),
                  border: Border.all(
                    color:Color(0xFF185a9d),
                    style: BorderStyle.solid,
                    width: 2.0
                  )
                ),
                child: Center(
                  child: Text("Continue as guest",
                      style:Theme.of(context).textTheme.subhead.copyWith(color:Color(0xFF185a9d) )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



Widget  _customAppBar(context){
  return PreferredSize(
    preferredSize: Size.fromHeight(10*SizeConfig.heightMultiplier),
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
        padding: EdgeInsets.only(left:2.2*SizeConfig.widthMultiplier,right:2.2*SizeConfig.widthMultiplier ),
        child: Center(
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Services()));
                },),
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