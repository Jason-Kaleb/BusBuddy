import 'package:busbuddy/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({super.key});

  @override
  _PersonalInfoViewState createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  User? _user;

  Future<void> _loadUserData() async {
    _user = FirebaseAuth.instance.currentUser;

    if (_user != null) {
      _nameController.text = _user!.displayName ?? 'No Name';
      _emailController.text = _user!.email ?? 'No Email';
    }
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _loadUserData();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Color(0xFFFF4500)),
          onPressed: () => Navigator.of(context).pushNamed(profileRoute),
        ),
        title: const Text(
          'Personal Info',
          style:
              TextStyle(color: Color(0xFFFF4500), fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xFFFFF0E6),
              child: Text(
                _nameController.text.isNotEmpty
                    ? _nameController.text[0].toUpperCase()
                    : '?',
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF4500)),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: const Color(0xFFFFF0E6),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildInfoField(
                        icon: Icons.person,
                        label: 'Name',
                        value: _nameController.text,
                        onEdit: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            updateRoute,
                            (route) => false,
                          );
                        },
                      ),
                      const Divider(color: Colors.black26),
                      _buildInfoField(
                        icon: Icons.email,
                        label: 'Email',
                        value: _emailController.text,
                        onEdit: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            updateEmailRoute,
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onEdit,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFF4500)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                        const TextStyle(fontSize: 14, color: Colors.black54)),
                const SizedBox(height: 4),
                Text(value,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFFFF4500)),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}
