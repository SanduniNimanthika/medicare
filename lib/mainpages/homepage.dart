import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/textstyle.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:medicare/commanpages/footer.dart';
import 'package:medicare/perscriptionOder/uploadperscription.dart';
import 'package:medicare/productstore/catergorylist.dart';
import 'package:medicare/loginSignup/welcome.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final int _numpage = 1;
final PageController _pageController = PageController(initialPage: 0);
int _currentpage = 0;

List<Widget> _buildPageIndicator() {
  List<Widget> list = [];
  for (int i = 0; i <= _numpage; i++) {
    list.add(i == _currentpage ? _indicator(true) : _indicator(false));
  }
  return list;
}

Widget _indicator(bool isActive) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 150),
    margin: EdgeInsets.symmetric(horizontal: 10.0),
    height: 1.5 * SizeConfig.heightMultiplier,
    width: isActive
        ? 20 * SizeConfig.heightMultiplier
        : 10 * SizeConfig.heightMultiplier,
    decoration: BoxDecoration(
        color: isActive ? Color(0xFF185a9d) : Colors.black26,
        borderRadius: BorderRadius.circular(2 * SizeConfig.heightMultiplier)),
  );
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,

        backgroundColor: AppTheme.appBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[


              Container(
                decoration: BoxDecoration(
                    // color: Color(0xFFBBDEFB),
                    ),
                constraints: BoxConstraints(
                    maxHeight: 40 *
                        (SizeConfig.isMobilePortrait
                            ? SizeConfig.heightMultiplier
                            : SizeConfig.widthMultiplier)),
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
                                colors: [
                                  const Color(0xFF185a9d),
                                  const Color(0xFF43cea2)
                                ],
                              ),
                            ),
                          ),
                        )),
                    Center(
                      child: Image(
                        image: AssetImage("images/mainpages/familyhealth.png"),
                        height: 83.3 * SizeConfig.imageSizeMultiplier,
                        width: 83.3 * SizeConfig.imageSizeMultiplier,
                      ),
                    ),
                  ],
                ),
              ),

              // body
              Container(
                constraints: BoxConstraints(
                    maxHeight: 155 *
                        (SizeConfig.isMobilePortrait
                            ? SizeConfig.heightMultiplier
                            : (SizeConfig.widthMultiplier + 1.5))),
                child: PortraitDisplay(),
                // )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: 2 * SizeConfig.heightMultiplier),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                  ),
                  Container(
                      height: 105 * SizeConfig.heightMultiplier,
                      child: PageView(
                          physics: ClampingScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              _currentpage = page;
                            });
                          },
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 10,
                                  child: _bodyPage(
                                      context,
                                      "images/mainpages/pres.png",
                                      "Prescription medication",
                                      "\t      Click the below upload prescription button and"
                                          " upload photo of your prescription  issued "
                                          "by a SLMC registered doctor. We deliver medicine to your doorstep. "),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 1 * SizeConfig.heightMultiplier,
                                        bottom:
                                            1 * SizeConfig.heightMultiplier),
                                    child: Center(
                                      child: Material(
                                        borderRadius: BorderRadius.circular(
                                            2 * SizeConfig.heightMultiplier),
                                        elevation: 7.0,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PerscriptionUpload()));
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 29 *
                                                SizeConfig.heightMultiplier,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  const Color(0xFF185a9d),
                                                  const Color(0xFF43cea2)
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(2 *
                                                      SizeConfig
                                                          .heightMultiplier),
                                            ),
                                            child: Center(
                                              child: Text("Upload perscription",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subhead),
                                            ),
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
                                Expanded(
                                  flex: 10,
                                  child: _bodyPage(
                                    context,
                                    "images/mainpages/OnlineStore.png",
                                    "Health care product",
                                    "\t      Enhance your physical and mental with our health care products."
                                        "Click the bellow shop now button and checkout our product store and"
                                        " order as you wish. We deliver products to your"
                                        "doorstep",
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 1 * SizeConfig.heightMultiplier,
                                        bottom:
                                            1 * SizeConfig.heightMultiplier),
                                    child: Center(
                                      child: Material(
                                        borderRadius: BorderRadius.circular(
                                            2 * SizeConfig.heightMultiplier),
                                        elevation: 7.0,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Store()));
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 15 *
                                                SizeConfig.heightMultiplier,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  const Color(0xFF185a9d),
                                                  const Color(0xFF43cea2)
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(2 *
                                                      SizeConfig
                                                          .heightMultiplier),
                                            ),
                                            child: Center(
                                              child: Text("Shop now",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subhead),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ])),
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: 85 *
                            (SizeConfig.isMobilePortrait
                                ? SizeConfig.heightMultiplier
                                : (SizeConfig.widthMultiplier + 1.5))),
                    color: Color(0xFFBBDEFB),
                    child: Contact(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _bodyPage(BuildContext context, String img, String name, String des) {
  return Padding(
    padding: EdgeInsets.all(5 * SizeConfig.heightMultiplier),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Image(
            image: AssetImage(img),
            height: 90 * SizeConfig.imageSizeMultiplier,
            width: 90 * SizeConfig.imageSizeMultiplier,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 1 * SizeConfig.heightMultiplier),
          child: Text(name, style: Theme.of(context).textTheme.subtitle),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 2 * SizeConfig.heightMultiplier,
              left: 6 * SizeConfig.widthMultiplier),
          child: Text(des,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.display1),
        ),
      ],
    ),
  );
}

