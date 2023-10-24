import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Job {
  String jobTitle;
  String companyName;
  String place;
  String description;
  String salary;
  String gmail;
  String phone;

  Job({
    required this.jobTitle,
    required this.companyName,
    required this.place,
    required this.description,
    required this.salary,
    required this.gmail,
    required this.phone,
  });
}

class AddJobForm extends StatefulWidget {
  @override
  _AddJobFormState createState() => _AddJobFormState();
}

class _AddJobFormState extends State<AddJobForm> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  late String _jobTitle;
  late String _companyName;
  late String _place;
  late String _description;
  late String _salary;
  late String _gmail;
  late String _phone;

  void _addJob() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        User? user = _auth.currentUser;
        if (user != null) {
          String userId = user.uid;
          Job job = Job(
            jobTitle: _jobTitle,
            companyName: _companyName,
            place: _place,
            description: _description,
            salary: _salary,
            gmail: _gmail,
            phone: _phone,
          );

          await _firestore.collection('jobFeatures').doc(user.email).set({
            'jobTitle': job.jobTitle,
            'companyName': job.companyName,
            'place': job.place,
            'description': job.description,
            'salary': job.salary,
            'gmail': job.gmail,
            'phone': job.phone,
          });

          // Clear the form fields
          _formKey.currentState!.reset();

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('Job added successfully.'),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred while adding the job.'),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D47A1),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xFF0D47A1),
        centerTitle: true,
        title: Text('Post Your Job',
            style: TextStyle(fontSize: 25.0, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0.0),
        child: Form(
          key: _formKey,
          child: Container(
              height: MediaQuery.of(context).size.height - 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(75.0),
                    topRight: Radius.circular(75.0)),
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25.0, right: 20.0),
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Text(
                        "Add Company details in Form ",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Job Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 2.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the job title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _jobTitle = value!;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Company Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 2.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the company name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _companyName = value!;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Place',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 2.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the place';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _place = value!;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 2.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _description = value!;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Salary',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 2.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the salary';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _salary = value!;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 2.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _gmail = value!;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 2.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the phone number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _phone = value!;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _addJob,
                    child: Text(
                      'Add Job',
                      style: TextStyle(fontSize: 22.0, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
