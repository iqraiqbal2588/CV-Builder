import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fyp/fyp_dashboard.dart';
import 'package:uuid/uuid.dart';

import 'authorpanel.dart';
import 'loginclass.dart';

class myForm extends StatefulWidget {
  const myForm({Key? key}) : super(key: key);

  @override
  _myForm createState() => _myForm();
}

class _myForm extends State<myForm> {
  String selectedUserRole = "";
  bool? _passwordVisible;


  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  ]);
  String? password;

  GlobalKey<FormState> _Formkey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();

  TextEditingController useremailnameController = TextEditingController();

  TextEditingController userpasswordController = TextEditingController();
  TextEditingController userConfirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "CV builder",
          style: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(padding: const EdgeInsets.all(15), children: [
        const Column(
          children: [
            SizedBox(
              height: 52,
              width: 400,
              child: Text(
                "Create your free Cv builder "
                "     account",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              height: 130,
              width: 380,
              child: const Text(
                "Register with basic information, Complete you profile"
                "and start applying for the job and make professional Resume for free!",
                style: TextStyle(
                  fontSize: 18,
                  //fontFamily: "times new roman",
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          child: Form(
            key: _Formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                        controller: usernameController,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Full Name",
                            prefixIcon: const Icon(
                              Icons.account_box,
                              size: 40,
                              color: Colors.black,
                            ),
                            hintStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        validator: (value) {
                          RegExp regex = RegExp(r'^[a-zA-Z]+$');
                          if (value!.isEmpty) {
                            return ("First Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name");
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                        controller: useremailnameController,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Email-Address",
                            hintStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Your Email");
                          }
                          if (!RegExp(
                              r'^[a-zA-Z][a-zA-Z0-9._%+-]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        obscureText: _passwordVisible!,
                        autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                        controller: userpasswordController,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible!
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                                size: 30,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible!;
                                });
                              },
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Password",
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 30,
                              color: Colors.black,
                            ),
                            hintStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onChanged: (val) => password = val,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{8,}$');
                          if (value!.isEmpty) {
                            return "Password is required for login";
                          }
                          if (!regex.hasMatch(value)) {
                            return "Enter Valid Password(Min. 8 Character)";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          textInputAction: TextInputAction.done,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          controller: userConfirmpasswordController,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                          obscureText: _passwordVisible!,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible!
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible!;
                                  });
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "Confirm Password",
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 30,
                                color: Colors.black,
                              ),
                              hintStyle: const TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          validator: (val) => MatchValidator(
                                  errorText: 'passwords do not match')
                              .validateMatch(val!, password!)),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            height: 80,
                            width: 380,
                            child: Text(
                              "By clicking on'Create Cv Builder Account bellow you are "
                              "agreeing to the terms and conditions of Cv Builder!",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "if you want to enter as a User",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedUserRole = "user";
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedUserRole == "user"
                                    ? Colors.blueAccent
                                    : const Color(0xFF0D47A1),
                              ),
                              child: const Text('User'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "if you want to add Job",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedUserRole = "author";
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedUserRole == "author"
                                    ? Colors.blueAccent
                                    : const Color(0xFF0D47A1),
                              ),
                              child: const Text('Author'),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: 50,
                              width: 380,
                              //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ElevatedButton(
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 20,
                                    //fontFamily: "Times new roman"
                                  ),
                                ),
                                onPressed: () async {
                                  _Formkey.currentState?.validate();
                                  var username =
                                      usernameController.text.trim();
                                  var useremailname =
                                      useremailnameController.text.trim();
                                  var userpassword =
                                      userpasswordController.text.trim();
                                  var userCpassword =
                                      userConfirmpasswordController.text
                                          .trim();
                                  final String uid = Uuid().v4();
                                  String adminEmail = 'iqra@gmail.com';
                                  String adminpass = 'iqra.2351';
                                  if (useremailname == adminEmail &&
                                      userpassword == adminpass) {
                                    try {
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: useremailname,
                                              password: userpassword);
                                      await FirebaseAuth.instance.signOut();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Dashboard()),
                                      );

                                      await FirebaseFirestore.instance
                                          .collection("admin")
                                          .doc(useremailname)
                                          .set({
                                        "username": username,
                                        "useremailname": useremailname,
                                        "userpassword": userpassword,
                                        "userConfrmpass": userCpassword,
                                        "createdAt": DateTime.now(),
                                      });

                                    } catch (error) {
                                      Fluttertoast.showToast(
                                        msg: error.toString(),
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    }
                                  } else if (selectedUserRole == "author") {
                                    try {
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: useremailname,
                                              password: userpassword);
                                      await FirebaseAuth.instance.signOut();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Authorpanel()),
                                      );

                                      await FirebaseFirestore.instance
                                          .collection('Author')
                                          .doc(useremailname)
                                          .set({
                                        "username": username,
                                        "useremailname": useremailname,
                                        "userpassword": userpassword,
                                        "userConfrmpass": userCpassword,
                                        "createdAt": DateTime.now(),
                                      });

                                    } catch (error) {
                                      Fluttertoast.showToast(
                                        msg: error.toString(),
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    }
                                  } else {
                                    try {
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: useremailname,
                                              password: userpassword);
                                      await FirebaseAuth.instance.signOut();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Dashboard(),
                                        ),
                                            (route) => false,
                                      );

                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(useremailname)
                                          .set({
                                        "username": username,
                                        "useremailname": useremailname,
                                        "userpassword": userpassword,
                                        "userConfrmpass": userCpassword,
                                        "createdAt": DateTime.now(),
                                        "userid" : uid,
                                      });

                                    } catch (error) {
                                      Fluttertoast.showToast(
                                        msg: error.toString(),
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    }
                                  }
                                },
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Login now',
                              style: TextStyle(
                                //fontFamily: 'Times New Roman',
                                color: Colors.blue,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}