import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/module/product.dart';
import 'package:medicare/notifier/productnoti.dart';
class ProductService {
  String ref = 'Product';
  final String uid;

  ProductService({
    this.uid,
  });

  //database collection
  final CollectionReference productCollection =
  Firestore.instance.collection('Product');
  Future <List<DocumentSnapshot>>getSuggestions(String suggestion)=>
      productCollection.where('productname',isGreaterThanOrEqualTo: suggestion).getDocuments().then((snap){
        return snap.documents;
      });

}
getProducts(ProductNotifier productNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Product')
      .orderBy("productname", descending: true)
      .getDocuments();

  List<Product> _productList = [];

  snapshot.documents.forEach((document) {
    Product product = Product.fromMap(document.data);
    _productList.add(product);
  });

  productNotifier.productList = _productList;
}


getProductsOffer(ProductNotifier productNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Product').where('offer',isGreaterThan: 0.0)

      .getDocuments();

  List<Product> _productList = [];

  snapshot.documents.forEach((document) {
    Product product = Product.fromMap(document.data);
    _productList.add(product);
  });

  productNotifier.productList = _productList;
}