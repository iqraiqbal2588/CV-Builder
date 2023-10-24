import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class authorviewjobs extends StatefulWidget {
  const authorviewjobs({Key? key}) : super(key: key);

  @override
  State<authorviewjobs> createState() => _authorviewjobsState();
}

class _authorviewjobsState extends State<authorviewjobs> {
  @override
  late Future<DocumentSnapshot<Map<String, dynamic>>> _userDataFuture;
  late Future<DocumentSnapshot<Map<String, dynamic>>>? _uDataFuture;

  @override
  void initState() {
    super.initState();
    _uDataFuture = loadDatato();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> loadDatato() async {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user!.email;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('jobFeatures')
        .where('gmail', isEqualTo: userEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Iterate through the documents and find the matching user
      for (var doc in querySnapshot.docs) {
        if (doc.data()['gmail'] == userEmail) {
          return doc;
        }
      }
    }
    throw Exception('User data not found');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
