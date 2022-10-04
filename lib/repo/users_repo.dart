import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:myblog/loginscreen.dart';
import 'package:myblog/models/UserModel.dart';

class UserRepo{
  Future<UserModel>getUser(String id) async{
    var userDocument 
    = await FirebaseFirestore.instance.collection("bloguser").doc(id).get();
  UserModel  userModel = UserModel.fromDocument(userDocument);
    return userModel;
  }

  String checkUser(BuildContext context){
    var id = FirebaseAuth.instance.currentUser!.uid;
    if(id != null){
      return id;
    } else {
      var route = MaterialPageRoute(builder: (BuildContext) => loginScreen());
      Navigator.push(context, route);

      return "no user";
    }
  }
}