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
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  profileRoute,
                  (route) => false,
                );
              },
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  _userName,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                accountEmail: Text(
                  _userEmail,
                  style: const TextStyle(
                    fontSize: 12,
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
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.grey),
            title: const Text('Points'),
            onTap: () {
              // Handle Points tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.support_agent, color: Colors.grey),
            title: const Text('Support'),
            onTap: () {
              // Handle Support tap
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info_outline_rounded,
              color: Colors.grey,
            ),
            title: const Text('About'),
            onTap: () {
              // Handle About tap
            },
          ),
        ],
      ),
    );
  }
}


// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: const [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(30),
//               ),
//             ),
//             child: UserAccountsDrawerHeader(
//               accountName: Text(
//                 "Gojo",
//                 style: TextStyle(
//                   fontSize: 17,
//                   color: Colors.black,
//                 ),
//               ),
//               accountEmail: Text(
//                 "Satori@gmail.com",
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.black,
//                 ),
//               ),
//               currentAccountPictureSize: Size.square(50),
//               currentAccountPicture: CircleAvatar(
//                 backgroundColor: Color.fromARGB(255, 240, 239, 239),
//                 child: Icon(
//                   Icons.person,
//                   color: Color.fromARGB(255, 141, 140, 140),
//                 ),
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ListTile(
//             title: Text('Testing 1'),
//           ),
//           Divider(
//             thickness: 2,
//           ),
//           ListTile(
//             title: Text('Testing 22'),
//           ),
//           Divider(
//             thickness: 2,
//           ),
//           ListTile(
//             title: Text('Testing 3'),
//           ),
//           Divider(
//             thickness: 2,
//           ),
//         ],
//       ),
//     );
//   }
// }
