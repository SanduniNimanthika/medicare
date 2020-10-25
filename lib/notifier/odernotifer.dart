import 'dart:collection';

import 'package:medicare/module/historyProduct.dart';
import 'package:flutter/cupertino.dart';


class ProductOrderHistoryNotifier with ChangeNotifier {
  List<ProductOrderHistory> _productOrderHistoryList = [];

  ProductOrderHistory _currentProductOrderHistory;




  UnmodifiableListView<ProductOrderHistory> get productOrderHistoryList => UnmodifiableListView(_productOrderHistoryList);

  ProductOrderHistory get currentProductOrderHistory => _currentProductOrderHistory;

  set productOrderHistoryList(List<ProductOrderHistory> productOrderHistorylist) {
    _productOrderHistoryList = productOrderHistorylist;
    notifyListeners();
  }

  set currentProductOrderHistory(ProductOrderHistory productOrderHistory) {
    _currentProductOrderHistory = productOrderHistory;
    notifyListeners();
  }




  deleteProductOrderHistory(ProductOrderHistory productOrderHistory) {

    _productOrderHistoryList.removeWhere((_productOrderHistory) => _productOrderHistory.productOrderHistorykey == productOrderHistory.productOrderHistorykey);
    notifyListeners();
  }

}