//portrait

class PortraitDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            flex: 2,
            child: _bodyDescription(
                context, Strings.welcometitle, Strings.welcomedes)),
        Expanded(
          flex: 1,
          child: Image(
            image: AssetImage("images/mainpages/welcome.png"),
            height: 40 * SizeConfig.imageSizeMultiplier,
            width: 40 * SizeConfig.imageSizeMultiplier,
          ),
        ),
        Expanded(flex: 6, child: Whychoose()),
      ],
    );
  }
}

//string of page

class Strings {
  Strings._();
  static const String welcometitle = "Welcome to Medicare";
  static const String welcomedes =
      "\t Medicare is the only online pharmacy in compliance with "
      "regulatory guidelines (National Medicines Regulatory Authority)in Sri Lanka. Medicare is the pharmacy of the future which allows online purchase of prescription"
      " medication and health product with door-step delivery.";

  static const String pretitle = "Prescription medication";
  static const String predes =
      "\t      Upload photo of your prescription  issued "
      "by a SLMC registered doctor. We deliver medicine to your doorstep."
      "MedicarePharmacy works with your doctor or pharmacist to take care of transfers, refill requests, and more. ";

  static const String healthtitle = "Health care product";
  static const String healthdes =
      "\t      Enhance your physical and mental with our health care products."
      "Checkout our product store and order as you wish.WE produce products with supposed health benefits, such as a supplement, herbal medicine , probiotic , etc.";
}

//body des

Widget _bodyDescription(BuildContext context, String topic, String des) {
  return Padding(
    padding: EdgeInsets.all(6 * SizeConfig.widthMultiplier),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          topic,
          style: Theme.of(context).textTheme.subtitle,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 3 * SizeConfig.widthMultiplier,
              top: 2.5 * SizeConfig.heightMultiplier),
          child: Text(
            des,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.display1,
          ),
        ),
      ],
    ),
  );
}

// why choose
class Whychoose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5 * SizeConfig.widthMultiplier),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Why choose us",
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
        ),
        _chooseus(
            context,
            "images/mainpages/1-delivery.png",
            "Receive fast delivary",
            "We deliver medication to your doorstep within 24 hours."),
        _chooseus(
            context,
            "images/mainpages/cost.png",
            "Lowest price ",
            "Medicines are priced exactly the same as your regular pharmacy."
                "Our products are also sold at the authorized retail price with the added convenience of paying online through Credit/Debit Cards,"
                " Mobile Wallets or Internet Banking."),
        _chooseus(context, "images/mainpages/cll.png", "licensed pharmacists",
            "Our pharmacists are standing by to answer all of your questions."),
        _chooseus(
            context,
            "images/mainpages/pre.png",
            "We handle your prescriptions for you",
            "Medicare Pharmacy works with your doctor or pharmacist to take care of transfers, refill requests, and more."),
      ],
    );
  }
}

Widget _chooseus(BuildContext context, String img, String name, String des) {
  return Padding(
    padding: EdgeInsets.all(1 * SizeConfig.heightMultiplier),
    child: Card(
      borderOnForeground: true,
      elevation: 0.8,
      color: Color(0xFFBBDEFB),
      child: ListTile(
        contentPadding: EdgeInsets.all(2 * SizeConfig.heightMultiplier),
        leading: Image(
          image: AssetImage(img),
          height: 15 * SizeConfig.imageSizeMultiplier,
          width: 15 * SizeConfig.imageSizeMultiplier,
        ),
        title: Text(name,
            textAlign: TextAlign.justify,
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(fontWeight: FontWeight.bold)),
        subtitle: Text(
          des,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    ),
  );
}

class ClippingPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height / 1.5);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height / 1.5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height / 3.0);
    var secondEndPoint = Offset(size.width, size.height / 1.2);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height / 1.5);
    path.lineTo(
      size.width,
      0.0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldCliper) => false;
}
