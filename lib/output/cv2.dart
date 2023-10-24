import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class searchjobs extends StatefulWidget {
  const searchjobs({Key? key}) : super(key: key);

  @override
  State<searchjobs> createState() => _searchjobsState();
}

class _searchjobsState extends State<searchjobs> {
  late String uid;
  String? email;

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
    final skillDetails = skillDetailsSnapshot.data()! as Map<String, dynamic>;

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
          return pw.ListView(
            children: [
              pw.Row(
                children: [
                  pw.Container(
                    width: 410,
                    height: 100,
                    color: PdfColors.white,
                    child: pw.Row(
                      children: [
                        pw.Text(
                          '${personalDetails['firstName']} ${personalDetails['surName']}',
                          style: pw.TextStyle(
                            fontSize: 35,
                            color: PdfColors.blue,
                            fontWeight: pw.FontWeight.bold,
                            font: pw.Font.times(),
                          ),
                        ),
                        pw.SizedBox(width: 120.0),
                      ],
                    ),
                  ),
                ],
              ),
              pw.Container(
                color: PdfColors.white,
                child: pw.Expanded(
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 10),
                      pw.Text(
                        '${personalDetails['summary']}',
                        style: const pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      pw.SizedBox(height: 30),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            flex: 2,
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Row(
                                  children: [
                                    // pw.Icon(
                                    //   Icons.account_circle as pw.IconData,
                                    //   size: 40,
                                    //   color: PdfColors.blueGrey,
                                    // ),
                                    pw.Text(
                                      "Contact",
                                      style: pw.TextStyle(
                                        fontSize: 20,
                                        font: pw.Font.times(),
                                        color: PdfColors.blue,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 10),
                                pw.Text(
                                  "Address",
                                  style: pw.TextStyle(
                                    color: PdfColors.black,
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.Text(
                                  '${personalDetails['address']},${personalDetails['city']},${personalDetails['country']}',
                                  style: const pw.TextStyle(
                                    color: PdfColors.black,
                                  ),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                  "Phone",
                                  style: pw.TextStyle(
                                    color: PdfColors.black,
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.Text(
                                  '${personalDetails['phone']}',
                                  style: const pw.TextStyle(
                                    color: PdfColors.black,
                                  ),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                  "Email",
                                  style: pw.TextStyle(
                                    color: PdfColors.black,
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.Text(
                                  '${personalDetails['email']}',
                                  style: const pw.TextStyle(
                                    color: PdfColors.black,
                                  ),
                                ),
                                pw.SizedBox(height: 40),
                                pw.Row(
                                  children: [
                                    // pw.Icon(
                                    //   Icons.accessibility_outlined
                                    //       as pw.IconData,
                                    //   size: 40,
                                    //   color: PdfColors.blueGrey,
                                    // ),
                                    pw.Text(
                                      "Skills",
                                      style: pw.TextStyle(
                                        fontSize: 20,
                                        font: pw.Font.times(),
                                        color: PdfColors.blue,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 10),
                                pw.Text("1. ${skillDetails['skill1']}"),
                                pw.Text("2. ${skillDetails['skill2']}"),
                                pw.Text("3. ${skillDetails['skill3']}"),
                                pw.Text("4. ${skillDetails['skill4']}"),
                              ],
                            ),
                          ),
                          pw.Expanded(
                            flex: 3,
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                pw.Row(
                                  children: [
                                    // pw.Icon(
                                    //   Icons.shopping_bag_outlined
                                    //       as pw.IconData,
                                    //   size: 40,
                                    //   color: PdfColors.blueGrey,
                                    // ),
                                    pw.Text(
                                      "Work Experience",
                                      style: pw.TextStyle(
                                        fontSize: 20,
                                        font: pw.Font.times(),
                                        color: PdfColors.blue,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(height: 10),
                                for (var experience in experienceDocs)
                                  pw.Row(
                                    mainAxisAlignment:
                                    pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Column(
                                        children: [
                                          pw.Text(
                                              "${experience['startDate']}-"),
                                          pw.Text("${experience['endDate']}")
                                        ],
                                      ),
                                      pw.SizedBox(width: 10),
                                      pw.Column(
                                        crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                            "${experience['companyName']}",
                                            style: pw.TextStyle(
                                              color: PdfColors.black,
                                              fontSize: 16,
                                              fontWeight: pw.FontWeight.bold,
                                            ),
                                          ),
                                          pw.Text(
                                              "${experience['city']},${experience['country']}"),
                                          pw.Text(
                                              "${experience['description']} "),
                                          pw.Divider(),
                                        ],
                                      ),
                                    ],
                                  ),
                                pw.SizedBox(height: 16),
                                pw.Row(
                                  children: [
                                    // pw.Icon(
                                    //   Icons.laptop_chromebook_sharp
                                    //       as pw.IconData,
                                    //   size: 40,
                                    //   color: PdfColors.blueGrey,
                                    // ),
                                    pw.Text(
                                      "Education",
                                      style: pw.TextStyle(
                                        fontSize: 20,
                                        font: pw.Font.times(),
                                        color: PdfColors.blue,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                for (var eduDoc in educationDocs)
                                  pw.Column(
                                    mainAxisAlignment:
                                    pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.SizedBox(height: 15),
                                      pw.Text(
                                        "${eduDoc['degree']} in ${eduDoc['fieldOfStudy']}",
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 17,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      pw.Text(
                                          "${eduDoc['schoolName']}-${eduDoc['schoolLocation']}"),
                                    ],
                                  )
                              ],
                            ),
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
    uid = FirebaseAuth.instance.currentUser!.uid;
    email = FirebaseAuth.instance.currentUser!.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV(Preview)'),
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
            final pd = snapshot.data!.data()! as Map<String, dynamic>;
            return FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(email)
                  .collection('experience')
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.hasData) {
                  final exp = snapshot.data!.docs;
                  return FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(email)
                        .collection('education')
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.hasData) {
                        final edu = snapshot.data!.docs;
                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('users')
                              .doc(email)
                              .collection('skill')
                              .doc(email)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data!.exists) {
                              final sk = snapshot.data!.data()!
                              as Map<String, dynamic>;
                              return ListView(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 410,
                                        height: 100,
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Text(
                                              '${pd['firstName']} ${pd['surName']}',
                                              style: const TextStyle(
                                                  fontSize: 35,
                                                  color: Color(0xFF004199),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                  "Times New Roman"),
                                            ),
                                            const SizedBox(width: 120.0),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${pd['summary']}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Icon(
                                                          Icons.account_circle,
                                                          size: 40,
                                                          color: Color(0xFF004199),
                                                        ),
                                                        Text(
                                                          "Contact",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontFamily:
                                                              'Times New Roman',
                                                              color: Color(0xFF004199),
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      "Address",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '${pd['address']},${pd['city']},${pd['country']}',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5,),
                                                    const Text(
                                                      "Phone",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '${pd['phone']}',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5,),
                                                    const Text(
                                                      "Email",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '${pd['email']}',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 40,
                                                    ),
                                                    const Row(
                                                      children: [
                                                        Icon(
                                                          Icons.accessibility_outlined,
                                                          size: 40,
                                                          color: Color(0xFF004199),
                                                        ),
                                                        Text(
                                                          "Skills",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontFamily:
                                                              'Times New Roman',
                                                              color: Color(0xFF004199),
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("● ${sk['skill1']}"),
                                                    Text("● ${sk['skill2']}"),
                                                    Text("● ${sk['skill3']}"),
                                                    Text("● ${sk['skill4']}"),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Icon(
                                                          Icons.shopping_bag_outlined,
                                                          size: 40,
                                                          color: Color(0xFF004199),
                                                        ),
                                                        Text(
                                                          "Work Experience",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontFamily:
                                                              'Times New Roman',
                                                              color: Color(0xFF004199),
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    for (var experience
                                                    in exp)
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(children: [
                                                          Text("${experience['startDate']}-"),
                                                          Text("${experience['endDate']}")
                                                        ]),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "${experience['companyName']}",
                                                              style: const TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                            ),
                                                            Text("${experience['city']},${experience['country']}"),
                                                            Text(
                                                                "●${experience['description']} "),
                                                            const Divider(),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                    const Row(
                                                      children: [
                                                        Icon(
                                                          Icons.laptop_chromebook_sharp,
                                                          size: 40,
                                                          color: Color(0xFF004199),
                                                        ),
                                                        Text(
                                                          "Education",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontFamily:
                                                              'Times New Roman',
                                                              color: Color(0xFF004199),
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                    for (var eduDoc
                                                    in edu)
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                          "${eduDoc['degree']} in ${eduDoc['fieldOfStudy']}",
                                                          style: const TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 17,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                        Text(
                                                            "${eduDoc['schoolName']}-${eduDoc['schoolLocation']}"),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                    'Error occurred while fetching education details from Firestore.'),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                              'Error occurred while fetching education details from Firestore.'),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                        'Error occurred while fetching education details from Firestore.'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                  'Error occurred while fetching personal details from Firestore.'),
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
        child: const Icon(Icons.download),
      ),
    );
  }
}
