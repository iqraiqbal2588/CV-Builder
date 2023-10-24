import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int _rating = 0;
  TextEditingController _feedbackController = TextEditingController();
  String? uid = FirebaseAuth.instance.currentUser!.email;

  void _submitFeedback() {
    // Store feedback data in Firestore
    String feedbackText = _feedbackController.text;

    FirebaseFirestore.instance.collection('feedback').doc(uid).set({
      'rating': _rating,
      'feedback': feedbackText,
    });

    // Clear input fields after submission
    _rating = 0;
    _feedbackController.clear();

    // Show a success message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thank You'),
          content: const Text('Your feedback has been submitted.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
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
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rate the app:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 1; i <= 5; i++)
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _rating = i;
                            });
                          },
                          icon: Icon(
                            _rating >= i ? Icons.star : Icons.star_border,
                            color: Colors.yellow[700],
                            size: constraints.maxWidth * 0.08,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Feedback:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _feedbackController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Enter your feedback',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: constraints.maxWidth * 0.1,
                    child: ElevatedButton(
                      onPressed: _submitFeedback,
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
