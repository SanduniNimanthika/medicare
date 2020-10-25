
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:flutter/widgets.dart';
import 'package:medicare/module/cart.dart';
import 'package:medicare/services/database.dart';
import 'package:medicare/userdetails/home.dart';
import 'package:provider/provider.dart';
import 'package:medicare/notifier/cartnotifier.dart';
import 'package:medicare/database/cart.dart';
import 'package:medicare/module/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicare/userdetails/history.dart';
import 'package:intl/intl.dart';


class ProductCartlist extends StatefulWidget {
  @override
  _ProductCartlistState createState() => _ProductCartlistState();
}

class _ProductCartlistState extends State<ProductCartlist> {





  @override
  void initState() {
    super.initState();

    ProductCartNotifier productCartNotifier =
        Provider.of<ProductCartNotifier>(context, listen: false);
    getProductCarts(productCartNotifier);

  }

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ProductCartNotifier productCartNotifier =
        Provider.of<ProductCartNotifier>(context);

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
      appBar: _customAppBar(
        context,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: productCartNotifier.productCartList.length,
          itemBuilder: (BuildContext context, int index) {
            return
                InkWell(
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
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                  child: Material(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0)),
                    elevation: 5,
                    shadowColor: Colors.greenAccent,
                    child: Container(
                        height: MediaQuery.of(context).size.height / 9 * 2,
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
                                            topLeft: Radius.circular(25.0),
                                            bottomRight:
                                                Radius.circular(25.0))),
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25.0),
                                              bottomRight:
                                                  Radius.circular(25.0)),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  productCartNotifier
                                                      .productCartList[index]
                                                      .images),
                                              fit: BoxFit.fill)),
                                    )),
                              ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                  color: Color(0xFF185a9d),
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
                                                Icons.remove_shopping_cart,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                productCartNotifier
                                                        .currentProductCart =
                                                    productCartNotifier
                                                        .productCartList[index];
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
            );
            //  : Container();
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Text(
                      "Total:( x${productCartNotifier.productCartList.length})",
                      style: Theme.of(context).textTheme.subhead.copyWith(
                            color: Color(0xFF185a9d),
                          ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Consumer<ProductCartNotifier>(
                        builder: (context, cart, child) => Text(
                            '\$${cart.totalPrice}',
                            style: Theme.of(context).textTheme.subhead.copyWith(
                                  color: Colors.red,
                                ))),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Material(
                  borderRadius:
                      BorderRadius.circular(5 * SizeConfig.heightMultiplier),
                  elevation: 4.0,
                  child: InkWell(
                    onTap: ()

                        async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return EditUserDetail();
                          });
                    },
                    child: Container(
                      height: 40.0,
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
                            5 * SizeConfig.heightMultiplier),
                      ),
                      child: Center(
                        child: Text("Check out",
                            style: Theme.of(context).textTheme.subhead),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

//address and telenumber
class EditUserDetail extends StatefulWidget {
  @override
  _EditUserDetailState createState() => _EditUserDetailState();
}

class _EditUserDetailState extends State<EditUserDetail> {
  final DatabaseService databaseService = DatabaseService();

  final _formKey = GlobalKey<FormState>();

  String _currentName;

  String _currenttelenumber;
  String _currentaddress;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
    final String formatted = formatter.format(now);
    print(formatted);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      child: StreamBuilder<User>(
          stream: DatabaseService(uid: user.userkey).profileData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ));
            }
            final profile = snapshot.data;
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: SingleChildScrollView(
                child: Container(
                    color: Color(0xFFE3F2FD),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                              child: Text('Details',
                                  style: Theme.of(context).textTheme.subtitle),
                            ),
                            TextFormField(
                                initialValue: profile.fullname,
                                decoration: new InputDecoration(
                                  labelText: "Full Name",
                                  labelStyle:
                                      Theme.of(context).textTheme.display1,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(Icons.person,
                                      color: Colors.blueGrey),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF185a9d),
                                        style: BorderStyle.solid,
                                        width: 1),
                                    borderRadius:
                                        new BorderRadius.circular(22.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF185a9d),
                                        style: BorderStyle.solid,
                                        width: 1),
                                    borderRadius:
                                        new BorderRadius.circular(22.0),
                                  ),
                                ),
                                validator: (input) => input.isEmpty
                                    ? 'Please type your full name here'
                                    : null,
                                onChanged: (input) {
                                  setState(() {
                                    _currentName = input;
                                  });
                                },
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.display1),

                            // TP NUMBER
                            Padding(
                              padding: EdgeInsets.only(
                                top: 5 * SizeConfig.heightMultiplier,
                              ),
                              child: Container(
                                child: new Center(
                                    child: new TextFormField(
                                        initialValue: profile.telenumber,
                                        decoration: new InputDecoration(
                                          labelText: "Telephone Number",
                                          prefixIcon: Icon(Icons.phone,
                                              color: Colors.blueGrey),
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .display1,
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF185a9d),
                                                style: BorderStyle.solid,
                                                width: 1),
                                            borderRadius:
                                                new BorderRadius.circular(22.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF185a9d),
                                                style: BorderStyle.solid,
                                                width: 1),
                                            borderRadius:
                                                new BorderRadius.circular(22.0),
                                          ),
                                        ),
                                        validator: (input) => input.length != 10
                                            ? 'Your telephone number is incorrect'
                                            : null,
                                        onChanged: (input) {
                                          setState(() {
                                            _currenttelenumber = input;
                                          });
                                        },
                                        keyboardType: TextInputType.phone,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1)),
                              ),
                            ),

                            //Address
                            Padding(
                              padding: EdgeInsets.only(
                                top: 5 * SizeConfig.heightMultiplier,
                              ),
                              child: Container(
                                child: new Center(
                                    child: new TextFormField(
                                        initialValue: profile.address,
                                        decoration: new InputDecoration(
                                          labelText: "Address",
                                          prefixIcon: Icon(Icons.home,
                                              color: Colors.blueGrey),
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .display1,
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF185a9d),
                                                style: BorderStyle.solid,
                                                width: 1),
                                            borderRadius:
                                                new BorderRadius.circular(22.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF185a9d),
                                                style: BorderStyle.solid,
                                                width: 1),
                                            borderRadius:
                                                new BorderRadius.circular(22.0),
                                          ),
                                        ),
                                        validator: (input) => input.isEmpty
                                            ? 'Please type your address here'
                                            : null,
                                        onChanged: (input) {
                                          setState(() {
                                            _currentaddress = input;
                                          });
                                        },
                                        keyboardType: TextInputType.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1)),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                top: 7 * SizeConfig.heightMultiplier,
                                bottom: 3 * SizeConfig.heightMultiplier,
                              ),
                              child: Material(
                                borderRadius: BorderRadius.circular(
                                    5 * SizeConfig.heightMultiplier),
                                elevation: 4.0,
                                child: InkWell(
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      final FirebaseAuth _auth =
                                          FirebaseAuth.instance;

                                      FirebaseUser user =
                                          await _auth.currentUser();
                                      print(user.uid);
                                      Firestore.instance
                                          .collection('ProductCart')
                                          .where('userkey', isEqualTo: user.uid)
                                          .orderBy("productname",
                                              descending: true)
                                          .getDocuments()
                                          .then((querySnapshot) {
                                        querySnapshot.documents
                                            .forEach((result) {
                                          // new documents would be created in other collection
                                          final CollectionReference
                                              productCollection =
                                              Firestore.instance.collection(
                                                  'SuccessFullOrders');

                                          String id = productCollection
                                              .document()
                                              .documentID;
                                          productCollection
                                              .document(id)
                                              .setData(result.data);
                                          productCollection
                                              .document(id)
                                              .updateData({
                                            'fullname': _currentName!=null?_currentName:profile.fullname,
                                            'telenumber': _currenttelenumber!=null?_currenttelenumber:profile.telenumber,
                                            'address': _currentaddress!=null?_currentaddress:profile.address,
                                            'date':formatted,
                                            'status':'pending',
                                            'productOrderHistorykey':id
                                          });

                                          print(result.data);
                                        });
                                      });
                                      Firestore.instance
                                          .collection('ProductCart')
                                          .where('userkey', isEqualTo: user.uid)
                                          .getDocuments().then((snapshot) {
                                        for (DocumentSnapshot doc in snapshot
                                            .documents) {
                                          doc.reference.delete();
                                        }
                                      },);

                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => History()));

                                    }
                                  },
                                  child: Container(
                                    height: 6.7 * SizeConfig.heightMultiplier,
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
                                          5 * SizeConfig.heightMultiplier),
                                    ),
                                    child: Center(
                                      child: Text("Save",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 5 * SizeConfig.heightMultiplier),
                              child: Material(
                                borderRadius: BorderRadius.circular(
                                    4 * SizeConfig.heightMultiplier),
                                elevation: 7.0,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 6.7 * SizeConfig.heightMultiplier,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFE3F2FD),
                                        borderRadius: BorderRadius.circular(
                                            4 * SizeConfig.heightMultiplier),
                                        border: Border.all(
                                            color: Color(0xFF185a9d),
                                            style: BorderStyle.solid,
                                            width: 2.0)),
                                    child: Center(
                                      child: Text("Cancle",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead
                                              .copyWith(
                                                  color: Color(0xFF185a9d))),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ])),
                    )),
              ),
            );
          }),
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

//edit quntity

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
      _currentProductCart.fullprice = title * _currentProductCart.price;
    });
    uploadProductCart(_currentProductCart, _onProductUploaded);
  }

  void remove() {
    setState(() {
      if (title > 1) title -= 1;
      _currentProductCart.quntity = title;
      _currentProductCart.fullprice = title * _currentProductCart.price;
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

//appbar

Widget _customAppBar(
  BuildContext context,
) {
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
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return UserHome();
                      }));
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: Text(
                    "My cart",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
