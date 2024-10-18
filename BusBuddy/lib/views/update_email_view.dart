import 'package:busbuddy/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:busbuddy/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateEmailView extends StatefulWidget {
  const UpdateEmailView({super.key});

  @override
  State<StatefulWidget> createState() => _UpdateEmailViewState();
}

class _UpdateEmailViewState extends State<UpdateEmailView> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            if (context.mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                personalRoute,
                (route) => false,
              );
            }
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Column(
                  children: <Widget>[
                    Text(
                      "Update Your Email",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Please enter your email",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: _emailController,
                      autofocus: false,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(217, 219, 219, 219),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 14.0,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(217, 219, 219, 219),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(217, 219, 219, 219),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(217, 219, 219, 219),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        labelText: "Enter your new email",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 18),
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(350, 50),
                        backgroundColor: const Color(0xFFFF4500),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        final email = _emailController.text;
                        try {
                          await AuthService().updateDisplayName(email);
                        } catch (e) {
                          Fluttertoast.showToast(
                            msg: e.toString(),
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.SNACKBAR,
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );
                        }
                      },
                      child: const Text(
                        "Update Email",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
