import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  
  
            //database collection
final CollectionReference userCollection=Firestore.instance.collection('User');

  Future updateUserData( String fullname,
  String email,
  String address,
  String telenumber)async{
    return await userCollection.document(uid).setData({
      'fullname':fullname,
      'email':email,
      'address':address,
      'telenumber':telenumber,
    });


  }

}