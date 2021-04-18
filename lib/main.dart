import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const BASE_URL = 'https://stormy-woodland-10710.herokuapp.com/api/';

final dio = Dio();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ,
    );
  }
}
