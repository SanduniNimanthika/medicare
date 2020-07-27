import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:medicare/commanpages/footer.dart';


              //main pages
import 'package:medicare/mainpages/homepage.dart';
import 'package:medicare/loginSignup/welcome.dart';

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
        appBar:_customAppBar(context) ,
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
                            padding: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier),
                            child: Center(
                              child:Material(
                                borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                                elevation: 7.0,
                                child: InkWell(
                                  onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Welcome()));
                                  },
                                  child: Container(
                                    height: 6.7*SizeConfig.heightMultiplier,
                                    width: 29*SizeConfig.heightMultiplier,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
                                      borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                                    ),
                                    child: Center(
                                      child: Text("Upload perscription",
                                          style:Theme.of(context).textTheme.subhead),
                                    ),
                                  ),
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
                            padding: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier),
                            child: Center(
                              child:Material(
                                borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                                elevation: 7.0,
                                child: InkWell(
                                  onTap: (){
                                   // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Welcome()));
                                  },
                                  child: Container(
                                    height: 6.7*SizeConfig.heightMultiplier,
                                    width: 15*SizeConfig.heightMultiplier,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
                                      borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                                    ),
                                    child: Center(
                                      child: Text("Shop now",
                                          style:Theme.of(context).textTheme.subhead),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                  ])
                ),
                Partners(),
                Container(constraints: BoxConstraints(
                    maxHeight: 85*(SizeConfig.isMobilePortrait? SizeConfig.heightMultiplier:(SizeConfig.widthMultiplier+1.5))
                ),
                  color: Color(0xFFBBDEFB) ,
                  child: Contact(),),
              ],
            )
          ],
        ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));

                },),
              Text("Our Services",
                  style:Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white)),
              Material(
                elevation: 7.0,
                borderRadius: BorderRadius.circular(2.2*SizeConfig.heightMultiplier),
                color: Colors.white70,

                child: InkWell(
                  onTap: (){},
                  child: Container(
                    height: 6*SizeConfig.heightMultiplier,
                    width: 14*SizeConfig.heightMultiplier,
                    child: Center(
                      child: Text("Sign in",
                          style: Theme.of(context).textTheme.display1.copyWith(color:Color(0xFF1565C0) )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),),
  );
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
          padding:  EdgeInsets.only(top: 2*SizeConfig.heightMultiplier, left:6*SizeConfig.widthMultiplier),
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



class Partners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5*SizeConfig.heightMultiplier),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Our partners",
            style: Theme.of(context).textTheme.subtitle,),
          Padding(
            padding: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier,left: 2*SizeConfig.heightMultiplier),
            child: Text("\t      Our partners are a part of our unique experience.We build relationships to ensure that you,our"
                "loyal customer experiences the best",
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.display1,),
          ),
          Container(
            constraints: BoxConstraints(
                maxHeight: 30*(SizeConfig.isMobilePortrait? SizeConfig.heightMultiplier:(SizeConfig.widthMultiplier+1.5))
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _partners("images/mainpages/partner1.jpg"),
                _partners("images/mainpages/partner2.jpg"),
                _partners("images/mainpages/partner 5.png"),
                _partners("images/mainpages/partner3.png"),
              ],
            ),
          )

        ],
      ),
    );
  }
}


Widget _partners (String name){
  return  Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 20*SizeConfig.heightMultiplier,
          width: 25*SizeConfig.heightMultiplier,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(name),
                fit: BoxFit.fill
            ),
          ),
        ),
      ),
    ),
  );
}