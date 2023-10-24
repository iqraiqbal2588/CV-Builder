import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/authorpanel.dart';
import 'package:fyp/signup.dart';

import 'Forgetpassword.dart';
import 'adminpanal.dart';
import 'fyp_dashboard.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? Key}) : super(key: Key);

  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool _obscureText = true;
  bool _isLoading = false;

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(text),
      ),
    );
  }

  GlobalKey<FormState> _Formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "CV builder",
            style: TextStyle(
              fontSize: 28,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            SizedBox(
              width: 20,
            ),
            Container(
              width: 160,
              height: 20,
              color: Colors.lightBlueAccent,
            ),
            Padding(padding: EdgeInsets.fromLTRB(50, 10, 10, 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "   Cv Builder Login",
                  style: TextStyle(
                    fontSize: 30,
                    //fontFamily: "times new roman",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 20,
            ),
            Row(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "  Welcome back to Cv Builder",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  " login with your registered email & password.",
                  style: TextStyle(
                    fontSize: 18,
                    //fontFamily: "times new roman",
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
              width: 30,
            ),
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Form(
                        key: _Formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofocus: false,
                              controller: _emailcontroller,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Your Email";
                                }
                                // reg expression for email validation
                                if (!RegExp(
                                        r'^[a-zA-Z][a-zA-Z0-9._%+-]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                    .hasMatch(value)) {
                                  return "Please Enter a valid email";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _emailcontroller.text = value!;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.mail),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofocus: false,
                              controller: _passcontroller,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscureText,
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
                              onSaved: (value) {
                                _passcontroller.text = value!;
                              },
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                prefixIcon: const Icon(Icons.vpn_key),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    width: 3.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Forget(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Forget Password?',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width: 390,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: ElevatedButton(
                                    child: const Text(
                                      'Login ',
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                    onPressed: () async {
                                      await _Formkey.currentState?.validate();
                                      var loginEmail =
                                          _emailcontroller.text.trim();
                                      var loginPass =
                                          _passcontroller.text.trim();
                                      String adminEmail = 'iqra@gmail.com';
                                      String adminPass = 'iqra.2351';

                                      try {
                                        if (loginEmail == adminEmail &&
                                            loginPass == adminPass) {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminDashboardScreen(),
                                            ),
                                            (route) => false,
                                          );
                                        } else {
                                          // Check if the user has the "author" role
                                          var userDoc = await FirebaseFirestore
                                              .instance
                                              .collection('Author')
                                              .doc(loginEmail)
                                              .get();
                                          if (userDoc.exists) {
                                            final User? firebaseUser =
                                                (await FirebaseAuth.instance
                                                        .signInWithEmailAndPassword(
                                              email: loginEmail,
                                              password: loginPass,
                                            ))
                                                    .user;
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Authorpanel(),
                                              ),
                                              (route) => false,
                                            );
                                            User? user = FirebaseAuth
                                                .instance.currentUser;
                                          }
                                        }
                                        var userDoc = await FirebaseFirestore
                                            .instance
                                            .collection('users')
                                            .doc(loginEmail)
                                            .get();
                                        if (userDoc.exists) {
                                          final User? firebaseUser =
                                              (await FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                email: loginEmail,
                                                password: loginPass,
                                              ))
                                                  .user;
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Dashboard(),
                                            ),
                                                (route) => false,
                                          );
                                          User? user = FirebaseAuth
                                              .instance.currentUser;
                                      }
                                      } on FirebaseAuthException catch (e) {
                                        print("Error: $e");
                                        showSnackBar(
                                            "Invalid email or password.");
                                      }

                                      if (loginEmail.isEmpty) {
                                        showSnackBar(
                                            "Please enter your email!");
                                      } else if (loginPass.isEmpty) {
                                        showSnackBar(
                                            "Please enter your password!");
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  " Don't have an account? ",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      new MaterialPageRoute(
                                        builder: (context) => new myForm(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Register now',
                                    style: TextStyle(
                                      //fontFamily: 'Times New Roman',
                                      color: Colors.blueAccent,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
