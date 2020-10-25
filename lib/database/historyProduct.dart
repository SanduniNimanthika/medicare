import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/module/historyProduct.dart';
import 'package:medicare/notifier/odernotifer.dart';
import 'package:firebase_auth/firebase_auth.dart';

getProductOrderHistory(
    ProductOrderHistoryNotifier productOrderHistoryNotifier) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  print(user.uid);
  QuerySnapshot snapshot = await Firestore.instance
      .collection('SuccessFullOrders')
      .where('userkey', isEqualTo: user.uid)
      .orderBy("date", descending: true)
      .getDocuments();

  List<ProductOrderHistory> _productOrderHistoryList = [];

  snapshot.documents.forEach((document) {
    ProductOrderHistory productOrderHistory =
        ProductOrderHistory.fromMap(document.data);
    _productOrderHistoryList.add(productOrderHistory);
  });

  productOrderHistoryNotifier.productOrderHistoryList =
      _productOrderHistoryList;
}
