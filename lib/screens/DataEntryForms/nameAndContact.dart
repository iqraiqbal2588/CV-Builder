import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/model/nameAndContact_model.dart';
import '/screens/DataEntryForms/recipients.dart';

class nameAndContact extends StatefulWidget {
  const nameAndContact({Key? key}) : super(key: key);

  @override
  State<nameAndContact> createState() => _nameAndContactState();
}

class _nameAndContactState extends State<nameAndContact> {
  String? user = FirebaseAuth.instance.currentUser!.email;
  String? initialDropdownValue;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user)
        .collection("nameAndContactDeatils")
        .doc(user)
        .get()
        .then((value) {
      if (value.exists) {
        final DetailsData = nameAndContactDetail.fromMap(value.data()!);
        firstNameEditingController.text = DetailsData.firstName ?? '';
        secondNameEditingController.text = DetailsData.surName ?? '';
        professionController.text = DetailsData.profession ?? '';
        jobController.text = DetailsData.job ?? '';
        cityController.text = DetailsData.city ?? '';
        countryController.text = DetailsData.country ?? '';
        postalCodeController.text = DetailsData.postalCode ?? '';
        phoneController.text = DetailsData.phone ?? '';
        emailController.text = DetailsData.email ?? '';
        skill1Controller.text = DetailsData.skill1 ?? '';
        skill2Controller.text = DetailsData.skill2 ?? '';
        skill3Controller.text = DetailsData.skill3 ?? '';
        initialDropdownValue = DetailsData.exp ?? '';
        print(initialDropdownValue);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final professionController = TextEditingController();
  final jobController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final postalCodeController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final skill1Controller = TextEditingController();
  final skill2Controller = TextEditingController();
  final skill3Controller = TextEditingController();
  String dropDownValue = "0";
  var items = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10+'];

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
                "Enter personal information for amazing Cover letter",
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
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
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
                    const Text("Profession"),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: professionController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '(e.g.) Web Developer',
                        border: const OutlineInputBorder(),
                        errorText: _getErrorText(professionController),
                      ),
                      autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your profession';
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: Text("Job Title")),
                        SizedBox(width: 20),
                        Expanded(child: Text("Experience")),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: jobController,
                            keyboardType: TextInputType.streetAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: '(e.g.) Backend developer',
                              border: const OutlineInputBorder(),
                              errorText: _getErrorText(jobController),
                            ),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your job title';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
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
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
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
                            controller: cityController,
                            keyboardType: TextInputType.streetAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: '(e.g.) Lahore',
                              border: const OutlineInputBorder(),
                              errorText: _getErrorText(cityController),
                            ),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
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
                      autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your postal code';
                        }
                        return null;
                      },
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
                      autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Skill 1"),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: skill1Controller,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '(e.g.) Soft Skill',
                        border: const OutlineInputBorder(),
                        errorText: _getErrorText(skill1Controller),
                      ),
                      autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your skill 1';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Skill 2"),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: skill2Controller,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '(e.g.) Soft Skill',
                        border: const OutlineInputBorder(),
                        errorText: _getErrorText(skill2Controller),
                      ),
                      autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your skill 2';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Skill 3"),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: skill3Controller,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: '(e.g.) Soft Skill',
                        border: const OutlineInputBorder(),
                        errorText: _getErrorText(skill3Controller),
                      ),
                      autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your skill 3';
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
                                final ex = nameAndContactDetail(
                                  firstName: firstNameEditingController.text,
                                  surName: secondNameEditingController.text,
                                  profession: professionController.text,
                                  job: jobController.text,
                                  exp: dropDownValue,
                                  city: cityController.text,
                                  country: countryController.text,
                                  postalCode: postalCodeController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  skill1: skill1Controller.text,
                                  skill2: skill2Controller.text,
                                  skill3: skill3Controller.text,
                                );
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user)
                                    .collection('nameAndContactDeatils')
                                    .doc(user)
                                    .set(ex.toMap());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const recipient(),
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
