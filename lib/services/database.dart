import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Database {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> createData(BuildContext context,
      {required Map<String, dynamic> data}) async {
    try {
      await users.add(data);
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? 'An error occurred')));
      }
    }
  }

  Future<void> fetchDetailsFromDataBase() async {
    await users.get();
    DocumentSnapshot documentSnapshot =
        await users.doc(auth.currentUser!.uid).get();
  }
}
