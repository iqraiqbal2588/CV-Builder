import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class manageAuthor extends StatefulWidget {
  @override
  _manageAuthorState createState() => _manageAuthorState();
}

class _manageAuthorState extends State<manageAuthor> {
  late Future<QuerySnapshot<Map<String, dynamic>>> _jobFeaturesFuture;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _jobFeaturesFuture = getJobFeatures();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getJobFeatures() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('Author').get();

    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xFF0D47A1),
        centerTitle: true,
        title: Text('Author',
            style: TextStyle(fontSize: 25.0, color: Colors.white)),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: _jobFeaturesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No Author found.'),
            );
          }

          final userDocs = snapshot.data!.docs;

          return ListView.separated(
            itemCount: userDocs.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final jobData = userDocs[index].data();

              final title = jobData['username'] as String? ?? '';
              final mail = jobData['useremailname'] as String? ?? '';
              final pass = jobData['userpassword'] as String? ?? '';

              return Column(
                children: [
                  Padding(padding: EdgeInsets.all(10.0)),
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    tileColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue,
                      child: Text(
                        '${title[0]}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      'Name: ${title}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      'Email: ${mail}',
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Delete'),
                              content: Text(
                                  'Are you sure you want to delete user data?'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Confirm Delete'),
                                          content: Text(
                                              'Are you sure you want to delete user data?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                try {
                                                  // Delete user data
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Author')
                                                      .doc(mail)
                                                      .delete();
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("jobFeatures")
                                                      .doc(mail)
                                                      .delete();
                                                  print(
                                                      'Document deleted successfully');
                                                  setState(() async {
                                                    QuerySnapshot snapshot =
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Author')
                                                            .where(mail,
                                                                isEqualTo:
                                                                    mail)
                                                            .get();

                                                    for (QueryDocumentSnapshot doc
                                                        in snapshot.docs) {
                                                      await doc.reference
                                                          .delete();
                                                    }

                                                    // Step 2: Delete user from Authentication
                                                    UserCredential
                                                        userCredential =
                                                        await FirebaseAuth.instance
                                                            .signInWithEmailAndPassword(
                                                                email: mail,
                                                                password:
                                                                    pass);
                                                    User? user =
                                                        userCredential.user;

                                                    await user?.delete();
                                                  });
                                                } catch (e) {
                                                  print(
                                                      'Error deleting document: $e');
                                                }

                                                Navigator.of(context)
                                                    .pop(); // Close the alert dialog
                                              },
                                              child: Text('Yes'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the alert dialog
                                              },
                                              child: Text('No'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the alert dialog
                                  },
                                  child: Text('No'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    onTap: () {
                      // View the file or perform other actions
                      // You can define your own logic here
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
