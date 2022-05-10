import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

var loggedInUser;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getCurrentUser();
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  void getCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        loggedInUser = user.email;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.cancel_outlined,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('Signed-In with $loggedInUser'),
      ),
    );
  }
}
