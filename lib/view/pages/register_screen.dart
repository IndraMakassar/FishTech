import 'package:fishtech/bloc/auth/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';


// TODO: add more robust error notification
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();

    // Two separate ValueNotifiers for each password field
    final ValueNotifier<bool> _obscureTextPassword = ValueNotifier(true);
    final ValueNotifier<bool> _obscureTextConfirmPassword = ValueNotifier(true);

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
                    Text("Get Started",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall),
                    Text("Sign up to continue",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall),
                    Gap(size.height * 0.01),
                    TextField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16.0),
                        hintText: "Name",
                        prefixIcon: const Icon(
                          Icons.person,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16.0),
                        hintText: "Email Address",
                        prefixIcon: const Icon(
                          Icons.email,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
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
                          controller: _passwordController,
                          obscureText: obscureText,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16.0),
                            hintText: "Password",
                            prefixIcon: const Icon(
                              Icons.key,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: IconButton(
                                icon: Icon(
                                  obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  _obscureTextPassword.value =
                                      !_obscureTextPassword.value;
                                },
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _obscureTextConfirmPassword,
                      builder: (context, obscureText, child) {
                        return TextField(
                          controller: _confirmPasswordController,
                          obscureText: obscureText,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16.0),
                            hintText: "Confirm Password",
                            prefixIcon: const Icon(
                              Icons.key,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: IconButton(
                                icon: Icon(
                                  obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  _obscureTextConfirmPassword.value =
                                      !_obscureTextConfirmPassword.value;
                                },
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        );
                      },
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
                              "Register",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      onPressed: () {
                        if (_passwordController.text.trim() ==
                            _confirmPasswordController.text.trim()) {
                          String name = _nameController.text.trim();
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();
                          context.read<AuthBloc>().add(UserSignUp(
                                email: email,
                                password: password,
                                name: name,
                              ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Password and confirm password is not the same!')));
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("I have an account, ",
                            style: TextStyle(color: Colors.black)),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).go('/login');
                          },
                          child: Text(
                            'Login',
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
            ),
          );
        },
      ),
    );
  }
}
