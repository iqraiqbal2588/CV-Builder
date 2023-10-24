import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/model/personal_detail_model.dart';

import 'Experience.dart';

class personal_info extends StatefulWidget {
  const personal_info({Key? key}) : super(key: key);

  @override
  State<personal_info> createState() => _personal_infoState();
}

class _personal_infoState extends State<personal_info> {
  String? user = FirebaseAuth.instance.currentUser!.email;
  personalDetails pd = personalDetails();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user)
        .collection("personalDetails")
        .doc(user)
        .get()
        .then((value) {
      if (value.exists) {
        final personalDetailsData = personalDetails.fromMap(value.data()!);
        firstNameEditingController.text = personalDetailsData.firstName ?? '';
        secondNameEditingController.text = personalDetailsData.surName ?? '';
        addressController.text = personalDetailsData.address ?? '';
        cityController.text = personalDetailsData.city ?? '';
        countryController.text = personalDetailsData.country ?? '';
        postalCodeController.text = personalDetailsData.postalCode ?? '';
        phoneController.text = personalDetailsData.phone ?? '';
        emailController.text = personalDetailsData.email ?? '';
        summaryController.text = personalDetailsData.summary ?? '';
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final postalCodeController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final summaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Details"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ListView(
            padding: EdgeInsets.all(constraints.maxWidth * 0.05),
            children: [
              const Text(
                "Enter personal information for amazing CV",
                style: TextStyle(
                  color: Colors.blueAccent,
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
                      children: const [
                        Expanded(child: Text("First Name")),
                        SizedBox(width: 20),
                        Expanded(child: Text("Surname")),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                RegExp regex = RegExp(r'^[a-zA-Z]+$');
                                if (value!.isEmpty) {
                                  return ("First Name cannot be Empty");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Enter Valid name");
                                }
                                return null;
                              }),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                RegExp regex = RegExp(r'^[a-zA-Z]+$');
                                if (value!.isEmpty) {
                                  return ("Sur Name cannot be Empty");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Enter Valid name");
                                }
                                return null;
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Address"),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: addressController,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '(e.g.) Village Halloki, Lahore',
                        border: const OutlineInputBorder(),
                        errorText: _getErrorText(addressController),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Expanded(child: Text("City")),
                        SizedBox(width: 20),
                        Expanded(child: Text("Country")),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                RegExp regex = RegExp(r'^[a-zA-Z]+$');
                                if (value!.isEmpty) {
                                  return ("Country cannot be Empty");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Enter Valid country");
                                }
                                return null;
                              }
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
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          RegExp regex = RegExp(r'^[0-9]+$');
                          if (value!.isEmpty) {
                            return ("Postal Code cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Postal Code");
                          }
                          return null;
                        }
                    ),
                    const SizedBox(height: 20),
                    const Text("Phone"),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '(e.g.) +92 309 4513695',
                        border: const OutlineInputBorder(),
                        errorText: _getErrorText(phoneController),
                      ),
                        autovalidateMode:AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          RegExp regex = RegExp(r'^[0-9]+$');
                          if (value!.isEmpty) {
                            return ("Postal Code cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Postal Code");
                          }
                          return null;
                        }
                    ),
                    const SizedBox(height: 20),
                    const Text("Email"),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '(e.g.) abc123@domain.com',
                        border: const OutlineInputBorder(),
                        errorText: _getErrorText(emailController),
                      ),
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          RegExp regex = RegExp(r'^[a-zA-Z][a-zA-Z0-9._%+-]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (value!.isEmpty) {
                            return ("Email cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter email");
                          }
                          return null;
                        }
                    ),
                    const SizedBox(height: 20),
                    const Text("Summary"),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: summaryController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: '(e.g.) Hi I am a developer',
                        border: const OutlineInputBorder(),
                        errorText: _getErrorText(summaryController),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your summary';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.3,
                    height: constraints.maxHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final pd = personalDetails(
                            firstName: firstNameEditingController.text,
                            surName: secondNameEditingController.text,
                            address: addressController.text,
                            city: cityController.text,
                            country: countryController.text,
                            postalCode: postalCodeController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                            summary: summaryController.text,
                          );
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user)
                              .collection('personalDetails')
                              .doc(user)
                              .set(pd.toMap());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const experience(),
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
