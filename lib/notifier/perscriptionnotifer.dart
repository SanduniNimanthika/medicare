import 'dart:collection';

import 'package:medicare/module/perscriptionOrder.dart';
import 'package:flutter/cupertino.dart';

class PerscriptionOrderHistoryNotifier with ChangeNotifier {
  List<ProductPerscription> _perscriptionOrderHistoryList = [];

  ProductPerscription _currentPerscriptionOrderHistory;

  UnmodifiableListView<ProductPerscription> get perscriptionOrderHistoryList =>
      UnmodifiableListView(_perscriptionOrderHistoryList);

  ProductPerscription get currentPerscriptionOrderHistory =>
      _currentPerscriptionOrderHistory;

  set perscriptionOrderHistoryList(
      List<ProductPerscription> perscriptionOrderHistorylist) {
    _perscriptionOrderHistoryList = perscriptionOrderHistorylist;
    notifyListeners();
  }

  set currentPerscriptionOrderHistory(ProductPerscription productPerscription) {
    _currentPerscriptionOrderHistory = productPerscription;
    notifyListeners();
  }
}
