import 'package:busbuddy/constants/routes.dart';
import 'package:busbuddy/services/auth/auth_service.dart';
<<<<<<< HEAD
import 'package:busbuddy/views/profile_view.dart';
import 'package:busbuddy/views/verify_email_view.dart';
import 'package:busbuddy/views/login_view.dart';
import 'package:busbuddy/views/map_view.dart';
import 'package:busbuddy/views/personal_info.dart';
import 'package:busbuddy/views/register_view.dart';
import 'package:busbuddy/views/update_email_view.dart';
import 'package:busbuddy/views/update_info.dart';
import 'package:busbuddy/views/delete_view.dart';
import 'package:busbuddy/views/payment_view.dart';
import 'package:flutter/material.dart';

=======
import 'package:busbuddy/views/personal_info.dart';
import 'package:busbuddy/views/profile_view.dart';
import 'package:busbuddy/views/register_view.dart';
import 'package:busbuddy/views/update_email_view.dart';
import 'package:busbuddy/views/update_info.dart';
import 'package:busbuddy/views/verify_email_view.dart';
import 'package:busbuddy/views/login_view.dart';
import 'package:busbuddy/views/map_view.dart';
import 'package:flutter/material.dart';
>>>>>>> e2152e1a0d4510ca2e72ca5ed6d256c2ee04f033

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        mapsRoute: (context) => const MapView(),
        personalRoute: (context) => const PersonalInfoView(),
        updateRoute: (context) => const UpdateInfoView(),
        updateEmailRoute: (context) => const UpdateEmailView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        profileRoute: (context) => const ProfileView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;

              if (user != null) {
                if (user.isEmailVerified) {
                  return const MapView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
