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

  Future<void> _loadUserData() async{
    _user = FirebaseAuth.instance.currentUser;

    if(_user != null){
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
      // appBar: AppBar(
      //   leading: const BackButton(
      //     color: Colors.black,
      //     onPressed: null,
      //   ),
      // ),
      body: Stack(
        children: <Widget>[
          Positioned(
              top: -100.0,  // Adjust these values to move the image outside the SafeArea
              left: -125.0, // Adjust left positioning
              child: Image.asset(
                "assets/images/Circles.png", // Replace with your image path
                width: 300,  // Adjust image width
                height: 300, // Adjust image height
              ),
            ), 
          SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                 color: Colors.black,
                  size: 35,
                  ),
              onPressed: () {},
              color: Colors.black,
              
             
            ),
          ),
                  const Column(
                  children: <Widget>[
                    Text(
                      'Personal Info',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold                 
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 14.0,
                      ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        suffix: TextButton(
                        onPressed: () {},
                        child:  const Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          )
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                      hintText: "Email",
                      contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 14.0,
                      ),
                        prefixIcon:const  Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        suffix: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                 
              ],
              ),
            ),
          ),
          ),
      ],
      ),
    );
  }
}