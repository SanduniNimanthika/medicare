import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';


import 'package:medicare/commanpages/configue.dart';



//mainpages
import 'package:medicare/mainpages/homepage.dart';


class AskQ extends StatefulWidget {
  @override
  _AskQState createState() => _AskQState();
}

class _AskQState extends State<AskQ> {
  void _makePhoneCall(int number) async {
    var url ="tel:${number.toString()}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ';
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _customAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
          Container(
          decoration: BoxDecoration(
              //color: Color(0xFFBBDEFB),
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
                        image: AssetImage("images/mainpages/ques.png"),
                        height: 70.0* SizeConfig.imageSizeMultiplier,
                        width: 83.3*SizeConfig.imageSizeMultiplier,
                      ),
                    ),

            ],
          ),
        ),
              Questions(),

     ]),
    ),


        floatingActionButton:FloatingActionButton(
          onPressed: (){
            _makePhoneCall(033221547227);
          },
          elevation: 7.0,
          child: Icon(Icons.phone_forwarded),backgroundColor:Color(0xFF185a9d) ,),
      ));
  }
}


class Questions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _faqs(context, 'Can I  order medicine without a prescription?',
            'No,the prescribed medication will be strictly dispensed against a vaild prescription.'),
        _faqs(context,'Are your prices the same?','Yes,medication is priced exactly the same as your retail pharmacy since our products are also sold a'
            ' at the authorised retail price.'),
        _faqs(context,'Can I order lesser quantity than prescribed?','Yes,except antibiotics we are flexible on other drugs.'),
        _faqs(context,'Is delivery free of charge?','Delivery chareges for Gampaha district will be Rs.150.00.'
            'Standard courier chages will appply for delivery of health care products.'),
           _faqs(context, 'To what areas do you deliver?', 'Prescribed medication is delivered within Gampaha district'
               'and Health care products are delivered within western provice. '),

      ],
    );
  }
}

Widget _faqs(BuildContext context,String question,String answer){
  return ExpansionTile(
    leading: Icon(Icons.help_outline,color: Color(0xFF185a9d),),
    title: Text(question,style: Theme.of(context).textTheme.display1,),
    children: <Widget>[
      Divider(),
      Padding(
        padding:  EdgeInsets.all(5*SizeConfig.heightMultiplier),
        child: Row(
          children: <Widget>[
             Expanded(
               flex:1,
                 child: Icon(Icons.check,color: Color(0xFF185a9d),)),
            Expanded(
                flex:6,
                child: Text(answer,textAlign:TextAlign.justify,style: Theme.of(context).textTheme.display1,)),
          ],
        ),
      )
    ],
  );
}



Widget  _customAppBar(context){
  return PreferredSize(
    preferredSize: Size.fromHeight(16*SizeConfig.heightMultiplier),
    child: Container(
      // alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
        ),
      ),

      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));

                    }
                ),
                Text("We are here to help",
                    style:Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white)),
                IconButton(icon: Icon(Icons.search,color: Colors.white,),
                  onPressed: (){}
                  ,),
              ],
            ),
            Text("you",
                style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white)),
          ],
        ),
      ),
    ),
  );
}


