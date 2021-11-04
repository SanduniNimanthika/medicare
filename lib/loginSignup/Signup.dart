import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/commonWidgets.dart';

import 'package:medicare/commanpages/configue.dart';

//mainpages
import 'package:medicare/loginSignup/welcome.dart';
import 'package:medicare/services/authentication.dart';
import 'package:medicare/loginSignup/signin.dart';
import 'package:medicare/mainpages/loading.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final AuthService _auth = AuthService();
  bool loading = false;

  //initially password is obscure
  String fullname = '';
  String email = '';
  String address = '';
  String password = '';
  String telenumber = '';
  String confirmpassword = '';

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                                  image: NetworkImage(
                                      "https://cdn.wallpapersafari.com/55/39/B9ZMiX.jpg"),
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
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 90,
                                  bottom: 3 * SizeConfig.heightMultiplier,
                                  left: 6 * SizeConfig.heightMultiplier,
                                  right: 6 * SizeConfig.heightMultiplier),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  //name
                                  Opacity(
                                    opacity: 0.6,
                                    child: new Container(
                                      child: new Center(
                                          child: new TextFormField(
                                              decoration: new InputDecoration(
                                                labelText: "Full Name",
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .display1,
                                                errorStyle: Theme.of(context)
                                                    .textTheme
                                                    .display1
                                                    .copyWith(
                                                        color: Colors.red,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                fillColor: Colors.white,
                                                filled: true,
                                                prefixIcon: Icon(Icons.person,
                                                    color: Colors.blueGrey),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF185a9d),
                                                      style: BorderStyle.solid,
                                                      width: 1),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF185a9d),
                                                      style: BorderStyle.solid,
                                                      width: 1),
                                                ),
                                              ),
                                              validator: (input) => input
                                                      .isEmpty
                                                  ? 'Please type your full name here'
                                                  : null,
                                              onChanged: (input) {
                                                setState(() {
                                                  fullname = input;
                                                });
                                              },
                                              keyboardType: TextInputType.text,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1)),
                                    ),
                                  ),

                                  //Email ADDRESS
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 4 * SizeConfig.heightMultiplier,
                                    ),
                                    child: Opacity(
                                      opacity: 0.6,
                                      child: Container(
                                        child: new Center(
                                            child: new TextFormField(
                                                decoration: new InputDecoration(
                                                  labelText: "Email",
                                                  errorStyle: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
                                                          color: Colors.red,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                  prefixIcon: Icon(Icons.email,
                                                      color: Colors.blueGrey),
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .display1,
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFF185a9d),
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFF185a9d),
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1),
                                                  ),
                                                ),
                                                validator: (input) => input
                                                        .isEmpty
                                                    ? 'Please type your email here'
                                                    : null,
                                                onChanged: (input) {
                                                  setState(() {
                                                    email = input;
                                                  });
                                                },
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display1)),
                                      ),
                                    ),
                                  ),
                                  Center(
                                      child: Text(
                                    error,
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
                                  )),

                                  // password
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 4 * SizeConfig.heightMultiplier,
                                    ),
                                    child: Opacity(
                                      opacity: 0.6,
                                      child: Container(
                                        child: new Center(
                                          child: new TextFormField(
                                            controller: _pass,
                                            decoration: new InputDecoration(
                                              labelText: "Password",
                                              errorStyle: Theme.of(context)
                                                  .textTheme
                                                  .display1
                                                  .copyWith(
                                                      color: Colors.red,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w800),
                                              filled: true,
                                              prefixIcon: Icon(Icons.vpn_key,
                                                  color: Colors.blueGrey),
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  _togglevisibility();
                                                },
                                                child: Icon(
                                                  _showPassword
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors.blueGrey,
                                                ),
                                              ),
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                              fillColor: Colors.white,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                              ),
                                            ),
                                            validator: (input) {
                                              Pattern pattern =
                                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                                              RegExp regex =
                                                  new RegExp(pattern);
                                              if (input.length < 6) {
                                                return 'Your password needs to be at least 6 characters';
                                              } else {
                                                if (!regex.hasMatch(input))
                                                  return 'Your password should contain at least one\n upper case,\n'
                                                      ' one lower case'
                                                      ' and one digit';
                                                else
                                                  return null;
                                              }
                                            },
                                            onChanged: (input) {
                                              setState(() {
                                                password = input;
                                              });
                                            },
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1,
                                            obscureText: !_showPassword,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  //confirm password

                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 4 * SizeConfig.heightMultiplier,
                                    ),
                                    child: Opacity(
                                      opacity: 0.6,
                                      child: Container(
                                        child: new Center(
                                          child: new TextFormField(
                                            controller: _confirmPass,
                                            decoration: new InputDecoration(
                                              filled: true,
                                              labelText: "Confirm Password",
                                              prefixIcon: Icon(Icons.vpn_key,
                                                  color: Colors.blueGrey),
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  _togglevisibility();
                                                },
                                                child: Icon(
                                                  _showPassword
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors.blueGrey,
                                                ),
                                              ),
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                              errorStyle: Theme.of(context)
                                                  .textTheme
                                                  .display1
                                                  .copyWith(
                                                      color: Colors.red,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w800),
                                              fillColor: Colors.white,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                              ),
                                            ),
                                            validator: (input) =>
                                                input != _pass.text
                                                    ? 'Password does not match'
                                                    : null,
                                            onChanged: (input) {
                                              setState(() {
                                                confirmpassword = input;
                                              });
                                            },
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1,
                                            obscureText: !_showPassword,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // button
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 6 * SizeConfig.heightMultiplier,
                                      bottom: 2.5 * SizeConfig.heightMultiplier,
                                    ),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(
                                          5 * SizeConfig.heightMultiplier),
                                      elevation: 4.0,
                                      child: InkWell(
                                          onTap: () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              setState(() {
                                                loading = true;
                                              });
                                              dynamic result = await _auth
                                                  .registerWithEmailAndPassword(
                                                      email,
                                                      password,
                                                      fullname,
                                                      'telenumber',
                                                      'address',
                                                      'hometown',
                                                      confirmpassword,
                                                      context);
                                              if (result == null) {
                                                setState(() {
                                                  error =
                                                      "please supply a vaild email";
                                                  loading = false;
                                                });
                                              }
                                            }
                                          },
                                          child: buttonContainer(
                                              context, "Sign up", 43, null)),
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Already have an account?\t",
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1
                                            .copyWith(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Signin()));
                                        },
                                        child: Text("Login",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead
                                                .copyWith(
                                                    color: Color(0xFF185a9d),
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )));
  }
}
