import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/model/exp_model.dart';
import 'Education.dart';
import 'secondExperience.dart';

class experience extends StatefulWidget {
  const experience({Key? key}) : super(key: key);

  @override
  State<experience> createState() => _experienceState();
}

class _experienceState extends State<experience> {
  String? user = FirebaseAuth.instance.currentUser!.email;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user)
        .collection("experience")
        .doc(user)
        .get()
        .then((value) {
      if (value.exists) {
        final personalDetailsData = exp.fromMap(value.data()!);
        jobTitleController.text = personalDetailsData.jobTitle ?? '';
        companyNameController.text = personalDetailsData.companyName ?? '';
        cityController.text = personalDetailsData.city ?? '';
        countryController.text = personalDetailsData.country ?? '';
        descriptionController.text = personalDetailsData.description ?? '';
        startDateController.text = personalDetailsData.startDate ?? '';
        endDateController.text = personalDetailsData.endDate ?? '';
      }
    });
  }

  bool value = false;
  bool showEndDate = true;

  TextEditingController jobTitleController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedStartDate = picked;
        startDateController.text =
            "${selectedStartDate.year.toString()}-${selectedStartDate.month.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedEndDate = picked;
        endDateController.text =
            "${selectedEndDate.year.toString()}-${selectedEndDate.month.toString().padLeft(2, '0')}";
      });
    }
  }

  Widget buildform() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 20, 0, 5),
            child: Text(
              "Tell us about your experience",
              style: TextStyle(color: Colors.blue, fontSize: 24),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
            child: Text("Job Title"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: SizedBox(
              width: double.infinity,
              child: TextFormField(
                controller: jobTitleController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: '(i.e). Software Engineer',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job title';
                  }
                  return null;
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: Text("Company Name"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: SizedBox(
              width: double.infinity,
              child: TextFormField(
                controller: companyNameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: '(i.e). Macro Mobile Solution',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the company name';
                  }
                  return null;
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: Text("City"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: SizedBox(
              width: double.infinity,
              child: TextFormField(
                controller: cityController,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: '(i.e). Lahore',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the city';
                  }
                  return null;
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: Text("Country"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: SizedBox(
              width: double.infinity,
              child: TextFormField(
                controller: countryController,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: '(i.e). Pakistan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the country';
                  }
                  return null;
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: Text("Description"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: SizedBox(
              width: double.infinity,
              child: TextFormField(
                controller: descriptionController,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: '(i.e). Hi I am a software developer',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
            child: Text("Start Date"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 300, 5),
            child: SizedBox(
              width: 150,
              child: TextFormField(
                onTap: () {
                  _selectStartDate(context);
                },
                controller: startDateController,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'YYYY-MM',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the start date';
                  }
                  return null;
                },
              ),
            ),
          ),
          if (showEndDate)
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
              child: Text("End Date"),
            ),
          if (showEndDate)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 300, 5),
              child: SizedBox(
                width: 150,
                child: TextFormField(
                  onTap: () {
                    _selectEndDate(context);
                  },
                  controller: endDateController,
                  readOnly: true,
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'YYYY-MM',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the end date';
                    }
                    return null;
                  },
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 5, 0, 5),
            child: Row(
              children: [
                Checkbox(
                  value: value,
                  onChanged: (bool? newValue) {
                    setState(() {
                      value = newValue ?? false;
                      if (value) {
                        endDateController.text = 'Current';
                      }
                      showEndDate = !value;
                    });
                  },
                ),
                const Text("I currently work")
              ],
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
        title: const Text("Experience"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ListView(
            children: [
              buildform(),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  constraints.maxWidth * 0.05,
                  constraints.maxHeight * 0.02,
                  constraints.maxWidth * 0.05,
                  constraints.maxHeight * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.5,
                      height: constraints.maxHeight * 0.07,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final ex = exp(
                              jobTitle: jobTitleController.text,
                              companyName: companyNameController.text,
                              city: cityController.text,
                              country: countryController.text,
                              description: descriptionController.text,
                              startDate: startDateController.text,
                              endDate: endDateController.text,
                            );
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user)
                                .collection('experience')
                                .doc(user)
                                .set(ex.toMap());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const secondExperience(),
                              ),
                            );
                          }
                        },
                        child: const Text("Add another experience"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  constraints.maxWidth * 0.05,
                  constraints.maxHeight * 0.02,
                  constraints.maxWidth * 0.05,
                  constraints.maxHeight * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.2,
                      height: constraints.maxHeight * 0.07,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final ex = exp(
                              jobTitle: jobTitleController.text,
                              companyName: companyNameController.text,
                              city: cityController.text,
                              country: countryController.text,
                              description: descriptionController.text,
                              startDate: startDateController.text,
                              endDate: endDateController.text,
                            );
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user)
                                .collection('experience')
                                .doc(user)
                                .set(ex.toMap());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const education(),
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
          );
        },
      ),
    );
  }
}
