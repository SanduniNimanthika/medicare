

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/mainpages/homepage.dart';
import 'package:medicare/module/user.dart';
import 'package:medicare/userdetails/database.dart';




class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;

                        //user object based on firebased
  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null?User(uid:user.uid ):null;
  }

            //auth change  user steam
  Stream<User>get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }
        //guest
Future signInAnos(BuildContext context) async{
  try {
    AuthResult result=await _auth.signInAnonymously();
    FirebaseUser user=result.user;
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
    return _userFromFirebaseUser(user);
  }catch(e){

  }
}



  // sign up
  Future   registerWithEmailAndPassword(String email,String password,String fullname,String telenumber,String address ,String confirmpassword,BuildContext context) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

      await DatabaseService(uid: user.uid).updateUserData(fullname, email, address, telenumber);
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }



  // sign ip
  Future   signInWithEmailAndPassword(String email,String password,BuildContext context) async{
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(email:email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){

    }


  }


}
