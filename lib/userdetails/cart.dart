import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:flutter/widgets.dart';
import 'package:medicare/module/cart.dart';
import 'package:medicare/userdetails/home.dart';
import 'package:provider/provider.dart';
import 'package:medicare/notifier/cartnotifier.dart';
import 'package:medicare/database/cart.dart';
import 'package:medicare/module/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductCartlist extends StatefulWidget {
  @override
  _ProductCartlistState createState() => _ProductCartlistState();
}

class _ProductCartlistState extends State<ProductCartlist> {
  var totalCartValue = 0;
   getCartTotal() async {

    QuerySnapshot snapshot = await Firestore.instance
        .collection('ProductCart')
       .where("userkey", isEqualTo: Provider.of<User>(context).userkey)
        .getDocuments();

    snapshot.documents.forEach((doc) {
      setState((){
        totalCartValue += doc.data['price'];
      });
    });
    return totalCartValue.toString();
  }

  @override
  void initState() {
    super.initState();

    ProductCartNotifier productCartNotifier =
        Provider.of<ProductCartNotifier>(context, listen: false);
    getProductCarts(productCartNotifier);
    getCartTotal();
  }

  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    ProductCartNotifier productCartNotifier =
        Provider.of<ProductCartNotifier>(context);

    final user = Provider.of<User>(context);
    _onProductCartDeleted(ProductCart productCart) {
      Navigator.pop(context);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return ProductCartlist();
        },
      ));

      productCartNotifier.deleteProductCart(productCart);
    }

    return SafeArea(
        child: Scaffold(
      key: _key,
      appBar: _customAppBar(context,totalCartValue.toString()),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: productCartNotifier.productCartList.length,
          itemBuilder: (BuildContext context, int index) {
            return (user.userkey ==
                    productCartNotifier.productCartList[index].userkey)
                ? InkWell(
                    onTap: () {
                      productCartNotifier.currentProductCart =
                          productCartNotifier.productCartList[index];
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Edit();
                          });
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
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(25.0),
                                                    bottomRight:
                                                        Radius.circular(25.0)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        productCartNotifier
                                                            .productCartList[
                                                                index]
                                                            .images),
                                                    fit: BoxFit.fill)),
                                          )),
                                    ),
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
                                                productCartNotifier
                                                    .productCartList[index]
                                                    .productname,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subhead
                                                    .copyWith(
                                                        color:
                                                            Color(0xFF185a9d),
                                                        fontSize: 20.0),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Rs.${productCartNotifier.productCartList[index].price.toString()}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display1,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Qty - .${productCartNotifier.productCartList[index].quntity.toString()}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Column(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons
                                                          .remove_shopping_cart,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      productCartNotifier
                                                              .currentProductCart =
                                                          productCartNotifier
                                                                  .productCartList[
                                                              index];
                                                      deleteProductCart(
                                                          productCartNotifier
                                                              .currentProductCart,
                                                          _onProductCartDeleted);
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.favorite_border,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )))
                                  ],
                                ),
                              )),
                        )),
                  )
                : Container();
          }),
      //    bottomNavigationBar: BottomNavigationBar(
          //    items: [
        //  BottomNavigationBarItem(
        //  icon: new Icon(Icons.add),
       //   title: new Text(totalCartValue.toString()),
     //   ),
  //  ]
      //  )
    )
    );

  }
}







