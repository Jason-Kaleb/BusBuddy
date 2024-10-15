import 'package:busbuddy/views/personal_info.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCuNCDLYnaI0slMvJ-ioEaHVZyyM2z4KFs",
        appId: "1:41076678914:android:14bb2dd03c56256761e21b",
        messagingSenderId: "41076678914",
        projectId: "bussbuddyapplication")
  );
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
      home: const PersonalInfoView(),
    );
  }
}
