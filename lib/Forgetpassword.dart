import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);

  @override
  _ForgetState createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  final TextEditingController _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Forget Password",
          style: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.drag_handle_outlined))
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(children: [
        Column(children: [
          const Padding(padding: EdgeInsets.all(20)),
          Container(
            height: 300,
            width: 300,
            child: Image.network(
                "https://img.freepik.com/free-vector/illustration-characters-sending-email_53876-40834.jpg?w=360"),
          ),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(children: [
                const Row(
                  children: [
                    Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Entered the email associated with your account"
                  "and we will send the email with instruction "
                  "to reset your password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "Email Address ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, // Outline color
                      width: 1.0, // Outline thickness
                    ),
                    borderRadius:
                        BorderRadius.circular(8.0), // Optional: Border radius
                  ),
                  child: TextFormField(
                    autofocus: false,
                    controller: _emailcontroller,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your Email");
                      }
                      // reg expression for email validation
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a valid email");
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    decoration: InputDecoration(
                      hintText: "Enter your Email",
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  color: const Color(0xFF0D47A1),
                  height: 60,
                  width: 250,
                  child: ElevatedButton(
                    child: const Text(
                      'Send Email ',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    onPressed: () async {
                      var ForgetEmail = _emailcontroller.text.trim();

                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: ForgetEmail)
                            .then((value) => Navigator.of(context).pop())
                            .then((value) => Fluttertoast.showToast(
                                msg: "email sent successfully"))
                            .catchError((e) {
                          Fluttertoast.showToast(msg: e!.message.toString());
                        });
                        {
                          print("Email Sent");
                        }
                      } on FirebaseAuthException catch (e) {
                        print("Error $e");
                      }
                    },
                  ),
                ),
              ]))
        ])
      ]),
    );
  }
}
