import 'dart:collection';

import 'package:medicare/module/product.dart';
import 'package:flutter/cupertino.dart';

class ProductNotifier with ChangeNotifier {
  List<Product> _productList = [];
  Product _currentProduct;



  UnmodifiableListView<Product> get productList => UnmodifiableListView(_productList);

  Product get currentProduct => _currentProduct;

  set productList(List<Product> productlist) {
    _productList = productlist;
    notifyListeners();
  }

  set currentProduct(Product product) {
    _currentProduct = product;
    notifyListeners();
  }


}