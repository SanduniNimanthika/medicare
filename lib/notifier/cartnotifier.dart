import 'dart:collection';

import 'package:medicare/module/cart.dart';
import 'package:flutter/cupertino.dart';

class ProductCartNotifier with ChangeNotifier {
  List<ProductCart> _productCartList = [];
  ProductCart _currentProductCart;



  UnmodifiableListView<ProductCart> get productCartList => UnmodifiableListView(_productCartList);

  ProductCart get currentProductCart => _currentProductCart;

  set productCartList(List<ProductCart> productCartlist) {
    _productCartList = productCartlist;
    notifyListeners();
  }

  set currentProductCart(ProductCart productCart) {
    _currentProductCart = productCart;
    notifyListeners();
  }
  addProductCart(ProductCart productCart) {
    _productCartList.insert(0, productCart);
    notifyListeners();
  }
  deleteProductCart(ProductCart productCart) {

    _productCartList.removeWhere((_productCart) => _productCart.productcartkey == productCart.productcartkey);
    notifyListeners();
  }

}