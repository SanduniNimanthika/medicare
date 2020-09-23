import 'dart:collection';
import 'package:medicare/module/Category.dart';
import 'package:flutter/cupertino.dart';

class CatergoryNotifier with ChangeNotifier {
  List<Catergory> _catergoryList = [];
  Catergory _currentCatergory;



  UnmodifiableListView<Catergory> get catergoryList => UnmodifiableListView(_catergoryList);

  Catergory get currentCatergory => _currentCatergory;

  set catergoryList(List<Catergory> catergorylist) {
    _catergoryList = catergorylist;
    notifyListeners();
  }

  set currentCatergory(Catergory catergory) {
    _currentCatergory = catergory;
    notifyListeners();
  }




}