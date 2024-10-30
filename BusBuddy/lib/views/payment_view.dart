import 'package:busbuddy/services/auth/user_service.dart';
import 'package:busbuddy/services/payment/stripe_service.dart';
import 'package:busbuddy/utilities/dialogs/error_dialog.dart';
import 'package:busbuddy/utilities/dialogs/prompt_for_payment_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String _userName = 'Loading...';
  final UserService _userService = UserService();

  int _points = 0;

  Future<void> _loadUserData() async {
    String name = await _userService.getUserName();

    if (context.mounted) {
      setState(() {
        _userName = name;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserPoints();
    _loadUserData();
  }

  Future<void> _fetchUserPoints() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;

        final DatabaseReference ref =
            FirebaseDatabase.instance.ref('users/$uid/points');

        final DataSnapshot snapshot = await ref.get();
        if (snapshot.exists) {
          setState(() {
            _points = snapshot.value as int;
          });
        }
      }
    } catch (e) {
      print('Error fetching points: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade300,
          child: Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Text(
                          'Payment',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                    top: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bus Points',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_points Points',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ListTile(
                      leading:
                          const Icon(Icons.info_outline, color: Colors.black),
                      title: const Text('What is Bus Points?'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      const Text(
                        'Payment methods',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ListTile(
                        leading: const Icon(Icons.payments_rounded,
                            color: Colors.black),
                        title: const Text(
                          'Pay with Stripe',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        onTap: () async {
                          final int? amount =
                              await promptForPayment(context, _userName);
                          if (amount != null) {
                            StripeService.instance.makePayment(
                              merchantDisplayName: _userName,
                              amount: amount,
                            );

                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              final uid = user.uid;
                              final DatabaseReference ref = FirebaseDatabase
                                  .instance
                                  .ref('users/$uid/points');
                              await ref.set(_points);
                              user.reload();
                            }
                          } else {
                            if (context.mounted) {
                              showErrorDialog(context,
                                  "Payment was canceled or no amount was entered.");
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
