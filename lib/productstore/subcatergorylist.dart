import 'dart:ui';
import 'package:medicare/notifier/productnoti.dart';
import 'package:medicare/notifier/subcatnoti.dart';
import 'package:medicare/notifier/catergorynoti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:medicare/productstore/productlist.dart';
import 'package:medicare/database/product.dart';
import 'package:medicare/database/subcatergory.dart';
import 'package:medicare/productstore/productdisplay.dart';


class SubCatergorylist extends StatefulWidget {
  @override
  _SubCatergorylistState createState() => _SubCatergorylistState();
}

class _SubCatergorylistState extends State<SubCatergorylist> {
  @override
  void initState() {
    SubCatergoryNotifier subcatergoryNotifier =
    Provider.of<SubCatergoryNotifier>(context, listen: false);
    getSubCatergories(subcatergoryNotifier);
    ProductNotifier productNotifier =
    Provider.of<ProductNotifier>(context, listen: false);
    getProducts(productNotifier);

    super.initState();
  }

  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    CatergoryNotifier catergoryNotifier =
    Provider.of<CatergoryNotifier>(context);
    SubCatergoryNotifier subcatergoryNotifier =
    Provider.of<SubCatergoryNotifier>(context);
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);


    return SafeArea(
      child: Scaffold(
          key: _key,
          appBar: _customAppBar(
            _key,
            context,
            catergoryNotifier.currentCatergory.catergory != null
                ? catergoryNotifier.currentCatergory.catergory
                : null,
          ),
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
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(23.0),
                          child: Text(
                            catergoryNotifier.currentCatergory.catergory,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: subcatergoryNotifier.subcatergoryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (catergoryNotifier.currentCatergory.catergory ==
                                subcatergoryNotifier
                                    .subcatergoryList[index].catergory) {
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
                                          subcatergoryNotifier
                                              .currentSubCatergory =
                                          subcatergoryNotifier
                                              .subcatergoryList[index];
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                                return Productlist();
                                              }));
                                        },
                                        child: Text(
                                            subcatergoryNotifier
                                                .subcatergoryList[index]
                                                .subcatergory,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                  ],
                )),
          ),
          body: ListView.builder(
              shrinkWrap: true,
              itemCount: productNotifier.productList.length,
              itemBuilder: (BuildContext context, int index) {
                return (catergoryNotifier.currentCatergory.catergory ==
                    productNotifier.productList[index].catergory)
                    ? Padding(
                    padding:
                    EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                    child: InkWell(
                      onTap: () {
                        productNotifier.currentProduct =
                        productNotifier.productList[index];
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ProductDisplay();
                            }));
                      },
                      child: Material(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0)),
                        elevation: 5,
                        shadowColor: Colors.greenAccent,
                        child: Container(
                            height:
                            MediaQuery.of(context).size.height / 9 * 2,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    bottomRight: Radius.circular(25.0))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(25.0),
                                                  bottomRight:
                                                  Radius.circular(25.0))),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              3,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height /
                                              5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(
                                                        25.0),
                                                    bottomRight:
                                                    Radius.circular(
                                                        25.0)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        productNotifier
                                                            .productList[
                                                        index]
                                                            .images),
                                                    fit: BoxFit.fill)),
                                          ))),
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              productNotifier.productList[index]
                                                  .productname,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subhead
                                                  .copyWith(
                                                  color: Color(0xFF185a9d),
                                                  fontSize: 20.0),
                                            ),
                                          ),

                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Rs.${productNotifier
                                                  .productList[index]
                                                  .price
                                                  .toString()}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: IconButton(
                                            icon: Icon(Icons.add_shopping_cart,color: Color(0xFF185a9d),),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: IconButton(
                                            icon: Icon(Icons.favorite_border,color: Color(0xFF185a9d),),
                                          ),
                                        )
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            )),
                      ),
                    ))
                    : Container();
              }),


      ),
    );
  }
}





Widget _customAppBar(
    GlobalKey<ScaffoldState> globalKey,
    BuildContext context,
    String catergoryname,
    ) {
  return PreferredSize(
    preferredSize: Size.fromHeight(12 * SizeConfig.heightMultiplier),
    child: Material(
      elevation: 0.0,
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
          padding: EdgeInsets.only(
              left: 2.2 * SizeConfig.widthMultiplier,
              right: 2.2 * SizeConfig.widthMultiplier),
          child: Center(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                    //  UserAccess().authorizedAccess(context);

                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      Icons.list,
                      color: Colors.white,
                      size: 5 * SizeConfig.heightMultiplier,
                    ),
                    onPressed: () {
                      globalKey.currentState.openDrawer();
                    },
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 2.2 * SizeConfig.widthMultiplier,
                        right: 2.2 * SizeConfig.widthMultiplier),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            flex: 5,
                            child: Text(
                              catergoryname,
                              style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                            )),
                        Expanded(
                          flex: 2,
                          child: IconButton(
                            icon: Icon(Icons.shopping_basket,),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
