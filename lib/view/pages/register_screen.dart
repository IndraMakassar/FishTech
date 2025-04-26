part of 'pages.dart';

// TODO: add more robust error notification
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final _formKey;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(40),
                  Image.asset(
                    "assets/Logo.png",
                    height: 240,
                  ),
                  Form(
                    key: _formKey,
                    child: OverflowBar(
                      overflowAlignment: OverflowBarAlignment.center,
                      overflowSpacing: 10,
                      children: [
                        FormFieldWidget(
                          controller: _nameController,
                          labelText: "Name",
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.name,
                          autofillHints: const [AutofillHints.name],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        FormFieldWidget(
                          controller: _emailController,
                          labelText: "Email",
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Email';
                            }
                            if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Your email format is not valid';
                            }
                            return null;
                          },
                        ),
                        FormFieldWidget(
                          controller: _passwordController,
                          labelText: "Password",
                          prefixIcon: Icons.key,
                          isPassword: true,
                          autofillHints: const [AutofillHints.newPassword],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_confirmPasswordFocusNode);
                          },
                        ),
                        FormFieldWidget(
                          controller: _confirmPasswordController,
                          labelText: "Confirm Password",
                          prefixIcon: Icons.key,
                          focusNode: _confirmPasswordFocusNode,
                          isPassword: true,
                          autofillHints: const [AutofillHints.newPassword],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please reenter your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            _submitForm();
                          },
                        ),
                        const Gap(0),
                        CustomButton(
                          text: "Register",
                          onPressed: () {
                            _submitForm();
                          },
                        ),
                      ],
                    ),
                  ),
                  const Gap(14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have an account?",
                          style: TextStyle(color: Colors.black)),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).go('/login');
                        },
                        child: Text(
                          ' Sign In',
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
          );
        },
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      context.read<AuthBloc>().add(UserSignUp(
            email: email,
            password: password,
            name: name,
          ));
    }
  }
}
