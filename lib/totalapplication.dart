import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FileListScreen extends StatelessWidget {
  final String? uemail = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('file').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                String name = document['name'];
                String email = document['email'];
                String contact = document['contact'];
                String fileUrl = document['fileUrl'];
                String authorEmail = document['authoremail'];

                return ListTile(
                  title: Text(name),
                  subtitle: Column(
                    children: [
                      Text(email),
                      Text(contact),
                      Text(fileUrl),
                    ],
                  ),
                  onTap: () {
                    // Handle file open logic here
                    openFile(fileUrl);
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  void openFile(String fileUrl) async {
    if (await canLaunch(fileUrl)) {
      await launch(fileUrl);
    } else {
      throw 'Could not launch $fileUrl';
    }
  }
}
