import 'package:fishtech/view/pages/home_screen.dart';
import 'package:fishtech/view/pages/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Two separate ValueNotifiers for each password field
    final ValueNotifier<bool> _obscureTextPassword = ValueNotifier(true);
    final ValueNotifier<bool> _obscureTextConfirmPassword = ValueNotifier(true);

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
                "Get Started",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Sign up to continue",
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
                  hintText: "Name",
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(37),
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 25.0),
                  filled: true,
                  hintText: "Email Address",
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(37),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _obscureTextPassword,
                builder: (context, obscureText, child) {
                  return TextField(
                    obscureText: obscureText,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 25.0),
                      filled: true,
                      hintText: "Password",
                      prefixIcon: const Icon(
                        Icons.key,
                        color: Colors.black,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _obscureTextPassword.value =
                                !_obscureTextPassword.value;
                          },
                        ),
                      ),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                  );
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _obscureTextConfirmPassword,
                builder: (context, obscureText, child) {
                  return TextField(
                    obscureText: obscureText,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 25.0),
                      filled: true,
                      hintText: "Confirm Password",
                      prefixIcon: const Icon(
                        Icons.key,
                        color: Colors.black,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _obscureTextConfirmPassword.value =
                                !_obscureTextConfirmPassword.value;
                          },
                        ),
                      ),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                  );
                },
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
                          "Register",
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
                  const Text("I have an account, ",
                      style: TextStyle(color: Colors.black)),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go('/login');
                    },
                    child: const Text(
                      'Login',
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
