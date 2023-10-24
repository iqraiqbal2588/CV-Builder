import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/loginclass.dart';
import 'package:fyp/profile.dart';
import 'package:fyp/setting.dart';

import 'dynamiclink.dart';
import 'feedback.dart';
import 'help.dart';
import 'job_dashboard.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _userDataFuture;

  void initState() {
    super.initState();
    initDynamicLink();
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
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 300,
            width: 220,
            padding: EdgeInsets.only(top: 50.0),
            child: Column(children: [
              CircleAvatar(
                radius: 70.0,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQcS0iWBuF2rdelLw50qY_Ekqy8tGNmgGvqBND-UM7sQNYmNJUS'),
              ),
              SizedBox(height: 10.0),
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
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            data?['username'] ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            data?['useremailname'] ?? '',
                            style: TextStyle(
                              color: Color(0xFF0D47A1),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ]),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              size: 34,
              color: Color(0xFF0D47A1),
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFF0D47A1),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => profile()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.edit,
              size: 34,
              color: Color(0xFF0D47A1),
            ),
            title: Text(
              'Update Profile',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFF0D47A1),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingPage()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              size: 34,
              color: Color(0xFF0D47A1),
            ),
            title: Text(
              'Help and Support',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFF0D47A1),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => help()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              size: 34,
              color: Color(0xFF0D47A1),
            ),
            title: Text(
              'Help',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFF0D47A1),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => help()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.feedback,
              size: 34,
              color: Color(0xFF0D47A1),
            ),
            title: Text(
              'Feedback',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFF0D47A1),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeedbackPage()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              size: 34,
              color: Color(0xFF0D47A1),
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFF0D47A1),
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MyLogin()));
            },
          ),
        ],
      ),
    );
  }
}
