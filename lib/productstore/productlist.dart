import 'dart:ui';
import 'package:medicare/productstore/productdisplay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/productstore/subcatergorylist.dart';
import 'package:medicare/notifier/productnoti.dart';
import 'package:medicare/notifier/catergorynoti.dart';
import 'package:medicare/module/product.dart';
import 'package:medicare/notifier/subcatnoti.dart';
import 'package:medicare/database/product.dart';
import 'package:medicare/database/subcatergory.dart';
import 'package:medicare/module/user.dart';
import 'package:medicare/database/cart.dart';
import 'package:medicare/mainpages/tabhomepage.dart';
import 'package:medicare/userdetails/cart.dart';
import 'package:medicare/userdetails/home.dart';

class Productlist extends StatefulWidget {
  @override
  _ProductlistState createState() => _ProductlistState();
}

class _ProductlistState extends State<Productlist> {
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
  ProductCartService _cartService = ProductCartService();
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
                subcatergoryNotifier.currentSubCatergory.subcatergory != null
                    ? subcatergoryNotifier.currentSubCatergory.subcatergory
                    : null),
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: productNotifier.productList.length,
                itemBuilder: (BuildContext context, int index) {
                  return (catergoryNotifier.currentCatergory.catergory ==
                      productNotifier.productList[index].catergory &&
                      subcatergoryNotifier.currentSubCatergory.subcatergory ==
                          productNotifier.productList[index].subcatergory)
                      ? InkWell(
                    onTap: () {
                      productNotifier.currentProduct =
                      productNotifier.productList[index];
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return ProductDisplay();
                          }));
                    },
                    child: Padding(
                        padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
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
                                              icon: Icon(Icons.add_shopping_cart,color: Color(0xFF185a9d),), onPressed: ()async{
                                              final user = Provider.of<User>(context);
                                              if(user == null){

                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Tabcontroller(3)));
                                              }else{ if(productNotifier.currentProduct.type=='nonperscription required'){
                                                int quty=1;
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>ProductCartlist()));
                                                await _cartService.createProductCartData(productNotifier.currentProduct.productname,
                                                    user.userkey, productNotifier.currentProduct.productkey,
                                                    quty,productNotifier.currentProduct.price ,quty*productNotifier.currentProduct.price,productNotifier.currentProduct.images);

                                              }else{
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHome()));
                                              }
                                              }



                                            },
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: IconButton(
                                              icon: Icon(Icons.favorite_border,color: Color(0xFF185a9d),), onPressed: () {},
                                            ),
                                          )
                                        ],
                                      ),
                                    )

                                  ],
                                ),
                              )),
                        )),
                  )
                      : Container();
                }),

        ));
  }
}




Widget _customAppBar(GlobalKey<ScaffoldState> globalKey, BuildContext context,
    String subcatergoryname) {
  return PreferredSize(
    preferredSize: Size.fromHeight(10 * SizeConfig.heightMultiplier),
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
            child: Padding(
              padding: EdgeInsets.only(
                  left: 1 * SizeConfig.widthMultiplier,
                  right: 2.2 * SizeConfig.widthMultiplier),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return SubCatergorylist();
                            }));
                      },
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            flex: 5,
                            child: Text(
                              subcatergoryname,
                              style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                            )),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
