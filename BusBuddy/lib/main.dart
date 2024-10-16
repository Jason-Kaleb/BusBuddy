<<<<<<< HEAD
import 'package:busbuddy/views/custom_drawer.dart';
=======
import 'package:busbuddy/views/get_started_view.dart';
import 'package:busbuddy/views/login_view.dart';
import 'package:busbuddy/views/map_view.dart';
import 'package:busbuddy/views/personal_info.dart';
import 'package:busbuddy/views/register_view.dart';

import 'package:busbuddy/views/update_email_view.dart';
import 'package:busbuddy/views/update_info.dart';
>>>>>>> 9edad95ab39b502cf7cf460c2975eaf1722b6a33
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'constants/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCuNCDLYnaI0slMvJ-ioEaHVZyyM2z4KFs",
          appId: "1:41076678914:android:14bb2dd03c56256761e21b",
          messagingSenderId: "41076678914",
          projectId: "bussbuddyapplication"));
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
<<<<<<< HEAD
      home: const CustomDrawer(),
=======
      home: const GetStartedView(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        mapsRoute: (context) => const MapView(),
        personalRoute: (context) => const PersonalInfoView(),
        updateRoute: (context) => const UpdateInfoView(),
        updateEmailRoute: (context) => const UpdateEmailView(),
      },
>>>>>>> 9edad95ab39b502cf7cf460c2975eaf1722b6a33
    );
  }
}
