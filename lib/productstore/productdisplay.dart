import 'package:flutter/cupertino.dart';
import 'package:medicare/mainpages/tabhomepage.dart';
import 'package:medicare/notifier/productnoti.dart';
import 'package:medicare/database/product.dart';
import 'package:flutter/material.dart';
import 'package:medicare/productstore/catergorylist.dart';
import 'package:medicare/productstore/productlist.dart';
import 'package:medicare/userdetails/cart.dart';
import 'package:flutter/widgets.dart';
import 'package:medicare/userdetails/home.dart';
import 'package:provider/provider.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:medicare/module/user.dart';
import 'package:medicare/loginSignup/welcome.dart';
import 'package:medicare/database/cart.dart';

class ProductDisplay extends StatefulWidget {
  final String back;
  ProductDisplay({Key key, @required this.back}) : super(key: key);
  @override
  _ProductDisplayState createState() => _ProductDisplayState(back: this.back);
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

class _ProductDisplayState extends State<ProductDisplay> {
  String back;
  _ProductDisplayState({this.back});
  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    getProducts(productNotifier);
    super.initState();
  }

  int quty = 1;
  void _add() {
    setState(() {
      quty += 1;
    });
  }

  void remove() {
    setState(() {
      if (quty > 1) quty -= 1;
    });
  }

  ProductCartService _cartService = ProductCartService();

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(45.0),
                                bottomRight: Radius.circular(45.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    productNotifier.currentProduct.images),
                                fit: BoxFit.fill)),
                      )),
                  (back == 'offer')
                      ? IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Store();
                            }));
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        )
                      : Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                          return Productlist();
                        }))
                ],
              ),
              Column(
                // shrinkWrap: false,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: 9 * SizeConfig.heightMultiplier),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                  ),
                  Container(
                    height: 400,
                    child: PageView(
                        scrollDirection: Axis.horizontal,
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentpage = page;
                          });
                        },
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 25, left: 25.0, top: 25.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: Text(
                                    productNotifier.currentProduct.productname,
                                    style: Theme.of(context).textTheme.subtitle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'By ${productNotifier.currentProduct.catergory}',
                                    style: Theme.of(context).textTheme.display1,
                                  ),
                                ),
                                (productNotifier.currentProduct.capsualtype ==
                                        true)
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Box Prices(Capsual)',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle
                                                .copyWith(fontSize: 16),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Padding(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: (productNotifier
                                              .currentProduct.offerprice ==
                                          0)
                                      ? Row(
                                          children: <Widget>[
                                            Text('Product Price :',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display1),
                                            Text(
                                                'Rs. ${productNotifier.currentProduct.price.toString()}',
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
                                                  'Rs.${productNotifier.currentProduct.offerprice.toString()}',
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
                                                    'Rs.${productNotifier.currentProduct.price.toString()}',
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
                                (productNotifier.currentProduct.capsualtype ==
                                        true)
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 25.0, bottom: 25),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Card Prices(Capsual)',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle
                                                  .copyWith(fontSize: 16),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text('Product Card Price :',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .display1),
                                                    Text(
                                                        'Rs. ${productNotifier.currentProduct.cardprice.toString()}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .display1),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 25.0, bottom: 25.0, top: 15),
                                  child: _quntity(_add, remove, quty, context),
                                ),
                                Divider(
                                  color: Colors.blueGrey,
                                  thickness: .3,
                                ),
                              ],
                            ),
                          ),

                          // second page
                          ListView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 25.0,
                                    bottom: 15.0),
                                child: Text('Product description',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(fontSize: 20.0)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, bottom: 150.0),
                                child: Text(
                                  '\t ${productNotifier.currentProduct.description}',
                                  style: Theme.of(context).textTheme.display1,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(22),
                    elevation: 7.0,
                    child: InkWell(
                      onTap: () async {
                        final user = Provider.of<User>(context, listen: false);
                        if (user == null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Tabcontroller(3)));
                        } else {
                          if (productNotifier.currentProduct.type ==
                              'nonperscription required') {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ProductCartlist()));
                            await _cartService.createProductCartData(
                                productNotifier.currentProduct.productname,
                                user.userkey,
                                productNotifier.currentProduct.productkey,
                                quty,
                                productNotifier.currentProduct.price,
                                quty * productNotifier.currentProduct.price,
                                productNotifier.currentProduct.images);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserHome()));
                          }
                        }
                      },
                      child: Container(
                        height: 43,
                        decoration: BoxDecoration(
                          gradient: (productNotifier.currentProduct.type ==
                                  'nonperscription required')
                              ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFF185a9d),
                                    const Color(0xFF43cea2)
                                  ],
                                )
                              : LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.red, Colors.red[200]],
                                ),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Center(
                            child: (productNotifier.currentProduct.type ==
                                    'nonperscription required')
                                ? Text("Add to Cart",
                                    style: Theme.of(context).textTheme.subhead)
                                : Text("Perscription required",
                                    style:
                                        Theme.of(context).textTheme.subhead)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _quntity(Function add, Function remove, int qty, context) {
  return Row(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Text(
          "Qty:",
          style: Theme.of(context).textTheme.display1,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: CustomButton(
          iconData: Icons.add,
          onTap: add,
        ),
      ),
      _boxQuty(qty, context),
      Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: CustomButton(
          iconData: Icons.remove,
          onTap: remove,
        ),
      )
    ],
  );
}

Widget _boxQuty(int qty, context) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1 * SizeConfig.heightMultiplier),
        border: Border.all(color: Color(0xFF185a9d))),
    height: 6 * SizeConfig.heightMultiplier,
    width: 6 * SizeConfig.heightMultiplier,
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

  const CustomButton({Key key, this.iconData, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
          ),
          borderRadius: BorderRadius.circular(1 * SizeConfig.heightMultiplier),
        ),
        height: 6 * SizeConfig.heightMultiplier,
        width: 6 * SizeConfig.heightMultiplier,
        child: Icon(
          iconData,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }
}
