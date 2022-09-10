import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/models/user.dart' as model;
import 'package:instaclone/resources/storage_methods.dart';

class AuthMethods {
  //create instance of firebase to use firebase funtoions🔥
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('Users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //First function is for SignUp the user🔥

  //We use Future of String type becoz it will gives us a string that wheather Signup successfull or some error comes
  Future<String> signUpUser({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some Error occured !!";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty) {
        // Now here we will register the User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await storageMethods()
            .uploadimageToStorage('Profilepics', file, false);

        //creating user of model
        model.User user = model.User(
          userName: userName,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          following: [],
          followers: [],
        );

        //Save user data into Firestore database
        await _firestore
            .collection('Users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "success";
      }
    } catch (e) {
      res = e.toString();
      print(res);
    }

    return res;
  }

  // Creating authmethod for login user

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurs";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
