import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/model/edu_model.dart';
import 'Skills.dart';
import 'secondEducation.dart';

class education extends StatefulWidget {
  const education({Key? key}) : super(key: key);

  @override
  State<education> createState() => _educationState();
}

class _educationState extends State<education> {
  String? user = FirebaseAuth.instance.currentUser!.email;
  String? initialDropdownValue;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user)
        .collection("education")
        .doc(user)
        .get()
        .then((value) {
      if (value.exists) {
        final personalDetailsData = edu.fromMap(value.data()!);
        schoolNameController.text = personalDetailsData.schoolName ?? '';
        schoolLocationController.text =
            personalDetailsData.schoolLocation ?? '';
        fieldOfStudyController.text = personalDetailsData.fieldOfStudy ?? '';
        initialDropdownValue = personalDetailsData.degree ?? '';
      }
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropDownValue = "Not Selected";
  var items = [
    'Not Selected',
    'Bachelors',
    'Masters',
    'Diploma',
    'Associate Degree',
    'Certification'
  ];

  TextEditingController schoolNameController = TextEditingController();
  TextEditingController schoolLocationController = TextEditingController();
  TextEditingController fieldOfStudyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Education"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 20, 0, 5),
              child: Text(
                "Tell us about your education",
                style: TextStyle(color: Colors.blue, fontSize: 24),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
              child: Text("School Name"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
              child: SizedBox(
                width: 250,
                child: TextFormField(
                  controller: schoolNameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: '(i.e). University Of Lahore',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the school name';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
              child: Text("School Location"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
              child: SizedBox(
                width: 250,
                child: TextFormField(
                  controller: schoolLocationController,
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: '(i.e). Lahore, Punjab, Pakistan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the school location';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
              child: Text("Degree"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 200, 5),
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(10),
                value: initialDropdownValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownValue = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
              child: Text("Field of Study"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
              child: SizedBox(
                width: 250,
                child: TextFormField(
                  controller: fieldOfStudyController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: '(i.e). Computer Science',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the field of study';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final ex = edu(
                            schoolName: schoolNameController.text,
                            schoolLocation: schoolLocationController.text,
                            degree: dropDownValue,
                            fieldOfStudy: fieldOfStudyController.text,
                          );
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user)
                              .collection('education')
                              .doc(user)
                              .set(ex.toMap());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const secondEducation()),
                          );
                        }
                      },
                      child: const Text("Add another education"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final ex = edu(
                            schoolName: schoolNameController.text,
                            schoolLocation: schoolLocationController.text,
                            degree: dropDownValue,
                            fieldOfStudy: fieldOfStudyController.text,
                          );
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user)
                              .collection('education')
                              .doc(user)
                              .set(ex.toMap());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const skill()),
                          );
                        }
                      },
                      child: const Text("Next"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// bool validateInput() {
//   if (schoolNameController.text.isEmpty) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Missing Information'),
//         content: const Text('Please enter the school name.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//     return false;
//   } else if (schoolLocationController.text.isEmpty) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Missing Information'),
//         content: const Text('Please enter the school location.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//     return false;
//   } else if (dropDownValue == 'Not Selected') {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Missing Information'),
//         content: const Text('Please select a degree.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//     return false;
//   } else if (fieldOfStudyController.text.isEmpty) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Missing Information'),
//         content: const Text('Please enter the field of study.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//     return false;
//   }
//
//   return true;
// }

// bool _validateForm() {
//   // Validate the form fields
//   if (schoolNameController.text.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Please enter the school name')),
//     );
//     return false;
//   }
//   if (schoolLocationController.text.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Please enter the school location')),
//     );
//     return false;
//   }
//   if (fieldOfStudyController.text.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Please enter the field of study')),
//     );
//     return false;
//   }
//   return true;
// }
