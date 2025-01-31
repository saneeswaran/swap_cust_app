import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swap_cust_app/model/database_details_model.dart';

class Database {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> createData(BuildContext context,
      {required String userName,
      required String userEmail,
      required String userImage,
      required int totalCreditRedeemed,
      required int creditBalance}) async {
    try {
      await users.doc(auth.currentUser!.uid).set(DatabaseDetailsModel(
              userName: userName,
              userEmail: userEmail,
              userImage: userImage,
              totalCreditRedeemed: totalCreditRedeemed,
              creditBalance: creditBalance)
          .toMap());
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? 'An error occurred')));
      }
    }
  }
}
