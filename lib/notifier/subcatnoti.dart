import 'dart:collection';
import 'package:medicare/module/subcatergory.dart';
import 'package:flutter/cupertino.dart';

class SubCatergoryNotifier with ChangeNotifier {
  List<SubCatergory> _subcatergoryList = [];
  SubCatergory _currentSubCatergory;

  UnmodifiableListView<SubCatergory> get subcatergoryList => UnmodifiableListView(_subcatergoryList);

  SubCatergory get currentSubCatergory => _currentSubCatergory;

  set subcatergoryList(List<SubCatergory> subcatergorylist) {
    _subcatergoryList = subcatergorylist;
    notifyListeners();
  }

  set currentSubCatergory(SubCatergory subcatergory) {
    _currentSubCatergory = subcatergory;
    notifyListeners();
  }


}