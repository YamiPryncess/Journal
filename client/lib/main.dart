// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:client/routes/Note.dart';
import 'package:client/routes/Home.dart';

void main() {
  runApp(const MyApp());

  // print({}.runtimeType);
  // print({1: "hello"}.runtimeType);
  // print(<String>{}.runtimeType);
  // print({"Hello", 1, true}.runtimeType);
  // print(1.isOdd);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        // routes: {
        //   Note.routeName: (context) => Note(),
        //   Home.routeName: (context) => Home()
        // },
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ));
  }
}
