import 'package:fishtech/view/pages/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:fishtech/view/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.030),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            overflowSpacing: size.height * 0.014,
            children: [
              const Text(
                "Welcome Back!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Sign in to continue",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: size.height * 0.024,
              ),
              TextField(
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 25.0),
                    filled: true,
                    hintText: "email",
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(37),
                    )),
              ),
              TextField(
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 25.0),
                    filled: true,
                    hintText: "Password",
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(37),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                      width: double.infinity,
                      height: size.height * 0.080,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(37)),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      )),
                  onPressed: () {
                    GoRouter.of(context).go('/home');
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("I'm a new user, ",
                      style: TextStyle(color: Colors.black)),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go('/register');
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
