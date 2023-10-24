import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/drawer.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  late Future<DocumentSnapshot<Map<String, dynamic>>> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = loadData();
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> loadData() async {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user!.email;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('useremailname', isEqualTo: userEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Iterate through the documents and find the matching user
      for (var doc in querySnapshot.docs) {
        if (doc.data()['useremailname'] == userEmail) {
          return doc;
        }
      }
    }

    throw Exception('User data not found');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => CustomDrawer()));
          },
        ),
      ),
      body: Column(children: [
        Container(
          height: 300,
          width: 220,
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 80.0,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQcS0iWBuF2rdelLw50qY_Ekqy8tGNmgGvqBND-UM7sQNYmNJUS'),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: _userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            final data = snapshot.data!.data();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      subtitle: Text(
                        data?['username'] ?? '',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        size: 40,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Gmail',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      subtitle: Text(
                        data?['useremailname'] ?? '',
                        style: TextStyle(
                          color: Color(0xFF0D47A1),
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ]),
    );
  }
}
