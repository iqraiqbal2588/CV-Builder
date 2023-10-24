import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginclass.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String newEmail = '';
  String newPassword = '';
  String confirmPassword = '';
  bool isPasswordVisible = false;

  String successMessage = '';

  void _showSuccessMessage(String message) {
    setState(() {
      successMessage = message;
    });
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        successMessage = '';
      });
    });
  }

  Future<void> _changePassword() async {
    if (newPassword.isNotEmpty && newPassword == confirmPassword) {
      try {
        User? user = _auth.currentUser;
        if (user != null) {
          await user.updatePassword(newPassword);
          _showSuccessMessage('Password changed successfully!');
        }
      } catch (e) {
        _showSuccessMessage('Failed to change password: $e');
      }
    } else {
      _showSuccessMessage('Passwords do not match!');
    }
  }

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
        FirebaseFirestore.instance.collection('users').doc(user.email).delete();
        _showSuccessMessage('Account deleted successfully!');
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(
            builder: (context) =>  MyLogin(),
          ),
        );
      }
    } catch (e) {
      _showSuccessMessage('Failed to delete account: $e');
    }
  }

  void _openChangePasswordPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangePasswordPage()),
    );
  }

  void _openDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text('Are you sure you want to delete your account?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _deleteAccount(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Change Password'),
                      onTap: _openChangePasswordPage,
                    ),
                    ListTile(
                      title: Text(
                        'Delete Account',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () {
                        _openDeleteAccountDialog(context);
                      },
                    ),
                    SizedBox(height: 20),
                    if (successMessage.isNotEmpty)
                      Text(
                        successMessage,
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool? _passwordVisible;


  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String oldPassword = '';
  String newPassword = '';
  String confirmPassword = '';

  String successMessage = '';

  void _showSuccessMessage(String message) {
    setState(() {
      successMessage = message;
    });
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        successMessage = '';
      });
    });
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = _auth.currentUser;
        if (user != null) {
          FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.email)
              .update({"userpassword": newPassword,});
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.email)
              .update({"userConfrmpass": newPassword,});
          _showSuccessMessage('Password changed successfully!');
          Navigator.pop(context);
        }
      } catch (e) {
        _showSuccessMessage('Failed to change password: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              TextFormField(
                obscureText: true,
                onChanged: (value) => oldPassword = value,
                decoration: InputDecoration(
                  hintText: "Old Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your old password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                onChanged: (value) => newPassword = value,
                decoration: InputDecoration(
                  hintText: "New Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your new password';
                  }
                  RegExp regex = RegExp(r'^.{8,}$');
                  if (value.isEmpty) {
                    return "Password is required for login";
                  }
                  if (!regex.hasMatch(value)) {
                    return "Enter Valid Password(Min. 8 Character)";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(

                obscureText: true,
                onChanged: (value) => confirmPassword = value,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != newPassword) {
                    return 'Passwords do not match';
                  }
                  RegExp regex = RegExp(r'^.{8,}$');
                  if (value.isEmpty) {
                    return "Password is required for login";
                  }
                  if (!regex.hasMatch(value)) {
                    return "Enter Valid Password(Min. 8 Character)";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _changePassword,
                    child: Text('Change Password'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (successMessage.isNotEmpty)
                Text(
                  successMessage,
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteAccountPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _deleteAccount() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();

        // Handle account deletion success
      }
    } catch (e) {
      // Handle account deletion failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Account'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to delete your account?',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deleteAccount,
              child: Text('Delete Account'),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
