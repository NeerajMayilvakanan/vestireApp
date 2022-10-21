import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    // required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          phoneNumber.isNotEmpty ||
          workingType.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // add user to database
        _firestore.collection('users').doc(cred.user!.uid).set({
          'empName': name,
          'uid': cred.user!.uid,
          'email': email,
          'phoneNumber': phoneNumber,
          'workType': workingType
        });
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
