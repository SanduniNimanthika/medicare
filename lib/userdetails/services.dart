import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/commonWidgets.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:medicare/perscriptionOder/uploadperscription.dart';
import 'package:medicare/productstore/catergorylist.dart';


class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}
final int _numpage=1;
final PageController _pageController=PageController(initialPage:0);
int _currentpage=0;

List<Widget> _buildPageIndicator(){
  List<Widget> list=[];
  for (int i=0; i<=_numpage;i++){
    list.add(i==_currentpage ? _indicator(true):_indicator(false));
  }
  return list;
}
Widget _indicator(bool isActive){
  return AnimatedContainer(
    duration: Duration(milliseconds: 150),
    margin: EdgeInsets.symmetric(horizontal: 10.0),
    height: 1.5*SizeConfig.heightMultiplier,
    width: isActive ?20*SizeConfig.heightMultiplier:10*SizeConfig.heightMultiplier,
    decoration: BoxDecoration(
        color: isActive ? Color(0xFF185a9d): Colors.black26,
        borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier)
    ),
  );
}
class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
       // appBar:_customAppBar(context) ,
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(top: 9*SizeConfig.heightMultiplier),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
                Container(
                  height: 105*SizeConfig.heightMultiplier,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page){
                      setState(() {
                        _currentpage=page;
                      });
                    },
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          _bodyPage(context, "images/mainpages/pres.png","Prescription medication",
                              "\t      Click the below upload prescription button and"
                              " upload photo of your prescription  issued "
                              "by a SLMC registered doctor. We deliver medicine to your doorstep. "),
                          Padding(
                            padding: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier,left: 35,right: 35),
                            child: Center(
                              child:Material(
                                borderRadius: BorderRadius.circular(22),
                                elevation: 7.0,
                                child: InkWell(
                                  onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PerscriptionUpload(back:'User')));
                                  },
                                  child: buttonContainer(context, "Upload perscription", 43, null)

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),




                      // second page
                      Column(
                        children: <Widget>[
                          _bodyPage(context, "images/mainpages/OnlineStore.png",
                              "Health care product",
                              "\t      Enhance your physical and mental with our health care products."
                                  "Click the bellow shop now button and checkout our product store and"
                                  " order as you wish. We deliver products to your"
                                  "doorstep",),
                          Padding(
                            padding: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier,left: 35,right: 35),
                            child: Center(
                              child:Material(
                                borderRadius: BorderRadius.circular(22),
                                elevation: 7.0,
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Store()));
                                  },
                                  child:buttonContainer(context, "Shop now",43, null)

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                  ])
                ),


              ],
            )
          ],
        ),
      ),
    );
  }
}




Widget _bodyPage(BuildContext context,String img,String name,String des){
  return Padding(
    padding: EdgeInsets.all(5*SizeConfig.heightMultiplier),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Image(
            image: AssetImage(img),
            height: 90*SizeConfig.imageSizeMultiplier,
            width: 90*SizeConfig.imageSizeMultiplier,
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(top: 1*SizeConfig.heightMultiplier),
          child: Text(
              name, style:Theme.of(context).textTheme.subtitle
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(top: 2*SizeConfig.heightMultiplier),
          child: Text(
              des,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.display1
          ),
        ),

      ],
    ),
  );

}


