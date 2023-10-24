import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class registeredCompany extends StatefulWidget {
  @override
  _registeredCompanyState createState() => _registeredCompanyState();
}

class _registeredCompanyState extends State<registeredCompany> {
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
        title: Text('Registered Company',
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
              child: Text('No Registered Company Found.'),
            );
          }

          final jobDocs = snapshot.data!.docs;

          return ListView.separated(
            itemCount: jobDocs.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final jobData = jobDocs[index].data();

              final companyName =
                  jobData['companyName'] as String? ?? 'No Company Name';
              final gmail = jobData['gmail'] as String? ?? 'No Company Name';
              final phone = jobData['phone'] as String? ?? 'No Company Name';

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
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            width: 350,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${companyName}',
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${gmail}',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${phone}',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    size: 40,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    // Handle button press here
                                  },
                                ),
                              ],
                            ),
                          ),
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
                    )
                  ]);
            },
          );
        },
      ),
    );
  }
}
