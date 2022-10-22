import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vestire_app/res/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up the user
  Future<String> signUpUser({
    required String name,
    required String email,
    required String phoneNumber,
    required String workingType,
    required String password,
    required String salary,
    required String address,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          phoneNumber.isNotEmpty ||
          workingType.isNotEmpty ||
          salary.isNotEmpty ||
          address.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilePics', file);
        // add user to database
        await _firestore.collection('employees').doc(cred.user!.uid).set({
          'empName': name,
          'uid': cred.user!.uid,
          'email': email,
          'phoneNumber': phoneNumber,
          'workType': workingType,
          'photoUrl': photoUrl,
          'bills': [],
          'salary': salary,
          'dateOfJoining': DateTime.now().toString(),
          'address': address,
        });
        res = "success";
      }
    }
    // on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid-email') {
    //     res = 'The email is badly formatted';
    //   }else if(err.code == 'weak-password'){

    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  //Logging in user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
