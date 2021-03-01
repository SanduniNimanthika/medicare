
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicare/commanpages/commonWidgets.dart';
import 'package:medicare/services/authentication.dart';
import 'package:medicare/mainpages/forgotpass.dart';

                    //mainpages
import 'package:medicare/loginSignup/welcome.dart';
import 'package:medicare/loginSignup/Signup.dart';
import 'package:medicare/mainpages/loading.dart';

                    //commanpages
import 'package:medicare/commanpages/configue.dart';
class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}
String error='';

class _SigninState extends State<Signin> {

  final AuthService _auth=AuthService();

  String email,password;

  bool loading=false;


  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: loading
            ? Loading()
            : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                NetworkImage("https://cdn.wallpapersafari.com/55/39/B9ZMiX.jpg"),
                                fit: BoxFit.fill)),
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                       //   color: Colors.white,
                          decoration: BoxDecoration(
                              gradient: linearcolor(),
                        ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 8.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () {

                          },
                        ),
                      ),
          Container(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only (top:150.0,bottom: 7*SizeConfig.heightMultiplier,
                    left: 6*SizeConfig.heightMultiplier,right: 6*SizeConfig.heightMultiplier),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[

                    //Email ADDRESS
                    Opacity(
                      opacity: 0.6,
                      child: Container(
                        child: new Center(
                            child: new TextFormField(
                                decoration: new InputDecoration(
                                  labelText: "Email",
                                  filled: true,
                                  prefixIcon: Icon(Icons.email,color:Colors.blueGrey),
                                  labelStyle:Theme.of(context).textTheme.display1,
                                  fillColor: Colors.white,
                                  focusedBorder:OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:Color(0xFF185a9d),
                                        style: BorderStyle.solid,
                                        width: 1
                                    ),

                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:Color(0xFF185a9d),
                                        style: BorderStyle.solid,
                                        width: 1
                                    ),

                                  ),
                                ),
                                validator: (input)=>input.isEmpty?'Please type your email here':null,
                                onChanged: (input){
                                  setState(() {
                                    email=input;
                                  });
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: Theme.of(context).textTheme.display1
                            )
                        ),
                      ),
                    ),

                    // password
                    Padding(
                      padding:  EdgeInsets.only (top:5*SizeConfig.heightMultiplier,bottom:3*SizeConfig.heightMultiplier ),
                      child: Opacity(
                        opacity: 0.6,
                        child: Container(
                          child: new Center(
                            child: new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Password",
filled: true,

                                prefixIcon: Icon(Icons.vpn_key,color:Colors.blueGrey),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _togglevisibility();
                                  },
                                  child: Icon(
                                    _showPassword ? Icons.visibility : Icons
                                        .visibility_off, color: Colors.blueGrey,),
                                ),

                                labelStyle:Theme.of(context).textTheme.display1,
                                fillColor: Colors.white,

                                focusedBorder:OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:Color(0xFF185a9d),
                                      style: BorderStyle.solid,
                                      width: 1
                                  ),

                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:Color(0xFF185a9d),
                                      style: BorderStyle.solid,
                                      width: 1
                                  ),

                                ),
                              ),


                              validator: (input)=>input.length<6?'Your password needs to be at least 6 characters':null,
                              onChanged: (input){
                                setState(() {
                                  password=input;
                                });
                              },
                              style: Theme.of(context).textTheme.display1,
                              obscureText: !_showPassword,

                            ),
                          ),
                        ),
                      ),
                    ),


                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Forgotpass()));
                        },
                        child: Text("Forgot password?",
                            style:Theme.of(context).textTheme.subhead.copyWith(color:Color(0xFF185a9d),fontWeight: FontWeight.bold )),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only (top:7*SizeConfig.heightMultiplier,bottom: 2*SizeConfig.heightMultiplier,),
                      child: Material(
                        borderRadius: BorderRadius.circular(5*SizeConfig.heightMultiplier),
                        elevation: 4.0,
                        child: InkWell(
                          onTap: ()async{
                            if(_formKey.currentState.validate()){
                              setState(() {
                                loading=true;
                              });
                              dynamic result =await _auth.signInWithEmailAndPassword(email, password,context);
                              if (result==null){
                                setState(() {

                                  loading=false;}
                                );

                              } if (loading==false){
                                setState(() {
                                  error='Please check your email and password';
                                });
                              }
                            }
                          },
                          child:buttonContainer(context, "Login", 43, null)

                        ),
                      ),
                    ),
                    Center(child: Text(error,style: Theme.of(context).textTheme.display1.copyWith(color: Colors.red,fontSize: 15,fontWeight: FontWeight.bold),)),





                    Padding(
                      padding:  EdgeInsets.only(top: 3*SizeConfig.heightMultiplier),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an account?\t",
                            style: Theme.of(context).textTheme.display1.copyWith(color: Colors.black54,fontWeight: FontWeight.bold)
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signup()));
                            },
                            child: Text("Create an account",
                                style:Theme.of(context).textTheme.subhead.copyWith(color:Color(0xFF185a9d),fontWeight: FontWeight.bold )),
                          ),
                        ],
                      ),
                    ),



                  ],
                ),
              ),
            ),
          )
          ],
        ),
    ]))
    ),
    );
  }
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
        padding: EdgeInsets.only(left:2.2*SizeConfig.widthMultiplier,right:2.2*SizeConfig.widthMultiplier ),
        child: Center(
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Welcome()));

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
    path.lineTo(0.0, size.height/1.2);
    var firstControlPoint=Offset(size.width/2,size.height/3);
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
