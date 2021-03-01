import 'package:flutter/material.dart';
Widget listbar(BuildContext context,String name,IconData iconname){
  return ListTile(
    title: Text(name,
        style: Theme.of(context).textTheme.display1),
    leading: Icon(iconname,
        color: Colors.blueGrey,
        size: 20),
  );
}

Widget buttonContainer(BuildContext context,String name,double height,double width){
  return  Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF185a9d),
          const Color(0xFF43cea2)
        ],
      ),
      borderRadius: BorderRadius.circular(
          20 ),
    ),
    child: Center(
      child: Text(name,
          style: Theme.of(context).textTheme.subhead),
    ),
  );
}

Widget buttonContainerWithBlue(BuildContext context,String name,double height,double width){
  return  Container(
    height: height,
    width: width,
      decoration:  BoxDecoration(
        color: Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color:Color(0xFF185a9d),
            style: BorderStyle.solid,
            width: 2.0
        )
    ),
    child: Center(
      child: Text(name,
          style: Theme.of(context).textTheme.subhead.copyWith(color:Color(0xFF185a9d))),
    ),
  );
}

linearcolor(){
  return  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xFF185a9d),
      const Color(0xFF43cea2)
    ],
  );
}


boxDecarationhistory(){
  return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0)));
}


form(BuildContext context, String labalValue, IconData icons) {
  return InputDecoration(
    labelText: labalValue,
    prefixIcon: Icon(icons, color: Colors.blueGrey),
    labelStyle: Theme.of(context).textTheme.display1,
    fillColor: Colors.white,
    errorStyle:Theme.of(context).textTheme.display1.copyWith(color: Colors.red[900],fontSize: 14) ,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: Color(0xFF185a9d), style: BorderStyle.solid, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: Color(0xFF185a9d), style: BorderStyle.solid, width: 1),
    ),
  );
}