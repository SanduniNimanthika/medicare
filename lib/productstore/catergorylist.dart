import 'dart:ui';
import 'package:medicare/commanpages/commonWidgets.dart';
import 'package:medicare/database/catergory.dart';
import 'package:medicare/mainpages/tabhomepage.dart';
import 'package:medicare/productstore/subcatergorylist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:medicare/notifier/catergorynoti.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:medicare/userdetails/home.dart';
import 'package:medicare/database/product.dart';
import 'package:medicare/notifier/productnoti.dart';
import 'package:medicare/productstore/productdisplay.dart';
import 'package:medicare/module/user.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  ProductService productService= ProductService();


  @override
  void initState() {
    CatergoryNotifier catergoryNotifier =
        Provider.of<CatergoryNotifier>(context, listen: false);
    getCatergories(catergoryNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CatergoryNotifier catergoryNotifier =
        Provider.of<CatergoryNotifier>(context);
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          // linear background
          child: Container(
              decoration: BoxDecoration(
                gradient: linearcolor()
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                        child: Padding(
                      padding: const EdgeInsets.all(23.0),
                      child: Text(
                        "Product catergories",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white),
                      ),
                    )),
                  ),
                  Expanded(
                    flex: 10,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: catergoryNotifier.catergoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              Divider(
                                color: Colors.blueGrey,
                                thickness: 1,
                              ),
                              ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: InkWell(
                                    onTap: () {
                                      catergoryNotifier.currentCatergory =
                                          catergoryNotifier
                                              .catergoryList[index];
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return SubCatergorylist();
                                      }));
                                    },
                                    child: Text(
                                        catergoryNotifier
                                            .catergoryList[index].catergory,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subhead),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                  ),
                ],
              )),
        ),
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: (MediaQuery.of(context).size.height/5 )*2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/user/online-tablet-with-pills-capsules-blisters-glass-bottles-plastic-tubes_159446-35.jpg"),
                              fit: BoxFit.fill)),
                      height: (MediaQuery.of(context).size.height/5*2),
                      width: MediaQuery.of(context).size.width/3*2,

                    ),
                  ),

                  ClipPath(
                    clipper: ClippingPath(),
                    child: Opacity(
                      opacity: 0.7,
                      child: Container(
                        height:(MediaQuery.of(context).size.height/5*2 ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: linearcolor()
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: 3.5 * SizeConfig.heightMultiplier,
                        left: 2 * SizeConfig.heightMultiplier,
                        right: 2 * SizeConfig.heightMultiplier,
                        bottom: 20),
                    child: Column(

                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                                onTap: ()  {
                                  final user = Provider.of<User>(context);
                                  if (user == null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Tabcontroller(1)));
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                UserHome()));
                                  }
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 25.0,
                                  color: Colors.white,
                                )),
                            IconButton(
                              icon: Icon(
                                Icons.list,
                                size: 28,
                                color: Color(0xFF185a9d),
                              ),
                              onPressed: () {
                                _key.currentState.openDrawer();
                              },
                            ),

                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Let's ",
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Shoping ",
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(color: Color(0xFF185a9d)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Opacity(
                            opacity: 0.8,
                            child: Container(
                              child: TypeAheadField(
                                textFieldConfiguration:
                                TextFieldConfiguration(
                                  autofocus: false,
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1,
                                  decoration: InputDecoration(
                                    labelText: "search by product name",
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .display1,
                                    prefixIcon: Icon(Icons.search,
                                        color: Colors.blueGrey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22),
                                      borderSide: BorderSide(
                                          color: Color(0xFF185a9d),
                                          style: BorderStyle.solid,
                                          width: 1),
                                    ),
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22),
                                      borderSide: BorderSide(
                                          color: Color(0xFF185a9d),
                                          style: BorderStyle.solid,
                                          width: 1),
                                    ),
                                  ),

                                ),
                                suggestionsCallback:
                                    (pattern) async {
                                  return await productService
                                      .getSuggestions(pattern);
                                },
                                itemBuilder: (context, suggestion) {
                                  return Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading:Container(
                                          height:30,
                                          width: 30,
                                          child: Image(
                                            image: NetworkImage(
                                                suggestion['images']
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),

                                        title: Text(
                                          suggestion['productname'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1,
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                      )
                                    ],
                                  );
                                },
                                onSuggestionSelected: (suggestion) {

                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DisplayDetails(productkey: suggestion['uid'],);
                                      });



                                },
                              ),
                            ),
                          ),
                        ),
                      ],

                    ),

                  ),


                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Offers",
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              OfferDisplay(),
            ],
          ),
        ),
      ),
    );
  }
}



