import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/module/cart.dart';
import 'package:medicare/notifier/cartnotifier.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductCartService {
  String ref = 'ProductCart';
  final String uid;

  ProductCartService({
    this.uid,
  });

  //database collection
  final CollectionReference productCollection =
  Firestore.instance.collection('ProductCart');

  Future createProductCartData(
      String productname,
          String userkey,
      String productkey,

      int quntity,
      double price,
      double fullprice,
      String images,
      ) async {
    String id = productCollection.document().documentID;
    return await productCollection.document(id).setData({
      'uid': id,
      'productname': productname,
      'userkey': userkey,
      'productkey': productkey,

      'quntity': quntity,
      'price': price,
      'fullprice': fullprice,
      'images': images,

    });
  }
}

getProductCarts(ProductCartNotifier productCartNotifier) async {

  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  print(user.uid);
  QuerySnapshot snapshot = await Firestore.instance
      .collection('ProductCart')
  .where('userkey',isEqualTo:user.uid )
      .orderBy("productname", descending: true)
      .getDocuments();

  List<ProductCart> _productCartList = [];

  snapshot.documents.forEach((document) {
    ProductCart productCart = ProductCart.fromMap(document.data);
    _productCartList.add(productCart);
  });

  productCartNotifier.productCartList = _productCartList;
}




uploadProductCart(ProductCart productCart,Function productUploaded)async{

  _uploadProductCart(productCart,productUploaded );

}

_uploadProductCart(ProductCart productCart,/* bool isUpdating*/ Function productUploaded) async {
  CollectionReference catergoryCollection = Firestore.instance.collection('ProductCart');

  await catergoryCollection.document(productCart.productcartkey).updateData(productCart.toMap());
  productUploaded(productCart);


}

deleteProductCart(ProductCart productCart, Function productCartDeleted) async {

  await Firestore.instance
      .collection('ProductCart')
      .document(productCart.productcartkey)
      .delete();
  productCartDeleted(productCart);
}

