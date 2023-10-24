import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FilePickerPage extends StatefulWidget {
  String? uemail;

  FilePickerPage({required String uemail}) {
    this.uemail = uemail;
  }

  @override
  _FilePickerPageState createState() => _FilePickerPageState();
}

class _FilePickerPageState extends State<FilePickerPage> {
  String? user = FirebaseAuth.instance.currentUser!.email;
  File? selectedFile;
  String? uploadMessage;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  Future uploadFile() async {
    if (selectedFile == null) {
      setState(() {
        uploadMessage = 'Please select a file first';
      });
      return;
    }

    try {
      Reference storageReference =
      FirebaseStorage.instance.ref().child(selectedFile!.path);
      UploadTask uploadTask = storageReference.putFile(selectedFile!);
      TaskSnapshot taskSnapshot = await uploadTask;

      setState(() {
        uploadMessage = 'File uploaded successfully';
      });

      String fileUrl = await storageReference.getDownloadURL();

      // Save additional information in Firestore
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String contact = contactController.text.trim();

      FirebaseFirestore.instance.collection('file').doc(user).set({
        'name': name,
        'email': email,
        'contact': contact,
        'fileUrl': fileUrl,
        'authoremail': widget.uemail
      });

      setState(() {
        nameController.clear();
        emailController.clear();
        contactController.clear();
        selectedFile = null;
        uploadMessage = null;
      });
    } catch (error) {
      setState(() {
        uploadMessage = 'Error uploading file: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Color(0xFF0D47A1),
        title: Text('Apply For Job'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Please fill out the form and upload your CV',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32),
            TextFormField(
              controller: nameController,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                prefixIcon: Icon(Icons.person),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: emailController,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_rounded),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: contactController,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: 'Contact',
                hintText: 'Enter your phone number',
                prefixIcon: Icon(Icons.contact_phone_rounded),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: pickFile,
              child: Text('Upload Your CV'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 16),
            if (selectedFile != null)
              Text(
                'Selected File: ${selectedFile!.path}',
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 16),
            if (uploadMessage != null)
              Text(
                uploadMessage!,
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: uploadFile,
              child: Text('Submit Application'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}