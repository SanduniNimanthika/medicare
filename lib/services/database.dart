import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/module/user.dart';




class DatabaseService{
  final String uid;

  DatabaseService({this.uid,});
  

            //database collection
final CollectionReference userCollection=Firestore.instance.collection('User');

  Future updateUserData( String fullname,
  String email,
  String telenumber,
      String address,)async{
    return await userCollection.document(uid).setData({
      'uid':uid,
      'fullname':fullname,
      'email':email,
      'telenumber':telenumber,
      'address':address,
    });

  }





  //user profile data from snapshot
  User _userProfileDataFromSnapshot(DocumentSnapshot snapshot){
    return User(
        userkey: snapshot.documentID,
        fullname: snapshot.data['fullname'],
        email: snapshot.data['email'],
        telenumber: snapshot.data['telenumber'],
      address: snapshot.data['address'],

    );
  }


//get user stream
  Stream<User> get profileData{
    return userCollection.document(this.uid).snapshots()
        .map(_userProfileDataFromSnapshot);
  }
}







