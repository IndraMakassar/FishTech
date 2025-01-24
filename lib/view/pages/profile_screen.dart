import 'package:fishtech/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fishtech/theme.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = "";

  void _editName(BuildContext context) async {
    final newName = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNamePage(currentName: _name),
      ),
    );

    if (newName != null) {
      setState(() {
        _name = newName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = MaterialTheme.lightScheme();
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
      ),
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
          return Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue[100],
                      child: const Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      state is AuthSuccess ? state.session.user.userMetadata!['Display name'] as String : "halo",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      state is AuthSuccess ? state.session.user.email! : "halo",
                      style: const TextStyle(fontSize: 16,),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(UserSignOut());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                        "Logout", style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class EditNamePage extends StatelessWidget {
  final String currentName;

  EditNamePage({required this.currentName});

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = MaterialTheme.lightScheme();
    _nameController.text = currentName;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text("Edit Name"),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty) {
                    Navigator.pop(context, _nameController.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Name cannot be empty")),
                    );
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}