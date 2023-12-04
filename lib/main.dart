import 'package:flutter/material.dart';
import 'package:food/views/homepage.dart';

void main() => runApp(new MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Homepage(),
      },
    ));
