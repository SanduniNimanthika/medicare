import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/commonWidgets.dart';
import 'package:medicare/mainpages/tabhomepage.dart';
import 'package:medicare/perscriptionOder/userdetail.dart';
import 'package:medicare/userdetails/home.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class PerscriptionUpload extends StatefulWidget {
  final String back;
  PerscriptionUpload({
    Key key,
    @required this.back,
  }) : super(key: key);
  @override
  _PerscriptionUploadState createState() =>
      _PerscriptionUploadState(back: back);
}

class _PerscriptionUploadState extends State<PerscriptionUpload> {
  final String back;
  _PerscriptionUploadState({
    Key key,
    @required this.back,
  });
  String imgerror = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File _image;
  int days;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(top: 28, left: 28, right: 28, bottom: 8),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 5 * 3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(
                            4 * SizeConfig.heightMultiplier),
                        border: Border.all(
                          color: Color(0xFF185a9d),
                          style: BorderStyle.solid,
                          width: 2.0,
                        )),
                    child: InkWell(
                        onTap: () {
                          // ignore: deprecated_member_use
                          _selectImage(
                              ImagePicker.pickImage(source: ImageSource.camera),
                              1);
                        },
                        child: _display1()),
                  ),
                ),
                Center(
                    child: Text(
                  imgerror,
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(color: Colors.red, fontSize: 15),
                )),
                Padding(
                  padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 18.0),
                  child: Container(
                    child: new Center(
                        child: new TextFormField(
                            decoration: new InputDecoration(
                              labelText: "For x days ",
                              prefixIcon: Icon(Icons.calendar_today,
                                  color: Colors.blueGrey),
                              suffixText: "Days",
                              suffixStyle: Theme.of(context).textTheme.display1,
                              labelStyle: Theme.of(context).textTheme.display1,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF185a9d),
                                    style: BorderStyle.solid,
                                    width: 2),
                                borderRadius: new BorderRadius.circular(22.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF185a9d),
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius: new BorderRadius.circular(22.0),
                              ),
                            ),
                            onChanged: (input) {
                              setState(() {
                                String day = input;
                                days = int.parse(day);
                              });
                            },
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.display1)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 28, left: 28, right: 28, bottom: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(22),
                        elevation: 7.0,
                        child: InkWell(
                            onTap: () {
                              if (back == 'User') {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return UserHome();
                                }));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return Tabcontroller(2);
                                }));
                              }
                            },
                            child: buttonContainerWithBlue(
                                context, "Back", 43, 100)),
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(22),
                        elevation: 7.0,
                        child: InkWell(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                if (_image != null) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return Details(img: _image, days: days);
                                  }));
                                } else {
                                  setState(() {
                                    imgerror =
                                        "please capture image\n of the prescription";
                                  });
                                }
                              }
                            },
                            child: buttonContainer(context, "Next", 43, 100)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _image = tempImg);
        break;
    }
  }

  Widget _display1() {
    if (_image == null) {
      return Padding(
          padding: EdgeInsets.all(40),
          child: Icon(
            Icons.camera_alt,
            size: 55,
            color: Color(0xFF185a9d),
          ));
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.file(
          _image,
          fit: BoxFit.fill,
        ),
      );
    }
  }
}
