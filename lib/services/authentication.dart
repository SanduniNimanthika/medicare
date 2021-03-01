

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicare/loginSignup/welcome.dart';
import 'package:medicare/mainpages/homepage.dart';
import 'package:medicare/module/user.dart';
import 'package:medicare/services/database.dart';
import 'package:medicare/userdetails/home.dart';





class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;


  //user object based on firebased
  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null?User(
        userkey:user.uid,
       email:user.email): null;
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
  Future   registerWithEmailAndPassword(String email,String password,String fullname,String telenumber,String address,String hometown ,String confirmpassword,BuildContext context) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHome()));

      await DatabaseService(uid: user.uid).updateUserData(fullname, email,  telenumber,address,hometown);
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }



  // sign in
  Future   signInWithEmailAndPassword(String email,String password,BuildContext context) async{
    try{

      AuthResult result=await _auth.signInWithEmailAndPassword(email:email, password: password);
    //  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => UserHome()),
      //    ModalRoute.withName('/')
    //  );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHome()));
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){

    }


  }


  //sign out
  Future signOut(BuildContext context) async{
    try{
     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>Welcome()));

      return await _auth.signOut();

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future deleteUser() async {
    try {
      FirebaseUser user = await _auth.currentUser();

       // called from database class
      await user.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}


