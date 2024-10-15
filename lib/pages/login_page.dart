import 'package:chat_messenger_app/components/my_button.dart';
import 'package:chat_messenger_app/components/my_textfield.dart';
import 'package:chat_messenger_app/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  // email Text Controller
  final TextEditingController emailTextController = TextEditingController();

  // password Text Controller
  final TextEditingController passwordTextController = TextEditingController();

  // log in method
  void login(BuildContext context) {
    // auth service
    final authService = AuthService();

    // try login
    try {
      authService.signInWithEmailAndPassword(
        emailTextController.text,
        passwordTextController.text,
      );
    }
    // catch any errors
    on FirebaseAuthException catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(error.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Messenger App logo
            Image.asset(
              './lib/images/messenger.png',
              height: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 50),

            // Welcome back, you've been missed !
            Text(
              'Welcome back, you\'ve been missed!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 35),

            // Email textfield
            MyTextfield(
              textController: emailTextController,
              hintText: 'Email',
              obscureText: false,
            ),

            const SizedBox(height: 10),
            // Password textfield
            MyTextfield(
              textController: passwordTextController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 10),
            // Forgot Password ?
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Login button
            const SizedBox(height: 35),
            MyButton(
              buttonText: 'Login',
              onTap: () => login(context),
            ),

            const SizedBox(height: 50),
            // Not a member? + Register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'Register now',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
