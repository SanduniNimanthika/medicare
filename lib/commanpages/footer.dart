import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medicare/commanpages/configue.dart';

class Contact extends StatelessWidget {
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.all(5*SizeConfig.widthMultiplier),
                child: Text("Get in touch",style: Theme.of(context).textTheme.subtitle,),
              ),
              GestureDetector(
                  onTap:(){
                    _makePhoneCall(033221547227);

                  },
                  child:
                  _dial(context,"0332215477", Icons.phone)
              ),
              GestureDetector(
                  onTap:(){
                    _makePhoneCall(033225892291);

                  },
                  child:_dial(context,"0332258991", Icons.phone)
              ),
              GestureDetector(
                  onTap:(){
                    _launchemail("medicare@gmail.com");

                  },
                  child: _dial(context,"medicare@gmail.com", Icons.email)
              ),

              Divider(
                thickness: 1.0,
                color: Color(0xFF0D47A1),
              ),
              Padding(
                padding:  EdgeInsets.all(5*SizeConfig.widthMultiplier),
                child: Text("Medicare",style: Theme.of(context).textTheme.subtitle,),
              ),
              Padding(
                padding:  EdgeInsets.only(left:8*SizeConfig.widthMultiplier,right: 6*SizeConfig.widthMultiplier),
                child: Text("Medicare is the only online pharmacy in compliance with "
                    "regulatory guidelines (National Medicines Regulatory Authority)in Sri Lanka."
                    "Medicare will always honor the price reflected at the time you purchased your medication."
                    " Your final price is based on the medication you pick up at the pharmacy."
                    " If you pick up a different form, dosage, or quantity, you will be charged or credited the difference."
                  ,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.display1,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _dial (BuildContext context,String name,IconData icon) {
  return Padding(
    padding: EdgeInsets.only(left: 8*SizeConfig.widthMultiplier,top: 0.1*SizeConfig.heightMultiplier),
    child: ListTile(
      title: Text(name,
        style: Theme.of(context).textTheme.display1,),

      leading: Icon(icon, size: 3*SizeConfig.heightMultiplier, color: Colors.black54,),
    ),
  );
}

