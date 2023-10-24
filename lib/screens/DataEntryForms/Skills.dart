import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/createcv.dart';

import '/model/skill_model.dart';
import '../../output/cv1.dart';

class skill extends StatefulWidget {
  const skill({super.key});

  @override
  State<skill> createState() => _skillState();
}

class _skillState extends State<skill> {
  String? user = FirebaseAuth.instance.currentUser!.email;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user)
        .collection("skill")
        .doc(user)
        .get()
        .then((value) {
      if (value.exists) {
        final personalDetailsData = skills.fromMap(value.data()!);
        skill1Controller.text = personalDetailsData.skill1 ?? '';
        skill2Controller.text = personalDetailsData.skill2 ?? '';
        skill3Controller.text = personalDetailsData.skill3 ?? '';
        skill4Controller.text = personalDetailsData.skill4 ?? '';
      }
    });
  }

  TextEditingController skill1Controller = TextEditingController();
  TextEditingController skill2Controller = TextEditingController();
  TextEditingController skill3Controller = TextEditingController();
  TextEditingController skill4Controller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildform() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 20, 0, 5),
            child: Text(
              "Tell us about your Skills",
              style: TextStyle(color: Colors.blue, fontSize: 24),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
            child: Text("Skill 1"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: SizedBox(
              width: 380,
              child: TextFormField(
                controller: skill1Controller,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: '(i.e). Python',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the skill';
                  }
                  return null;
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: Text("Skill 2"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: SizedBox(
              width: 380,
              child: TextFormField(
                controller: skill2Controller,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: '(i.e). Java',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the skill';
                  }
                  return null;
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
            child: Text("Skill 3"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: SizedBox(
              width: 380,
              child: TextFormField(
                controller: skill3Controller,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: '(i.e). C++',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the skill';
                  }
                  return null;
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: Text("Skill 4"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: SizedBox(
              width: 380,
              child: TextFormField(
                controller: skill4Controller,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: '(i.e). C',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the skill';
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skills"),
      ),
      body: ListView(
        children: [
          buildform(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final ex = skills(
                          skill1: skill1Controller.text,
                          skill2: skill2Controller.text,
                          skill3: skill3Controller.text,
                          skill4: skill4Controller.text,
                        );
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(user)
                            .collection('skill')
                            .doc(user)
                            .set(ex.toMap());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const createcv(),
                          ),
                        );
                      }
                    },
                    child: const Text("Next"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
