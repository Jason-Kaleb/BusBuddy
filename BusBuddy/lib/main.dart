// import 'package:busbuddy/views/get_started_view.dart';
import 'package:busbuddy/views/login_view.dart';
import 'package:busbuddy/views/map_view.dart';
import 'package:busbuddy/views/register_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RegisterView(),
    );
  }
}
