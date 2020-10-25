class ProductCart {
  String productcartkey;
  String productname;
  String userkey;
  String productkey;

  int quntity;
  double price;
  double fullprice;
  String images;


  ProductCart(
      {this.productcartkey,
        this.productname,
        this.userkey,
        this.productkey,
        this.quntity,
        this.price,
        this.fullprice,
        this.images,});




  ProductCart.fromMap(Map<String, dynamic> data) {
    productcartkey = data['uid'];
    userkey=data['userkey'];
    productkey=data['productkey'];
    productname=data['productname'];

    quntity=data['quntity'];
    price=data['price'];
    fullprice=data['fullprice'];

    images=data['images'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': productcartkey,
      'productname': productname,
      'userkey': userkey,
      'productkey':productkey,
      'images': images,
      'quntity':quntity,
      'price':price,
      'fullprice':fullprice,

    };
  }
}