/*class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    CatergoryNotifier catergoryNotifier =
    Provider.of<CatergoryNotifier>(context, listen: false);
    getCatergories(catergoryNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CatergoryNotifier catergoryNotifier =
    Provider.of<CatergoryNotifier>(context);

    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          // linear background
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
                  tileMode: TileMode.repeated,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(23.0),
                          child: Text(
                            "Product catergories",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: Colors.white),
                          ),
                        )),
                  ),
                  Expanded(
                    flex: 10,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: catergoryNotifier.catergoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              Divider(
                                color: Colors.blueGrey,
                                thickness: 1,
                              ),
                              ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: InkWell(
                                    onTap: () {
                                      catergoryNotifier.currentCatergory =
                                      catergoryNotifier
                                          .catergoryList[index];
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return SubCatergorylist();
                                              }));
                                    },
                                    child: Text(
                                        catergoryNotifier
                                            .catergoryList[index].catergory,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subhead),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                  ),
                ],
              )),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "http://www.middlewaypharmacy.co.uk/wp-content/uploads/2013/06/banner1.jpg"),
                            fit: BoxFit.fitWidth)),
                    height: (MediaQuery.of(context).size.height / 3) * 1,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(

                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                        child: Opacity(
                          opacity: .5,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFF185a9d),
                                  const Color(0xFF43cea2)
                                ],
                                tileMode: TileMode.repeated,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 3.5 * SizeConfig.heightMultiplier,
                        left: 2 * SizeConfig.heightMultiplier,
                        right: 2 * SizeConfig.heightMultiplier),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: InkWell(
                              onTap: () {
                                final user = Provider.of<User>(context);
                                if (user == null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Tabcontroller(1)));
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              UserHome()));
                                }
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 25.0,
                                color: Color(0xFF185a9d),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(
                              Icons.list,
                              size: 5 * SizeConfig.heightMultiplier,
                              color: Color(0xFF185a9d),
                            ),
                            onPressed: () {
                              _key.currentState.openDrawer();
                            },
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    "Medicare",
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(fontSize: 30),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      size: 5 * SizeConfig.heightMultiplier,
                                      color: Color(0xFF185a9d),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(5 * SizeConfig.heightMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Offers",
                      style: Theme.of(context).textTheme.subtitle,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/









class DisplayDetails extends StatefulWidget {
  final String productkey;
  DisplayDetails({Key key, @required this.productkey}) : super(key: key);
  @override
  _DisplayDetailsState createState() => _DisplayDetailsState(productkey: productkey);
}

class _DisplayDetailsState extends State<DisplayDetails> {
  final String productkey;
  _DisplayDetailsState({Key key, @required this.productkey});
  @override
  void initState() {
    ProductNotifier productNotifier =
    Provider.of<ProductNotifier>(context, listen: false);
    getProducts(productNotifier);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0.0,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SingleChildScrollView(
                child: Container(
                  color: Color(0xFFE3F2FD),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: productNotifier.productList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return (productNotifier.productList[index].productkey==productkey)
                                ? SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height / 3 * 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  image: DecorationImage(
                                                      image: NetworkImage(productNotifier.productList[index].images),
                                                      fit: BoxFit.fill)),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only( top: 25.0),
                                          child: Text(
                                            productNotifier.productList[index].productname,
                                            style: Theme.of(context).textTheme.subtitle,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only( top: 8.0),
                                          child: Text(
                                            'By ${productNotifier.productList[index].catergory}',
                                            style: Theme.of(context).textTheme.display1,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only( left:8,
                                              top: 25.0),
                                          child: (productNotifier.productList[index].offerprice ==
                                              0.0)
                                              ? Row(
                                            children: <Widget>[
                                              Text('Product Price :',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                              ),
                                              Text(
                                                  'Rs. ${productNotifier.productList[index].price.toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(fontSize: 19.0)),
                                            ],
                                          )
                                              : Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Text('New Price : ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .display1),
                                                  Text(
                                                    'Rs.${productNotifier.productList[index].offerprice.toString()}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .display1
                                                        .copyWith(
                                                        color: Colors.red),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 15),
                                              Row(
                                                children: <Widget>[
                                                  Text('Old Price : ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .display1),
                                                  Text(
                                                      'Rs.${productNotifier.productList[index].price.toString()}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .display1
                                                          .copyWith(
                                                          decoration:
                                                          TextDecoration
                                                              .lineThrough)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 34, bottom: 20),
                                          child: Material(
                                            borderRadius: BorderRadius.circular(
                                                5 * SizeConfig.heightMultiplier),
                                            elevation: 4.0,
                                            child: InkWell(
                                                onTap: ()  {
                                                  productNotifier.currentProduct =
                                                  productNotifier.productList[index];
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(builder: (BuildContext context) {
                                                        return ProductDisplay(back: 'subcat',);
                                                      }));


                                                },
                                                child:buttonContainer(context,'Preview', 43, 130)

                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                : Container();
                          }),







                    ],
                  ),
                ))));
  }
}







class OfferDisplay extends StatefulWidget {
  @override
  _OfferDisplayState createState() => _OfferDisplayState();
}

class _OfferDisplayState extends State<OfferDisplay> {
  @override
  void initState() {
    ProductNotifier productNotifier =
    Provider.of<ProductNotifier>(context, listen: false);
    getProductsOffer(productNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio:
      MediaQuery.of(context).size.width /
          MediaQuery.of(context).size.height/0.70),
      itemCount: productNotifier.productList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: ()async{
            setState(() {
              productNotifier.currentProduct =
              productNotifier.productList[index];
            });

            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return ProductDisplay(back:'offer');
                }));},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0)),
              shadowColor: Colors.greenAccent,
              elevation: 5,
              child: Container(
                  decoration:boxDecarationhistory(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                              decoration:boxDecarationhistory(),
                              width: MediaQuery.of(context).size.width /5*2,
                              height: MediaQuery.of(context).size.height /5,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            bottomRight: Radius.circular(25.0)),
                                        image: DecorationImage(
                                            image: NetworkImage(productNotifier
                                                .productList[index].images),
                                            fit: BoxFit.fill)),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height: 30,
                                      width: 47.0,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            bottomRight: Radius.circular(25.0)),
                                      ),
                                      child: Center(
                                        child: Text( '${productNotifier.productList[index].offer.toString()}%',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead

                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0,top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    productNotifier
                                        .productList[index].productname,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subhead
                                        .copyWith(
                                      color: Color(0xFF185a9d),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Rs.${productNotifier.productList[index].offerprice.toString()}',
                                        style: Theme.of(context).textTheme.display1.copyWith(color: Colors.red,fontSize: 14),
                                      ),
                                      Text(
                                          'Rs.${productNotifier.productList[index].price.toString()}',
                                          style: Theme.of(context).textTheme.display1.copyWith(decoration: TextDecoration.lineThrough ,fontSize: 14)
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}




class ClippingPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height );
    path.lineTo(size.width, size.height );
    path.lineTo(
      0.0,
      0.0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldCliper) => false;
}