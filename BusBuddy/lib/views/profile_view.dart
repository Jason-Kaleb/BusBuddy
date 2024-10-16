import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFFFF4500),
                        ),
                      ),
                    ),
                  ],
                ),
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
                padding: EdgeInsets.symmetric(horizontal: 5) ,
                child: TextField(
                  
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.black, size: 28,),
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
              Column(
                children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
