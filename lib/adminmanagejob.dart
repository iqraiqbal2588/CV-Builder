import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class adminmanagejob extends StatefulWidget {
  @override
  _adminmanagejobState createState() => _adminmanagejobState();
}

class _adminmanagejobState extends State<adminmanagejob> {
  late Future<QuerySnapshot<Map<String, dynamic>>> _jobFeaturesFuture;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _jobFeaturesFuture = getJobFeatures();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getJobFeatures() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('jobFeatures').get();

    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xFF0D47A1),
        centerTitle: true,
        title: Text('Manage Jobs Screen',
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
              child: Text('No Job found.'),
            );
          }

          final jobDocs = snapshot.data!.docs;

          return ListView.separated(
            itemCount: jobDocs.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final jobData = jobDocs[index].data();

              final title = jobData['jobTitle'] as String? ?? 'No Title';
              final companyName =
                  jobData['companyName'] as String? ?? 'No Company Name';
              final place = jobData['place'] as String? ?? 'No place';
              final description =
                  jobData['description'] as String? ?? 'No place';
              final salary = jobData['salary'] as String? ?? 'No place';
              final gmail = jobData['gmail'] as String? ?? 'No place';
              final phone = jobData['phone'] as String? ?? 'No phone';

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 02,
                      ),
                      Text(
                        '${title}',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 35,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(10.0)),
                      Icon(
                        Icons.home_work,
                        size: 30,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '${companyName}',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(10.0)),
                      Icon(Icons.location_on, size: 30),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '${place}',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(10.0)),
                      Icon(Icons.work, size: 30),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        height: 30,
                        width: 150,
                        color: Colors.white60,
                        child: Text(
                          '${description}',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(10.0)),
                      Icon(Icons.add_card, size: 30),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        height: 30,
                        width: 300,
                        color: Colors.white70,
                        child: Text(
                          '${salary}',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(10.0)),
                      Icon(Icons.email, size: 30),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '${gmail}',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(10.0)),
                      Icon(Icons.contacts_rounded, size: 30),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '${phone}',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 20,
                    endIndent: 0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
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
