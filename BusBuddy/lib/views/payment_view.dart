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
    _startPointsListener();
  }

  void _startPointsListener() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      DatabaseReference ref =
          FirebaseDatabase.instance.ref('users/$uid/points');
      ref.onValue.listen((event) {
        final int? updatedPoints = event.snapshot.value as int?;
        if (updatedPoints != null) {
          setState(() {
            _points = updatedPoints;
          });
        }
      });
    }
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFF4500),
        title: const Text('Payment', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPointsCard(),
            const SizedBox(height: 16),
            _buildPaymentMethods(),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFF4500).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bus Points',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF4500),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$_points Points',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF4500),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Welcome, $_userName!',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // Implement 'What is Bus Points?' functionality
            },
            icon: const Icon(Icons.info_outline, size: 18),
            label: const Text('What is Bus Points?'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFFF4500),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 16),
            child: Text(
              'Payment Methods',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF4500),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFF4500).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.payment, color: Color(0xFFFF4500), size: 24),
              ),
              title: const Text(
                'Pay with Stripe',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFF4500)),
              ),
              subtitle: const Text('Add a new payment method', style: TextStyle(color: Colors.black87)),
              trailing: const Icon(Icons.chevron_right, color: Color(0xFFFF4500)),
              onTap: _handleStripePayment,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleStripePayment() async {
    final int? amount = await promptForPayment(context, _userName);
    if (amount != null) {
      try {
        await StripeService.instance.makePayment(
          merchantDisplayName: "Bus Buddy Points",
          amount: amount,
        );

        setState(() {
          _points += amount;
        });

        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final uid = user.uid;
          final DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid/points');
          await ref.set(_points);
          print("Payment successful");
        }
      } catch (e) {
        if (mounted) {
          showErrorDialog(context, "An error occurred during payment: ${e.toString()}");
        }
      }
    } else {
      if (mounted) {
        showErrorDialog(context, "Payment was canceled or no amount was entered.");
      }
    }
  }
}