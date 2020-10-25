import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/perscriptionOder/userdetail.dart';
import 'package:medicare/userdetails/home.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
class PerscriptionUpload extends StatefulWidget {
  @override

  _PerscriptionUploadState createState() => _PerscriptionUploadState();
}

class _PerscriptionUploadState extends State<PerscriptionUpload> {
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
            key:_formKey,
            child: Column(
              children: <Widget>[


                Padding(
                  padding: EdgeInsets.only(
              top: 28,
              left: 28,
              right: 28,
              bottom: 8),
                  child: Container(
                    height: MediaQuery.of(context).size.height/5*3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(4*SizeConfig.heightMultiplier),
                        border: Border.all(
                            color:Color(0xFF185a9d),
                            style: BorderStyle.solid,
                            width: 2.0,

                        )
                    ),
                    child: InkWell(
                      onTap: (){
                        // ignore: deprecated_member_use
                        _selectImage(ImagePicker.pickImage(
                            source: ImageSource.gallery),
                            1);
                      },
                      child: _display1()
                    ),
                  ),
                ),
                Center(
                    child: Text(
                      imgerror,
                      style: Theme
                          .of(context)
                          .textTheme
                          .display1
                          .copyWith(
                          color: Colors.red, fontSize: 15),
                    )),
                Padding(
                  padding:  EdgeInsets.only(left:28.0,right: 28.0,top: 18.0),
                  child: Container(
                    child: new Center(
                        child: new TextFormField(

                            decoration: new InputDecoration(
                              labelText: "For x days ",
                              prefixIcon: Icon(Icons.calendar_today,color:Colors.blueGrey),
                              suffixText: "Days",suffixStyle: Theme.of(context).textTheme.display1,
                              labelStyle:Theme.of(context).textTheme.display1,
                              fillColor: Colors.white,
                              focusedBorder:OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:Color(0xFF185a9d),
                                    style: BorderStyle.solid,
                                    width: 2
                                ),
                                borderRadius: new BorderRadius.circular(22.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:Color(0xFF185a9d),
                                    style: BorderStyle.solid,
                                    width: 1
                                ),
                                borderRadius: new BorderRadius.circular(22.0),
                              ),
                            ),

                            onChanged: (input){
                              setState(() {
                             String   day=input;
                             days=int.parse(day);
                              });
                            },

                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.display1
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 28,
                      left: 28,
                      right: 28,
                  bottom: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Material(
                        borderRadius: BorderRadius.circular(4*SizeConfig.heightMultiplier),
                        elevation: 7.0,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (BuildContext context) {
                                  return UserHome();
                                }));
                          },
                          child: Container(
                            height: 40,
                            width: 15*SizeConfig.heightMultiplier,


                            decoration: BoxDecoration(
                                color: Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(4*SizeConfig.heightMultiplier),
                                border: Border.all(
                                    color:Color(0xFF185a9d),
                                    style: BorderStyle.solid,
                                    width: 2.0
                                )
                            ),
                            child: Center(
                              child: Text("back",
                                  style:Theme.of(context).textTheme.subhead.copyWith(color:Color(0xFF185a9d) )),
                            ),
                          ),
                        ),
                      ),

                      Material(
                        borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                        elevation: 7.0,
                        child: InkWell(
                          onTap: (){
                            if (_formKey.currentState
                                .validate()) {
                              if(_image!=null){
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (BuildContext context) {
                                      return Details(img: _image, days: days);
                                    }));}else{
                                setState(( ) {
                                  imgerror =
                                  "please provide a image";

                                });
                              }

                            }

                          },
                          child: Container(
                            height: 40,
                            width: 15*SizeConfig.heightMultiplier,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
                              borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                            ),
                            child: Center(
                              child: Text("Next",
                                  style:Theme.of(context).textTheme.subhead),
                            ),
                          ),
                        ),
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




void _selectImage( Future<File> pickImage, int imageNumber ) async {
  File tempImg = await pickImage;
  switch (imageNumber) {
    case 1
        :
      setState(( ) => _image = tempImg);
      break;
  }
}

Widget _display1( ) {
  if (_image == null) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Icon(Icons.camera_alt,size: 55,color:Color(0xFF185a9d) ,)
    );
  } else {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.file(_image, fit: BoxFit.fill,),
    );
  }
}}



