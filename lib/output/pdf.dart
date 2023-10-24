import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CV1 extends StatefulWidget {
  const CV1({Key? key}) : super(key: key);

  @override
  _CV1State createState() => _CV1State();
}
class _CV1State extends State<CV1> {
  late String user;
  String? email;
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      email = currentUser.email;
    }
  }
  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    final personalDetailsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('personalDetails')
        .doc(email)
        .get();
    final personalDetails =
    personalDetailsSnapshot.data()! as Map<String, dynamic>;

    final skillDetailsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('skill')
        .doc(email)
        .get();
    final skillDetails =
    skillDetailsSnapshot.data()! as Map<String, dynamic>;

    final experienceSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('experience')
        .get();
    final experienceDocs = experienceSnapshot.docs;

    final educationSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('education')
        .get();
    final educationDocs = educationSnapshot.docs;

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 2,
                child: pw.Container(
                  color: PdfColors.blue,
                  padding: pw.EdgeInsets.all(20),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 60),
                      pw.Text(
                        '${personalDetails['firstName']} ${personalDetails['surName']}',
                        style: pw.TextStyle(
                          fontSize: 25,
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 40),
                      pw.Text(
                        "Contact",
                        style: pw.TextStyle(
                          fontSize: 18,
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      pw.Text(
                        "Address",
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        '${personalDetails['address']}, ${personalDetails['city']}, ${personalDetails['country']}',
                        softWrap: true,
                        style: pw.TextStyle(
                          color: PdfColors.white,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        "Phone",
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        '${personalDetails['phone']}',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        "Email",
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        '${personalDetails['email']}',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                        ),
                      ),
                      pw.SizedBox(height: 40),
                      pw.Text(
                        "Skills",
                        style: pw.TextStyle(
                          fontSize: 18,
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            '1. ${skillDetails['skill1']}',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 16,
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            '2. ${skillDetails['skill2']}',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 16,
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            '3. ${skillDetails['skill3']}',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 16,
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            '4. ${skillDetails['skill4']}',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              pw.Expanded(
                flex: 3,
                child: pw.Container(
                  color: PdfColors.white,
                  padding: pw.EdgeInsets.all(20),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 60),
                      pw.Text(
                        "Work Experience",
                        style: pw.TextStyle(
                          fontSize: 20,
                          color: PdfColors.blue,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          for (var experienceDoc in experienceDocs)
                            pw.Column(
                              crossAxisAlignment:
                              pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  '${experienceDoc['companyName']}',
                                  style: pw.TextStyle(
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.Text(
                                  '${experienceDoc['city']}, ${experienceDoc['country']}',
                                ),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                  '${experienceDoc['jobTitle']}',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.Text(
                                  '${experienceDoc['description']}',
                                ),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                  '${experienceDoc['startDate']} - ${experienceDoc['endDate']}',
                                ),
                                pw.SizedBox(height: 5),
                                pw.Divider(),
                                pw.SizedBox(height: 10),
                              ],
                            ),
                        ],
                      ),
                      pw.SizedBox(height: 20),
                      pw.Text(
                        "Education",
                        style: pw.TextStyle(
                          fontSize: 20,
                          color: PdfColors.blue,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          for (var educationDoc in educationDocs)
                            pw.Column(
                              crossAxisAlignment:
                              pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  '${educationDoc['degree']} in ${educationDoc['fieldOfStudy']}',
                                  style: pw.TextStyle(
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.Text(
                                  '${educationDoc['schoolName']}, ${educationDoc['schoolLocation']}',
                                ),
                                pw.SizedBox(height: 5),
                                pw.Divider(),
                                pw.SizedBox(height: 10),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    // Generate PDF and save to a temporary file
    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/cv.pdf';
    final file = File(tempPath);
    await file.writeAsBytes(await pdf.save());

    // Open the PDF for printing
    await Printing.layoutPdf(
      onLayout: (_) => pdf.save(),
      name: 'cv.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .collection('personalDetails')
            .doc(email)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            final personalDetails =
            snapshot.data!.data()! as Map<String, dynamic>;
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: const Color(0xFF004199),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 60),
                            Text(
                              '${personalDetails['firstName']} ${personalDetails['surName']}',
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 40),
                            const Text(
                              "Contact",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Address",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${personalDetails['address']}, ${personalDetails['city']}, ${personalDetails['country']}',
                              softWrap: true,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Phone",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${personalDetails['phone']}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${personalDetails['email']}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 40),
                            const Text(
                              "Skills",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(email)
                                  .collection('skill')
                                  .doc(email)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data!.exists) {
                                  final skillDetails =
                                  snapshot.data!.data()! as Map<String, dynamic>;
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '• ${skillDetails['skill1']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '• ${skillDetails['skill2']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '• ${skillDetails['skill3']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '• ${skillDetails['skill4']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Text(
                                      'Error occurred while fetching skill details from Firestore.',
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 60),
                            const Text(
                              "Work Experience",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF004199),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(email)
                                  .collection('experience')
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final experienceDocs = snapshot.data!.docs;
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      for (var experienceDoc in experienceDocs)
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${experienceDoc['companyName']}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${experienceDoc['city']}, ${experienceDoc['country']}',
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '${experienceDoc['jobTitle']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${experienceDoc['description']}',
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '${experienceDoc['startDate']} - ${experienceDoc['endDate']}',
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return const Text(
                                    'Error occurred while fetching work experience details from Firestore.',
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Education",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF004199),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(email)
                                  .collection('education')
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final educationDocs = snapshot.data!.docs;
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      for (var educationDoc in educationDocs)
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${educationDoc['degree']} in ${educationDoc['fieldOfStudy']}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${educationDoc['schoolName']}, ${educationDoc['schoolLocation']}',
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return const Text(
                                    'Error occurred while fetching education details from Firestore.',
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error occurred while fetching personal details from Firestore.',
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generatePdf,
        child: Icon(Icons.download),
      ),
    );
  }
}