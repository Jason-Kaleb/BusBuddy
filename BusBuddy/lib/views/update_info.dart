import 'package:busbuddy/constants/routes.dart';
import 'package:busbuddy/utilities/dialogs/error_dialog.dart';
import 'package:busbuddy/utilities/dialogs/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:busbuddy/services/auth_service.dart';

class UpdateInfoView extends StatefulWidget {
  const UpdateInfoView({super.key});

  @override
  State<StatefulWidget> createState() => _UpdateInfoViewState();
}

class _UpdateInfoViewState extends State<UpdateInfoView> {
  late final TextEditingController _nameController;
  late final TextEditingController _lastNameController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
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
                      "Update Your Name",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Please enter your name as it appears on your ID or passport",
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
                      controller: _nameController,
                      autofocus: false,
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
                        labelText: "Enter your first name",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 18),
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _lastNameController,
                      autofocus: false,
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
                        labelText: "Enter your your last name",
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
                        final name = _nameController.text;
                        final lastName = _lastNameController.text;
                        final String fullName = "$name $lastName";
                        try {
                          await AuthService().updateDisplayName(fullName);

                          if (context.mounted) {
                            showSuccessDialog(
                              context,
                              "Name updated successfully",
                            );
                          }

                          _nameController.clear();
                          _lastNameController.clear();
                        } catch (e) {
                          if (context.mounted) {
                            showErrorDialog(context, "Unexpected error");
                          }
                        }
                      },
                      child: const Text(
                        "Update",
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
