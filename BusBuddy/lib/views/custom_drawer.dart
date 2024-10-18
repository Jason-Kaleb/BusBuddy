import 'package:busbuddy/constants/routes.dart';
import 'package:busbuddy/services/auth/user_service.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
    return Drawer(
      width: 320,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  profileRoute,
                  (route) => false,
                );
              },
              splashColor: const Color.fromARGB(255, 122, 122, 122),
              highlightColor: const Color.fromARGB(255, 122, 122, 122),
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  _userName,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                accountEmail: Text(
                  _userEmail,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                currentAccountPictureSize: const Size.square(50),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 240, 239, 239),
                  child: Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 141, 140, 140),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.payment_outlined,
                      color: Color.fromARGB(255, 0, 0, 0)),
                  title: const Text('Payment'),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.support_agent,
                      color: Color.fromARGB(255, 0, 0, 0)),
                  title: const Text('Support'),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info_outline_rounded,
                      color: Color.fromARGB(255, 0, 0, 0)),
                  title: const Text('About'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Container(
            height: 352,
            margin: const EdgeInsets.symmetric(horizontal: 0.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ],
      ),
    );
  }
}
