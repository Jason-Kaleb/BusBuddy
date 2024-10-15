import 'package:busbuddy/constants/routes.dart';
import 'package:flutter/material.dart';

class GetStartedView extends StatefulWidget {
  const GetStartedView({super.key});

  @override
  State<GetStartedView> createState() => _GetStartedViewState();
}

class _GetStartedViewState extends State<GetStartedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/JzTrackr.png"),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 16.0),
              child: Text(
                "FIND YOUR BUS WITH US",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              "With Us, You can track your bus at any given time.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 70.0),
          ],
        ),
        Positioned(
          bottom: 70.0,
          left: 83.0,
          child: ElevatedButton(
            onPressed: () {
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(250, 60),
              backgroundColor: const Color(0xFFFF4500),
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'GET STARTED',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ]),
    );
  }
}
