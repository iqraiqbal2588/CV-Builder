import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

class CLScreen extends StatefulWidget {
  const CLScreen({Key? key}) : super(key: key);

  @override
  _CLScreenState createState() => _CLScreenState();
}

class _CLScreenState extends State<CLScreen> {
  String? user = FirebaseAuth.instance.currentUser!.email;

  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    final personalDetailsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('personalDetails')
        .doc(user)
        .get();
    final nameAndContactDeatils =
    personalDetailsSnapshot.data()! as Map<String, dynamic>;

    final skillDetailsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('recipientDetails')
        .doc(user)
        .get();
    final recipientDetails =
    skillDetailsSnapshot.data()! as Map<String, dynamic>;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Row(
            children: [
              pw.Expanded(
                flex: 2,
                child: pw.Container(
                  color: PdfColors.blueAccent,
                  padding: const pw.EdgeInsets.all(20),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 30),
                      pw.Text(
                        '${nameAndContactDeatils['firstName']} ${nameAndContactDeatils['surName']}',
                        style: pw.TextStyle(
                          fontSize: 25,
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 40),
                      pw.Text(
                        "Personal",
                        style: pw.TextStyle(
                          fontSize: 20,
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        "Phone",
                        style: pw.TextStyle(
                          fontSize: 14,
                          color: PdfColors.white,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        '${nameAndContactDeatils['phone']}',
                        style: pw.TextStyle(
                          fontSize: 14,
                          color: PdfColors.white,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        "Email",
                        style: pw.TextStyle(
                          fontSize: 14,
                          color: PdfColors.white,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        '${nameAndContactDeatils['email']}',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.Padding(padding: pw.EdgeInsets.all(2.0)),
              pw.Expanded(
                flex: 4,
                child: pw.Container(
                  color: PdfColors.white,
                  padding: const pw.EdgeInsets.all(20),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 30),
                      pw.Text(
                        '${recipientDetails['city']},${nameAndContactDeatils['postalCode']}',
                        style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      pw.Text(
                        'Mr. ${recipientDetails['firstName']} ${recipientDetails['surName']}',
                        style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text('${recipientDetails['recipientPosition']} of Software House'),
                      pw.SizedBox(height: 10),
                      pw.Text('${recipientDetails['companyName']}'),
                      pw.SizedBox(height: 10),
                      pw.Text('${recipientDetails['city']}, ${recipientDetails['country']}'),
                      pw.SizedBox(height: 10),
                      pw.Text('Dear ${recipientDetails['firstName']},'),
                      pw.SizedBox(height: 20),
                      pw.Text(
                        "Highly-skilled and motivated senior ${nameAndContactDeatils['profession']} with ${nameAndContactDeatils['exp']} years of experience. Enhanced performance of 24 applications using ${nameAndContactDeatils['skill1']},${nameAndContactDeatils['skill2']} and ${nameAndContactDeatils['skill3']}. ${nameAndContactDeatils['skill1']} increased Revenue by 8% by analyzing and improving app monetization strategies and improving Lexor's impressive line of applications.",
                        style: pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      pw.Text(
                        "Highly-skilled and motivated senior ${nameAndContactDeatils['job']} with ${nameAndContactDeatils['exp']} years of experience."
                            "Enhanced performance of ${nameAndContactDeatils['skill1']},${nameAndContactDeatils['skill2']} and ${nameAndContactDeatils['skill3']}.",
                        style: pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      pw.Text(
                        "Highly-skilled and motivated senior ${nameAndContactDeatils['job']} with ${nameAndContactDeatils['exp']} years of experience. Enhanced performance of ${nameAndContactDeatils['skill1']},${nameAndContactDeatils['skill2']} and ${nameAndContactDeatils['skill3']}.",
                        style: pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      pw.SizedBox(height: 30),
                      pw.Text("Sincerely,"),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        '${nameAndContactDeatils['firstName']} ${nameAndContactDeatils['surName']}',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
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

    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/cv.pdf';
    final file = File(tempPath);
    await file.writeAsBytes(await pdf.save());

    // Open the PDF for printing
    await Printing.layoutPdf(
      onLayout: (_) => pdf.save(),
      name: 'coverLetter.pdf',
    );
  }

  final ColorScheme colorScheme = const ColorScheme.light(
    primary: Colors.blue,
    onPrimary: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cover Letter(Preview)'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(user)
            .collection('nameAndContactDeatils')
            .doc(user)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            final nameAndContactDeatils =
            snapshot.data!.data()! as Map<String, dynamic>;
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user)
                  .collection('recipientDetails')
                  .doc(user)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  final recipientDetails =
                  snapshot.data!.data()! as Map<String, dynamic>;
                  return SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: colorScheme.primary,
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  '${nameAndContactDeatils['firstName']} ${nameAndContactDeatils['surName']}',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Text(
                                  "Personal",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Phone",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${nameAndContactDeatils['phone']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${nameAndContactDeatils['email']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(2.0)),
                        Expanded(
                          flex: 4,
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 30),
                                Text(
                                  '${recipientDetails['city']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Mr. ${recipientDetails['firstName']} ${recipientDetails['surName']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                    '${recipientDetails['recipientPosition']} of Software House'),
                                SizedBox(height: 10),
                                Text('${recipientDetails['companyName']}'),
                                SizedBox(height: 10),
                                Text(
                                    '${recipientDetails['city']},${recipientDetails['country']}'),
                                SizedBox(height: 10),
                                Text('Dear ${recipientDetails['firstName']},'),
                                SizedBox(height: 20),
                                Text(
                                  "Highly-skilled and motivated senior ${nameAndContactDeatils['profession']} with ${nameAndContactDeatils['exp']} years of experience. Enhanced performance of 24 applications using ${nameAndContactDeatils['skill1']},${nameAndContactDeatils['skill2']} and ${nameAndContactDeatils['skill3']}. ${nameAndContactDeatils['skill1']} increased Revenue by 8% by analyzing and improving app monetization strategies and improving Lexor's impressive line of applications.",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Highly-skilled and motivated senior ${nameAndContactDeatils['job']} with ${nameAndContactDeatils['exp']} years of experience."
                                      "Enhanced performance of ${nameAndContactDeatils['skill1']},${nameAndContactDeatils['skill2']} and ${nameAndContactDeatils['skill3']}.",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Highly-skilled and motivated senior ${nameAndContactDeatils['job']} with ${nameAndContactDeatils['exp']} years of experience. Enhanced performance of ${nameAndContactDeatils['skill1']},${nameAndContactDeatils['skill2']} and ${nameAndContactDeatils['skill3']}.",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Text("Sincerely,"),
                                SizedBox(height: 5),
                                Text(
                                  '${nameAndContactDeatils['firstName']} ${nameAndContactDeatils['surName']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                        'Error occurred while fetching education details from Firestore.'),
                  );
                } else {
                  return Center(
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
            return Center(
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
