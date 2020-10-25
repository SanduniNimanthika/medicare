import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/notifier/perscriptionnotifer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicare/module/perscriptionOrder.dart';

class PerscriptionOrder {
  String ref = 'PerscriptionOrder';
  final String uid;

  PerscriptionOrder({
    this.uid,
  });

  //database collection
  final CollectionReference productCollection =
      Firestore.instance.collection('PerscriptionOrder');

  Future createPerscriptionOrder(
      String fullname,
      String firstlineaddress,
      String telenumber,
      String email,
      String hometown,
      int days,
      String specialDescription,
      String images,
      String status,
      String date) async {
    String id = productCollection.document().documentID;
    return await productCollection.document(id).setData({
      'uid': id,
      'fullname': fullname,
      'telenumber': telenumber,
      'firstlineaddress': firstlineaddress,
      'hometown': hometown,
      'images': images,
      'days': days,
      'specialDescription': specialDescription,
      'status': status,
      'email': email,
      'date': date,
    });
  }
}

getPerscriptionOrderHistory(
    PerscriptionOrderHistoryNotifier perscriptionOrderHistoryNotifier) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  print(user.uid);
  QuerySnapshot snapshot = await Firestore.instance
      .collection('PerscriptionOrder')
      .where('email', isEqualTo: user.email)
      .orderBy("date", descending: true)
      .getDocuments();

  List<ProductPerscription> _perscriptionOrderHistoryList = [];

  snapshot.documents.forEach((document) {
    ProductPerscription perscriptionOrderHistory =
        ProductPerscription.fromMap(document.data);
    _perscriptionOrderHistoryList.add(perscriptionOrderHistory);
  });

  perscriptionOrderHistoryNotifier.perscriptionOrderHistoryList =
      _perscriptionOrderHistoryList;
}
