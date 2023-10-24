import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../coverletter.dart';
import '/model/recipients_model.dart';
import '/output/coverletter1.dart';

class recipient extends StatefulWidget {
  const recipient({super.key});

  @override
  State<recipient> createState() => _recipientState();
}

class _recipientState extends State<recipient> {
  String? user = FirebaseAuth.instance.currentUser!.email;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user)
        .collection("recipientDetails")
        .doc(user)
        .get()
        .then((value) {
      if (value.exists) {
        final personalDetailsData = recipientDetails.fromMap(value.data()!);
        firstNameEditingController.text = personalDetailsData.firstName ?? '';
        secondNameEditingController.text = personalDetailsData.surName ?? '';
        companyController.text = personalDetailsData.companyName ?? '';
        recipientController.text = personalDetailsData.recipientPosition ?? '';
        cityController.text = personalDetailsData.city ?? '';
        countryController.text = personalDetailsData.country ?? '';
        postalCodeController.text = personalDetailsData.postalCode ?? '';
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final companyController = TextEditingController();
  final recipientController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final postalCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipient"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ListView(
            padding: EdgeInsets.all(constraints.maxWidth * 0.05),
            children: [
              const Text(
                "Enter your recipient's information",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(child: Text("First Name")),
                        const SizedBox(width: 20),
                        const Expanded(child: Text("Surname")),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: firstNameEditingController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: '(e.g.) Haider',
                              border: const OutlineInputBorder(),
                              errorText:
                                  _getErrorText(firstNameEditingController),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: secondNameEditingController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: '(e.g.) Saeed',
                              border: const OutlineInputBorder(),
                              errorText:
                                  _getErrorText(secondNameEditingController),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your surname';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Company Name"),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: companyController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '(e.g.) Ilsa interactive',
                        border: const OutlineInputBorder(),
                        errorText: _getErrorText(companyController),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your company';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Recipient Position"),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: recipientController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '(e.g.) HR Manager',
                        border: const OutlineInputBorder(),
                        errorText: _getErrorText(recipientController),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your recipient position';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(child: Text("City")),
                        const SizedBox(width: 20),
                        const Expanded(child: Text("Country")),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: cityController,
                            keyboardType: TextInputType.streetAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: '(e.g.) Lahore',
                              border: const OutlineInputBorder(),
                              errorText: _getErrorText(cityController),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your city';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: countryController,
                            keyboardType: TextInputType.streetAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: '(e.g.) Pakistan',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your country';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Postal Code"),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: postalCodeController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '(e.g.) 55151',
                        border: const OutlineInputBorder(),
                        errorText: _getErrorText(postalCodeController),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your postal code';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.3,
                          height: constraints.maxHeight * 0.07,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final ex = recipientDetails(
                                  firstName: firstNameEditingController.text,
                                  surName: secondNameEditingController.text,
                                  companyName: companyController.text,
                                  recipientPosition: recipientController.text,
                                  city: cityController.text,
                                  country: countryController.text,
                                  postalCode: postalCodeController.text,
                                );
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user)
                                    .collection('recipientDetails')
                                    .doc(user)
                                    .set(ex.toMap());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const coverletter(),
                                  ),
                                );
                              }
                            },
                            child: const Text("Next"),
                          ),
                        ),
                      ],
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

  String? _getErrorText(TextEditingController controller) {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return null;
    }
    if (controller.text.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
