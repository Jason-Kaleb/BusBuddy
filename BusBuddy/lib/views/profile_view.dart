import 'package:busbuddy/constants/routes.dart';
import 'package:busbuddy/services/auth/auth_service.dart';
import 'package:busbuddy/services/auth/user_service.dart';
import 'package:busbuddy/utilities/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String _userName = 'Loading...';
  String _userEmail = 'Loading...';
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String name = await _userService.getUserName();
    String email = await _userService.getUserEmail();

    if (context.mounted) {
      setState(() {
        _userName = name;
        _userEmail = email;
      });
    }
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
          onPressed: () {
            if (context.mounted) {
              Navigator.of(context).pushNamed(
                mapsRoute,
              );
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(personalRoute);
            },
            child: const Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF4500),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 60.0,
                backgroundColor: const Color(0xFFFFF0E6),
                child: Text(
                  _userName.isNotEmpty ? _userName[0].toUpperCase() : '?',
                  style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF4500)),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _userName,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _userEmail,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 40),
              _buildProfileOption(
                icon: Icons.person,
                title: 'Personal Information',
                onTap: () {
                  Navigator.of(context).pushNamed(personalRoute);
                },
              ),
              _buildProfileOption(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () async {
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (_) => false,
                      );
                    }
                  }
                },
              ),
              _buildProfileOption(
                icon: Icons.delete,
                title: 'Delete Account',
                onTap: () {
                  Navigator.of(context).pushNamed(deleteRoute);
                },
                isDestructive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isDestructive ? Colors.red[50] : const Color(0xFFFFF0E6),
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon,
            color: isDestructive ? Colors.red : const Color(0xFFFF4500)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: isDestructive ? Colors.red : Colors.black,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.black54),
        onTap: onTap,
      ),
    );
  }
}
