import 'package:chat_messenger_app/components/my_button.dart';
import 'package:chat_messenger_app/components/my_textfield.dart';
import 'package:chat_messenger_app/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  // email Text Controller
  final TextEditingController emailTextController = TextEditingController();
  // password Text Controller
  final TextEditingController passwordTextController = TextEditingController();
  // confirm password Text Controller
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  // register method
  void register(BuildContext context) {
    // auth service
    final authService = AuthService();

    // try sign up
    // passwords match -> create user
    if (passwordTextController.text == confirmPasswordTextController.text) {
      try {
        authService.signUpWithEmailAndPassword(
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
    // passwords don't match ->  display error
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Passwords don\'t match!'),
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

            // Let's create an account for you!
            Text(
              'Let\'s create an account for you!',
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
            // Confirm password textfield
            MyTextfield(
              textController: confirmPasswordTextController,
              hintText: 'Confirm password',
              obscureText: true,
            ),

            // Sign Up button
            const SizedBox(height: 35),
            MyButton(
              buttonText: 'Sign Up',
              onTap: () => register(context),
            ),

            const SizedBox(height: 50),
            // Already have an account? + Login now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
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
                    'Login now',
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
