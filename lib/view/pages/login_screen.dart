part of 'pages.dart';

// TODO: add more robust error notification
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
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
                      alignment: MainAxisAlignment.start,
                      overflowSpacing: 10,
                      children: [
                        FormFieldWidget(
                          controller: _emailController,
                          labelText: "Email",
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
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
                          autofillHints: const [AutofillHints.password],
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
                            _submitForm();
                          },
                        ),
                        const Gap(0),
                        CustomButton(
                          text: "Login",
                          isLoading: state is AuthLoading,
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
                      Text(
                        "Dont have an account?",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push('/register');
                        },
                        child: Text(
                          ' Sign Up',
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
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      context
          .read<AuthBloc>()
          .add(UserSignIn(email: email, password: password));
    }
  }
}
