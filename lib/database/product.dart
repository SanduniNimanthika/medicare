import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/module/product.dart';
import 'package:medicare/notifier/productnoti.dart';
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