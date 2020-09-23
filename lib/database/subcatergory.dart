import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/notifier/subcatnoti.dart';
import 'package:medicare/module/subcatergory.dart';


getSubCatergories(SubCatergoryNotifier subcatergoryNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('SubCatergory')

      .orderBy("subcatergory", descending:true)
      .getDocuments();

  List<SubCatergory> _subcatergoryList = [];

  snapshot.documents.forEach((document) {
    SubCatergory subcatergory = SubCatergory.fromMap(document.data);
    _subcatergoryList.add(subcatergory);
  });

  subcatergoryNotifier.subcatergoryList =  _subcatergoryList;
}