import 'package:fishtech/bloc/auth/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            GoRouter.of(context).go('/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Center(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: OverflowBar(
                overflowAlignment: OverflowBarAlignment.center,
                overflowSpacing: size.height * 0.01,
                children: [
                  Text(
                    "Welcome Back!!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    "Sign in to continue",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Gap(size.height * 0.01),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16.0),
                        hintText: "Email",
                        prefixIcon: const Icon(
                          Icons.person,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                  ),
                  TextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16.0),
                        hintText: "Password",
                        prefixIcon: const Icon(
                          Icons.key,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                  ),
                  Gap(size.height * 0.0005),
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      onPressed: () {
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();

                        context
                            .read<AuthBloc>()
                            .add(UserSignIn(email: email, password: password));
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
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
