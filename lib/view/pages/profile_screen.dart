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
      final state = context.read<AuthBloc>().state;
      if (state is AuthAuthenticated) {
        // Try Google login name first, then fallback to email login name
        _nameController.text = state.session.user.userMetadata?['name'] ??
                            state.session.user.userMetadata?['Display name'] ??
                            'User';
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
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.blue[100],
                            child: state is AuthAuthenticated
                              ? ClipOval(
                                  child: Image.network(
                                    state.session.user.userMetadata?['picture'] ?? // Google login avatar
                                    state.session.user.userMetadata?['avatar_url'] ?? // Alternative Google login avatar
                                    'https://ui-avatars.com/api/?name=${_nameController.text}', // Fallback to generated avatar
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 120,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.person,
                                        size: 100,
                                        color: Colors.blue,
                                      );
                                    },
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                )
                              : const Icon(
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
                                  isLoading: state is AuthLoading &&
                                      (state).loadingType == AuthLoadingType.profile,
                                  onPressed: () {
                                    if (state is AuthAuthenticated) {
                                      final currentName = state.session.user.userMetadata?['name'] ??
                                        state.session.user.userMetadata?['Display name'];
                                      if (_nameController.text != currentName) {
                                        context.read<AuthBloc>().add(
                                          UserChangeName(newName: _nameController.text.trim())
                                        );
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Gap(30),
                          CustomButton(
                            text: 'Logout',
                            backgroundColor: Theme.of(context).colorScheme.error,
                            onPressed: () {
                              context.read<AuthBloc>().add(UserSignOut());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }