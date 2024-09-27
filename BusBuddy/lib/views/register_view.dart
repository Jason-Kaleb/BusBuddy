import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50.0),
              const Text(
                'Welcome Onboard',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 30.0),
              const Text(
                'Fill in the below in order to Register',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 52.0),
              SizedBox(
                width: 350,
                child: TextField(
                  enableSuggestions: false,
                  autocorrect: false,
                  autofocus: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(217, 219, 219, 219),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 14.0,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    labelText: 'Enter your full name',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: 350,
                child: TextField(
                  autofocus: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(217, 219, 219, 219),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 14.0,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    labelText: 'Enter your email',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: 350,
                child: TextField(
                  autofocus: false,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(217, 219, 219, 219),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 14.0,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    labelText: 'Enter your password',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: 350,
                child: TextField(
                  autofocus: false,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(217, 219, 219, 219),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 14.0,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(217, 219, 219, 219),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    labelText: 'Confirm password',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
              TextButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(350, 50),
                  backgroundColor: const Color(0xFFFF4500),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'REGISTER',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 30.0),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Already have an Account, Login Here!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
