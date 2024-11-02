import 'package:busbuddy/constants/routes.dart';
import 'package:busbuddy/consts.dart';
import 'package:busbuddy/services/auth/auth_service.dart';
import 'package:busbuddy/views/about_view.dart';
import 'package:busbuddy/views/card_details_view.dart';
import 'package:busbuddy/views/delete_view.dart';
import 'package:busbuddy/views/payment_view.dart';
import 'package:busbuddy/views/personal_info.dart';
import 'package:busbuddy/views/profile_view.dart';
import 'package:busbuddy/views/register_view.dart';
import 'package:busbuddy/views/reset_password_view.dart';
import 'package:busbuddy/views/support_view.dart';
import 'package:busbuddy/views/update_email_view.dart';
import 'package:busbuddy/views/update_info.dart';
import 'package:busbuddy/views/verify_email_view.dart';
import 'package:busbuddy/views/login_view.dart';
import 'package:busbuddy/views/map_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'route_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  await initializeFirebaseRoutes();
  await _setup();
  runApp(const MyApp());
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp();
}

Future<void> initializeFirebaseRoutes() async {
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  final DataSnapshot snapshot = await databaseRef.child('bus_routes/T1').get();

  if (!snapshot.exists) {
    final routeData = RouteData();
    await routeData.saveTrunk1Route();
  } else {
    print('Bus routes already exist in firebase');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bus Buddy',
      theme: ThemeData(
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
        deleteRoute: (context) => const DeleteView(),
        paymentRoute: (context) => const PaymentView(),
        cardRoute: (context) => const CardDetailsView(),
        forgotPasswordRoute: (context) => const ForgotPasswordView(),
        aboutRoute: (context) => const AboutView(),
        supportRoute: (context) => const SupportView()
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
      },
    );
  }
}