class Edit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductCartNotifier productCartNotifier =
        Provider.of<ProductCartNotifier>(context);
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
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3 * 1,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(45.0),
                                bottomRight: Radius.circular(45.0)),
                            image: DecorationImage(
                                image: NetworkImage(productCartNotifier
                                    .currentProductCart.images),
                                fit: BoxFit.fill)),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 25.0),
                    child: Text(
                      productCartNotifier.currentProductCart.productname,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(fontSize: 29),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 35.0, bottom: 15.0),
                    child: Text(
                        'Rs. ${productCartNotifier.currentProductCart.price.toString()}',
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontSize: 19.0)),
                  ),
                  Divider(
                    color: Colors.blueGrey,
                    thickness: .3,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 15.0, top: 15),
                      child: EditQty(
                        title: productCartNotifier.currentProductCart.quntity,
                      )),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, bottom: 35.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 15.0,
                            ),
                            child: Text('Total Price:',
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .copyWith(
                                        fontSize: 19.0,
                                        color: Color(0xFF185a9d))),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                              'Rs. ${productCartNotifier.currentProductCart.price * productCartNotifier.currentProductCart.quntity}',
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(fontSize: 19.0)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0, top: 5),
                    child: Center(
                      child: Material(
                        borderRadius: BorderRadius.circular(
                            2 * SizeConfig.heightMultiplier),
                        elevation: 7.0,
                        child: InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 6.7 * SizeConfig.heightMultiplier,
                            width: 29 * SizeConfig.heightMultiplier,
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
                                  2 * SizeConfig.heightMultiplier),
                            ),
                            child: Center(
                              child: Text("Edit",
                                  style: Theme.of(context).textTheme.subhead),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))));
  }
}

class EditQty extends StatefulWidget {
  final int title;

  EditQty({
    Key key,
    @required this.title,
  }) : super(key: key);
  @override
  _EditQtyState createState() => _EditQtyState(title: title);
}

class _EditQtyState extends State<EditQty> {
  int title;
  _EditQtyState({
    Key key,
    @required this.title,
  });

  ProductCart _currentProductCart;
  @override
  void initState() {
    super.initState();
    ProductCartNotifier productCartNotifier =
        Provider.of<ProductCartNotifier>(context, listen: false);
    getProductCarts(productCartNotifier);
    if (productCartNotifier.currentProductCart != null) {
      _currentProductCart = productCartNotifier.currentProductCart;
    } else {
      _currentProductCart = ProductCart();
    }
  }

  _onProductUploaded(ProductCart productCart) {
    ProductCartNotifier productCartNotifier =
        Provider.of<ProductCartNotifier>(context, listen: false);
    productCartNotifier.addProductCart(productCart);
  }

  // int quty = title;
  void _add() {
    setState(() {
      title += 1;
      _currentProductCart.quntity = title;
    });
    uploadProductCart(_currentProductCart, _onProductUploaded);
  }

  void remove() {
    setState(() {
      if (title > 1) title -= 1;
      _currentProductCart.quntity = title;
    });
    uploadProductCart(_currentProductCart, _onProductUploaded);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _quntity(
        _add,
        remove,
        title,
        context,
      ),
    );
  }
}

Widget _quntity(
  Function add,
  Function remove,
  int qty,
  context,
) {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Text(
            "Qty:",
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(color: Color(0xFF185a9d), fontSize: 19),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: CustomButton(
            iconData: Icons.add, onTap: add,
            //index
          ),
        ),
      ),
      Expanded(flex: 1, child: _boxQuty(qty, context)),
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: CustomButton(
            iconData: Icons.remove,
            onTap: remove,

            //  index
          ),
        ),
      )
    ],
  );
}

Widget _boxQuty(int qty, context) {
  return Container(
    decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(2 * SizeConfig.heightMultiplier),
        border: Border.all(color: Color(0xFF185a9d))),
    height: 4.7 * SizeConfig.heightMultiplier,
    //  width: 6.7 * SizeConfig.heightMultiplier,
    child: Center(
        child: Text(
      qty.toString(),
      style: Theme.of(context).textTheme.display1,
    )),
  );
}

class CustomButton extends StatelessWidget {
  final IconData iconData;
  final Function onTap;

  const CustomButton({
    Key key,
    this.iconData,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          //  borderRadius: BorderRadius.circular(2 * SizeConfig.heightMultiplier),
        ),
        height: 4.7 * SizeConfig.heightMultiplier,
        //  width: 6.7 * SizeConfig.heightMultiplier,
        child: Icon(
          iconData,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }
}

Widget _customAppBar(
  BuildContext context,String text
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
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Text(text),
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (BuildContext context) {
                      return UserHome();
                    }));
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
