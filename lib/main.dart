import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/views/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.settings = Settings(
      persistenceEnabled: true,
    );

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Homepage(),
      },
    );
  }
}  
/*
import 'package:flutter/material.dart';
import 'package:food/views/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Homepage(),
      },
    );
  }
} */
