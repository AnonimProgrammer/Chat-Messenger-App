import 'package:chat_messenger_app/pages/login_page.dart';
import 'package:chat_messenger_app/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // initially show login page
  bool showLoginPage = true;

  // toggle between login and register page
  void toggleAuthPages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      // display login page
      return LoginPage(
        onTap: () => toggleAuthPages(),
      );
    } else {
      // display register page
      return RegisterPage(
        onTap: () => toggleAuthPages(),
      );
    }
  }
}
