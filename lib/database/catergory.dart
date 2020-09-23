import 'package:medicare/notifier/catergorynoti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/module/Category.dart';


getCatergories(CatergoryNotifier catergoryNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Catergory')
      .orderBy("catergory", descending:false)
      .getDocuments();

  List<Catergory> _catergoryList = [];

  snapshot.documents.forEach((document) {
    Catergory catergory = Catergory.fromMap(document.data)!=null?Catergory.fromMap(document.data):null;
    _catergoryList.add(catergory);
  });

  catergoryNotifier.catergoryList = _catergoryList;
}