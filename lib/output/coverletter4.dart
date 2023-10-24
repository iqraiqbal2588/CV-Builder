import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

class CoverLetter extends StatefulWidget {
  const CoverLetter({Key? key}) : super(key: key);

  @override
  State<CoverLetter> createState() => _CoverLetterState();
}

class _CoverLetterState extends State<CoverLetter> {
  String? uid = FirebaseAuth.instance.currentUser!.email;

  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    final personalDetailsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('nameAndContactDeatils')
        .doc(uid)
        .get();
    final nameAndContactDeatils =
    personalDetailsSnapshot.data()! as Map<String, dynamic>;

    final skillDetailsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('recipientDetails')
        .doc(uid)
        .get();
    final recipientDetails =
    skillDetailsSnapshot.data()! as Map<String, dynamic>;

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Padding(
              padding: const pw.EdgeInsets.all(10),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    "${nameAndContactDeatils['firstName']} ${nameAndContactDeatils['surName']}",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 1,
                    ),
                  ),
                  pw.SizedBox(height: 15),
                  pw.Text(
                    "${nameAndContactDeatils['job']}",
                    style: pw.TextStyle(fontSize: 14),
                  ),
                  pw.SizedBox(height: 15),
                  pw.Text(
                    "${nameAndContactDeatils['phone']}",
                    style: pw.TextStyle(fontSize: 14),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "${nameAndContactDeatils['email']}",
                    style: pw.TextStyle(fontSize: 14),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    "${nameAndContactDeatils['city']}",
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    "Mr. ${recipientDetails['firstName']} ${recipientDetails['surName']}",
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    "${recipientDetails['recipientPosition']} of Software House",
                    style: pw.TextStyle(fontSize: 14),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "${recipientDetails['companyName']}",
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    "${recipientDetails['city']}, ${recipientDetails['country']}",
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 15),
                  pw.Text(
                    "Dear ${recipientDetails['firstName']},",
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 15),
                  pw.Text(
                    "As a recent graduate, I am extremely interested in the ${nameAndContactDeatils['job']} opportunity posted on the Google website. After reviewing the key qualifications for this role, I am confident that I am well-prepared to be a valuable contributor to company growth and success.",
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "Through my academic journey, I applied a strong focus on building my software engineering and programming abilities. I am detail-oriented and meticulous when managing competing priorities within tight deadlines. I work best in roles where utilizing software development allows me to make a positive impact while using creative problem-solving to resolve issues and achieve goals.",
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "My academic strengths have greatly contributed to the development of my communication, problem-solving, and motivation skills. I bring clear and effective communication to build professional connections with co-workers, management, and customers. I would welcome the opportunity to further discuss the details of my experience and attributes, which I believe will be an asset to the Google team. Please review my attached resume for additional insight into my background. Thank you for your time and consideration.",
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "Sincerely,",
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "${nameAndContactDeatils['firstName']} ${nameAndContactDeatils['surName']}",
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ];
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
      name: 'cv.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cover Letter(Preview)'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('nameAndContactDeatils')
            .doc(uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            final nameAndContactDeatils =
            snapshot.data!.data()! as Map<String, dynamic>;
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .collection('recipientDetails')
                  .doc(uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  final recipientDetails =
                  snapshot.data!.data()! as Map<String, dynamic>;
                  return  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                          Text("${nameAndContactDeatils['firstName']} ${nameAndContactDeatils['surName']}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30,letterSpacing: 1)),
                          const SizedBox(height: 15),
                          Text("${nameAndContactDeatils['profession']}",style: const TextStyle(fontSize: 14),),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Icon(Icons.phone,size: 15,),
                              Text("${nameAndContactDeatils['phone']}",style: const TextStyle(fontSize: 14))
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.mail,size: 15,),
                              Text("${nameAndContactDeatils['email']}",style: const TextStyle(fontSize: 14))
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text("${nameAndContactDeatils['city']}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          Text("Mr. ${recipientDetails['firstName']} ${recipientDetails['surName']}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Text("${recipientDetails['recipientPosition']} of Software House",style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 10),
                          Text("${recipientDetails['companyName']}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Text("${recipientDetails['city']},${recipientDetails['country']}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 15),
                          Text("Dear ${recipientDetails['firstName']},",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 15),
                          Text("As a recent graduate, I am extremely interested in the ${nameAndContactDeatils['job']} opportunity posted on the Google website. After reviewing the key qualifications for this role, I am confident that I am well-prepared to be a valuable contributor to company growth and success."),
                          const SizedBox(height: 10),
                          const Text("Through my academic journey, 31 applied a strong focus on building my software engineering and programming abilities, I am detail-oriented and meticulous when managing competing priorities within tight deadlines. I work best in roles where utilizing software development allows me to make a positive impact while using creative problem-solving to resolve issues and achieve goals."),
                          const SizedBox(height: 10,),
                          const Text("My academic strengths have greatly contributed to the development of my communication, problem-solving and motivation skills. I bring clear and effective communicating to build professional connections with co-workers, management and customers. I would welcome the opportunity to further discuss the details of my experience and attributes which I believe will be an asset to the Google team. Please review my attached resume for additional insight into my background. Thank you for your time and consideration."),
                          const SizedBox(height: 10,),
                          const Text("Sincerely,"),
                          const SizedBox(height: 10,),
                          Text("${nameAndContactDeatils['firstName']} ${nameAndContactDeatils['surName']}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
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
