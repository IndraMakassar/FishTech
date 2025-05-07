part of 'pages.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context
        .read<AuthBloc>()
        .state;
    if (state is AuthSuccess) {
      _nameController.text = state.session.user.userMetadata!['Display name'];
      _emailController.text = state.session.user.email!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Profile', showBackButton: true),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            GoRouter.of(context).go('/login');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blue[100],
                        child: const Icon(
                          Icons.person,
                          size: 100,
                          color: Colors.blue,
                        ),
                      ),
                      const Gap(28),
                      Form(
                        child: OverflowBar(
                          overflowAlignment: OverflowBarAlignment.center,
                          alignment: MainAxisAlignment.start,
                          overflowSpacing: 20,
                          children: [
                            FormFieldWidget(
                              controller: _emailController,
                              labelText: "Email",
                              isReadOnly: true,
                            ),
                            FormFieldWidget(
                              controller: _nameController,
                              labelText: "Name",
                            ),
                            CustomButton(
                              text: "Save",
                              onPressed: () {
                                if (state is AuthSuccess) {
                                  if (_nameController.text != state.session.user.userMetadata!['Display name']) {
                                    context.read<AuthBloc>().add(UserChangeName(
                                        newName: _nameController.text.trim()));
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
