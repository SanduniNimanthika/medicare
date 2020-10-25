import 'package:flutter/cupertino.dart';
import 'package:medicare/mainpages/tabhomepage.dart';
import 'package:medicare/notifier/productnoti.dart';
import 'package:medicare/database/product.dart';
import 'package:flutter/material.dart';
import 'package:medicare/userdetails/cart.dart';
import 'package:flutter/widgets.dart';
import 'package:medicare/userdetails/home.dart';
import 'package:provider/provider.dart';
import 'package:medicare/commanpages/configue.dart';
import 'package:medicare/module/user.dart';
import 'package:medicare/loginSignup/welcome.dart';
import 'package:medicare/database/cart.dart';

class ProductDisplay extends StatefulWidget {
  @override
  _ProductDisplayState createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  @override
  void initState() {
    ProductNotifier productNotifier =
    Provider.of<ProductNotifier>(context, listen: false);
    getProducts(productNotifier);
    super.initState();
  }
  int quty=1;
  void _add(){
    setState(() {
      quty+=1;
    });}

    void remove(){
      setState(() {
        if(quty>1)
          quty-=1;
      });
    }
  ProductCartService _cartService = ProductCartService();

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);



    return SafeArea(
      child: Scaffold(
        appBar:_customAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 25.0),
                child: Text(
                  productNotifier.currentProduct.productname,
                  style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 29),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0),
                child: Text(
                  'By ${productNotifier.currentProduct.catergory}',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 35.0),
                child: Text(
                    'Rs. ${productNotifier.currentProduct.price.toString()}',
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
                    left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
                child: Text('Product description',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(fontSize: 20.0)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25.0, bottom: 25.0),
                child: Text(
                  '\t ${productNotifier.currentProduct.description}',
                  style: Theme.of(context).textTheme.display1,
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 25.0, bottom: 25.0),
                child: _quntity(_add,remove,quty,context),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                    elevation: 7.0,
                    child: InkWell(
                      onTap: ()async{
                        final user = Provider.of<User>(context);
                        if(user == null){



                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Tabcontroller(3)));
                        }else{ if(productNotifier.currentProduct.type=='nonperscription required'){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>ProductCartlist()));
                          await _cartService.createProductCartData(productNotifier.currentProduct.productname,
                              user.userkey, productNotifier.currentProduct.productkey,
                              quty,productNotifier.currentProduct.price ,quty*productNotifier.currentProduct.price,productNotifier.currentProduct.images);

                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHome()));
                        }
                        }


                      },
                      child: Container(
                        height: 40,
                        width: 29*SizeConfig.heightMultiplier,
                        decoration: BoxDecoration(

                          gradient:(productNotifier.currentProduct.type=='nonperscription required') ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],):LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [ Colors.red,  Colors.red[200]],),
                          borderRadius: BorderRadius.circular(2*SizeConfig.heightMultiplier),
                        ),
                        child: Center(
                          child:(productNotifier.currentProduct.type=='nonperscription required') ?Text("Add to Cart",
                              style:Theme.of(context).textTheme.subhead):Text("Perscription required",
                            style:Theme.of(context).textTheme.subhead)
                        ),
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


Widget  _customAppBar(context){
  return PreferredSize(
    preferredSize: Size.fromHeight(10*SizeConfig.heightMultiplier),
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                  onPressed: (){
                    Navigator.pop(context);

                  }
              ),
              IconButton(icon: Icon(Icons.favorite_border,color: Colors.white,),
                  onPressed: (){
                    final user = Provider.of<User>(context);
                    if(user == null){
                    }else{

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>ProductCartlist()));

                    }

                  },
              ),


            ],
          ),
        ),
      ),
    ),
  );
}

Widget _quntity (Function add,Function remove,int qty,context){
  return  Row(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(
            right: 15.0),
        child: Text("Qty:",style: Theme.of(context).textTheme.display1,),
      ),
      Padding(
        padding: const EdgeInsets.only(
            right: 15.0),
        child: CustomButton(
          iconData: Icons.add,
          onTap: add,
        ),
      ),
      _boxQuty(qty,context),
      Padding(
        padding: const EdgeInsets.only(
            left: 15.0),
        child: CustomButton(
          iconData: Icons.remove,
          onTap: remove,
        ),
      )
    ],
  );
}

Widget _boxQuty(int qty,context){
  return Container(
    decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(1*SizeConfig.heightMultiplier),
        border:Border.all(
            color: Color(0xFF185a9d)
        )
    ),
        height: 6*SizeConfig.heightMultiplier,
        width: 6*SizeConfig.heightMultiplier,

    child: Center(child: Text(qty.toString(),style: Theme.of(context).textTheme.display1,)),
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
            colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
          borderRadius: BorderRadius.circular(1*SizeConfig.heightMultiplier),
        ),
        height: 6*SizeConfig.heightMultiplier,
        width: 6*SizeConfig.heightMultiplier,
        child: Icon(iconData,color: Colors.white,size: 15,),
      ),
    );
  }
}
