import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_customer/data%20models/location.dart';

import 'package:hive_customer/data%20models/user.dart';
import 'package:hive_customer/screens/appPages.dart';
import 'package:hive_customer/screens/home.dart';
import 'package:hive_customer/screens/register.dart';
import 'package:hive_customer/statemanagement/businessInfo/businessInfoController.dart';

import 'package:hive_customer/statemanagement/statusInfo/statusInfoController.dart';
import 'package:hive_customer/statemanagement/user/userController.dart';

class FirebaseManager {
  final UserStateController _userStateController =
      Get.put(UserStateController());
  final BusinessInfoController businessInfoController =
      Get.put(BusinessInfoController());
  final StatusInfoController _statusInfoController =
      Get.put(StatusInfoController());

  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  Future<void> logAction(String action, String user) async {
    await FirebaseFirestore.instance.collection("logs").add({
      "action": action,
      "user": user,
      "datePerformed": Timestamp.now(),
    });
  }

  Future<String> registerUser(
      Customer user, String? password, File? image) async {
    log(user.email.toString());
    log(user.firstName.toString());
    log(user.lastName.toString());
    log(user.phone.toString());
    log(user.email.toString());
    log(password.toString());
    if (EmailValidator.validate(user.email!)) {
      if (password != null) {
        try {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: user.email!,
            password: password!,
          );
          await credential.user!.sendEmailVerification();
          String imageURL = image != null
              ? await uploadImage(image, credential.user!.uid)
              : '';
          final customerRef =
              db.collection('customer').doc(credential.user!.uid);
          customerRef.set({
            "firstName": user.firstName,
            "lastName": user.lastName,
            "phone": user.phone,
            "email": user.email,
            "image": imageURL,
          });
          logAction("User created", credential.user!.uid);
          return 'success';
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            return (e.code);
          } else if (e.code == 'email-already-in-use') {
            return (e.code);
          }
        } catch (e) {
          return (e.toString());
        }
      }
      return 'Enter a password';
    }

    return 'Enter a proper email';
  }

  Future<void> getStatus(String uid) async {
    final statusRef = db.collection('businessStatus').doc(uid);
    statusRef.snapshots().listen((event) {
      if (event.data() != null) {
        _statusInfoController.setStatus(status: event.data()!['status']);
      }
    });
  }

  Future<String> updateLocation(String uid, UserLocation location) async {
    final businessRef = db.collection('business').doc(uid);
    final data = {
      "address": location.address,
      "lat": location.lat,
      "lng": location.lng
    };
    businessRef
        .update(data)
        .onError((e, stackTrace) => {log(("Error writing document: $e"))});
    logAction("Updated Location", _userStateController.user.uid.value);
    return 'Success';
  }

  Future<String> uploadImage(File image, String userUID) async {
    final Reference storageRef =
        storage.ref().child('images/${userUID}/profile');
    final TaskSnapshot taskSnapshot = await storageRef.putFile(image);
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<String> login(String? email, String? password) async {
    log(password.toString());
    log(email.toString());
    log('${password != null}');
    if (EmailValidator.validate(email!)) {
      if (password != null) {
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);

          if (credential.user!.emailVerified) {
            _userStateController.setUserData(
                credential.user!.email!, credential.user!.uid);
            logAction("Logged in", _userStateController.user.uid.value);
            return 'success';
          } else {
            log(credential.user!.emailVerified.toString());
            await credential.user!.sendEmailVerification();
            return 'Email not yet verfied please check your email';
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            return ('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            return ('Wrong password provided for that user.');
          }
          return e.code.toString();
        }
      }
    }

    return 'Enter a proper email';
  }
}
