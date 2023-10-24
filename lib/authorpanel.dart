import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/showjobs.dart';
import 'package:fyp/totalapplication.dart';

import 'authordrawer.dart';
import 'authorjobform.dart';

class Authorpanel extends StatefulWidget {
  const Authorpanel({Key? key}) : super(key: key);

  @override
  State<Authorpanel> createState() => _AuthorpanelState();
}

class _AuthorpanelState extends State<Authorpanel> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _userDataFuture;
  late Future<DocumentSnapshot<Map<String, dynamic>>>? _uDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = loadData();
    _uDataFuture = loadDatato();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> loadData() async {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user!.email;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('Author')
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

    throw Exception('Author data not found');
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

  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: authordrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        centerTitle: true,
        title: Text('Author Section'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 5.0),
          Container(
            height: 250,
            width: 400,
            child: Image.network(
                "https://wp.penguin.co.uk/wp-content/uploads/2020/11/how-does-an-author-earn-a-living.png"),
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
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Author Name:",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Author email:",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: screenWidth * 0.04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data?['username'] ?? '',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              data?['useremailname'] ?? '',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: _uDataFuture,
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
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Author Company:",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: screenWidth * 0.04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data?['companyName'] ?? '',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          GridView.count(
            crossAxisCount: screenWidth > 600 ? 3 : 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            shrinkWrap: true,
            children: <Widget>[
              DashboardCard(
                title: 'Add Jobs',
                icon: Icons.people,
                backgroundColor: Color(0xFF0D47A1),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddJobForm(),
                    ),
                  );
                },
              ),
              DashboardCard(
                title: 'View Jobs',
                icon: Icons.edit,
                backgroundColor: Colors.cyan,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowJobs(),
                    ),
                  );
                },
              ),
              DashboardCard(
                title: 'Total Applications',
                icon: Icons.person,
                backgroundColor: Colors.redAccent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FileListScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: const Divider(
              height: 20,
              thickness: 2,
              indent: 20,
              endIndent: 0,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Row(
              children: [
                Text(
                  'Manage Company Details',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Row(
              children: [
                Container(
                  width: screenWidth,
                  color: Colors.lightBlue,
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'For Job Listing, You Have to Add Company Details',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action for the first button
                  },
                  child: Text('Edit Company'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action for the second button
                  },
                  child: Text('Delete Company'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class JobScreen {}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  DashboardCard({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: screenWidth > 600 ? 70 : 50,
              color: Colors.white,
            ),
            SizedBox(height: 20.0),
            Text(
              title,
              style: TextStyle(
                fontSize: screenWidth > 600 ? 24 : 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class post extends StatefulWidget {
  const post({Key? key}) : super(key: key);

  @override
  State<post> createState() => _postState();
}

class _postState extends State<post> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              Text(
                "Tell us Who you're Hiring",
                style: TextStyle(
                    fontSize: screenWidth > 600 ? 30 : 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),
            ],
          ),
          Container(
            child: ListTile(
              leading: Icon(Icons.laptop_chromebook_sharp,
                  size: screenWidth > 600 ? 50 : 40, color: Colors.black),
              title: Text(
                "Job title*",
                style: TextStyle(
                    fontSize: screenWidth > 600 ? 24 : 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),
              trailing: PopupMenuButton(
                  color: Colors.white,
                  elevation: 4,
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  icon: Icon(
                    Icons.add_circle_outline_outlined,
                    size: screenWidth > 600 ? 40 : 30,
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              showMyDialog();
                            },
                            leading: Icon(Icons.add),
                            title: Text('Add'),
                          ),
                        ),
                      ]),
              subtitle: Text(
                "Add job title",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: screenWidth > 600 ? 20 : 18,
                ),
              ),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 2,
            indent: 20,
            endIndent: 0,
            color: Colors.grey,
          ),
          Container(
            child: ListTile(
              leading: Icon(Icons.comment_bank,
                  size: screenWidth > 600 ? 50 : 40, color: Colors.black),
              title: Text(
                "Company*",
                style: TextStyle(
                    fontSize: screenWidth > 600 ? 24 : 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),
              trailing: PopupMenuButton(
                  color: Colors.white,
                  elevation: 4,
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  icon: Icon(
                    Icons.add_circle_outline_outlined,
                    size: screenWidth > 600 ? 40 : 30,
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              showMyDialog();
                            },
                            leading: Icon(Icons.add),
                            title: Text('Add'),
                          ),
                        ),
                      ]),
              subtitle: Text(
                "Add company",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: screenWidth > 600 ? 20 : 18,
                ),
              ),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 2,
            indent: 20,
            endIndent: 0,
            color: Colors.grey,
          ),
          Container(
            child: ListTile(
              leading: Icon(Icons.location_on,
                  size: screenWidth > 600 ? 50 : 40, color: Colors.black),
              title: Text(
                "Job location*",
                style: TextStyle(
                    fontSize: screenWidth > 600 ? 24 : 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),
              trailing: PopupMenuButton(
                  color: Colors.white,
                  elevation: 4,
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  icon: Icon(
                    Icons.add_circle_outline_outlined,
                    size: screenWidth > 600 ? 40 : 30,
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              showMyDialog();
                            },
                            leading: Icon(Icons.add),
                            title: Text('Add'),
                          ),
                        ),
                      ]),
              subtitle: Text(
                "Lahore, Punjab, Pakistan",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: screenWidth > 600 ? 20 : 18,
                ),
              ),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 2,
            indent: 20,
            endIndent: 0,
            color: Colors.grey,
          ),
          Container(
            child: ListTile(
              leading: Icon(Icons.description,
                  size: screenWidth > 600 ? 50 : 40, color: Colors.black),
              title: Text(
                "Job description*",
                style: TextStyle(
                    fontSize: screenWidth > 600 ? 24 : 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),
              trailing: PopupMenuButton(
                  color: Colors.white,
                  elevation: 4,
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  icon: Icon(
                    Icons.add_circle_outline_outlined,
                    size: screenWidth > 600 ? 40 : 30,
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              showMyDialog();
                            },
                            leading: Icon(Icons.add),
                            title: Text('Add'),
                          ),
                        ),
                      ]),
              subtitle: Text(
                "Full-time",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: screenWidth > 600 ? 20 : 18,
                ),
              ),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 2,
            indent: 20,
            endIndent: 0,
            color: Colors.grey,
          ),
          Container(
            child: ListTile(
              leading: Icon(Icons.add_card_sharp,
                  size: screenWidth > 600 ? 50 : 40, color: Colors.black),
              title: Text(
                "Monthly Salary*",
                style: TextStyle(
                    fontSize: screenWidth > 600 ? 24 : 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),
              trailing: PopupMenuButton(
                  color: Colors.white,
                  elevation: 4,
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: screenWidth > 600 ? 40 : 30,
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              showMyDialog();
                            },
                            leading: Icon(Icons.add),
                            title: Text('Add'),
                          ),
                        ),
                      ]),
              subtitle: Text(
                "Rs 50,000 - Rs 70,000",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: screenWidth > 600 ? 20 : 18,
                ),
              ),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 2,
            indent: 20,
            endIndent: 0,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: ListTile(
              leading: Icon(Icons.email,
                  size: screenWidth > 600 ? 50 : 40, color: Colors.black),
              title: Text(
                "gmail*",
                style: TextStyle(
                    fontSize: screenWidth > 600 ? 24 : 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),
              trailing: PopupMenuButton(
                  color: Colors.white,
                  elevation: 4,
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  icon: Icon(
                    Icons.add_circle_outline_outlined,
                    size: screenWidth > 600 ? 40 : 30,
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              showMyDialog();
                            },
                            leading: Icon(Icons.add),
                            title: Text('Add'),
                          ),
                        ),
                      ]),
              subtitle: Text(
                "iqraiqbalcs@gmail.com",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: screenWidth > 600 ? 20 : 18,
                ),
              ),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 2,
            indent: 20,
            endIndent: 0,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: ListTile(
              leading: Icon(Icons.contact_phone_outlined,
                  size: screenWidth > 600 ? 50 : 40, color: Colors.black),
              title: Text(
                "Phone*",
                style: TextStyle(
                    fontSize: screenWidth > 600 ? 24 : 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),
              trailing: PopupMenuButton(
                  color: Colors.white,
                  elevation: 4,
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  icon: Icon(
                    Icons.add_circle_outline_outlined,
                    size: screenWidth > 600 ? 40 : 30,
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              showMyDialog();
                            },
                            leading: Icon(Icons.add),
                            title: Text('Add'),
                          ),
                        ),
                      ]),
              subtitle: Text(
                "+92 3164136893",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: screenWidth > 600 ? 20 : 18,
                ),
              ),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 2,
            indent: 20,
            endIndent: 0,
            color: Colors.grey,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> showMyDialog() {
    final double screenWidth = MediaQuery.of(context).size.width;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit"),
          content: Container(
            child: TextField(
              decoration: InputDecoration(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Update"),
            )
          ],
        );
      },
    );
  }
}
