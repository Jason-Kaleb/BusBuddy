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
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade300,
          child: Column(
            children: <Widget>[
<<<<<<< HEAD
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(35),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                          onPressed: () {},
=======
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          mapsRoute,
                          (route) => false,
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(personalRoute);
                      },
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFFFF4500),
>>>>>>> e2152e1a0d4510ca2e72ca5ed6d256c2ee04f033
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF4500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Satoro Gojo",
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Colors.black, size: 28),
                          labelText: "SomeonesEmail@gmail.com",
                          labelStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none,
                        ),
                        enabled: false,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
<<<<<<< HEAD
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 50.0),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.black, size: 30),
                        title: const Text(
                          "Logout",
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                        onTap: () {},
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1.0,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete, color: Colors.black, size: 30),
                        title: const Text(
                          "Delete account",
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
=======
              const SizedBox(height: 40),
              const CircleAvatar(
                radius: 50.0,
                backgroundColor: Color.fromARGB(255, 240, 239, 239),
                child: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 141, 140, 140),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _userName,
                style: const TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 50.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.black,
                      size: 28,
                    ),
                    labelText: _userEmail,
                    labelStyle: const TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                  enabled: false,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
              ),
              Column(
                children: [
                  ListTile(
                    leading:
                        const Icon(Icons.logout, color: Colors.black, size: 30),
                    title: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.delete, color: Colors.black, size: 30),
                    title: const Text(
                      "Delete account",
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                    onTap: () {},
                  ),
                ],
>>>>>>> e2152e1a0d4510ca2e72ca5ed6d256c2ee04f033
              ),
            ],
          ),
        ),
      ),
    );
  }
}
