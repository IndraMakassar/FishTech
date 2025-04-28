import 'package:fishtech/view/widgets/custom_button.dart';
import 'package:fishtech/view/widgets/custom_text_form_field.dart';
import 'package:fishtech/view/widgets/header.dart';
import 'package:flutter/material.dart';

class AddMachineScreen extends StatefulWidget {
  const AddMachineScreen({super.key});

  @override
  State<AddMachineScreen> createState() => _AddMachineScreenState();
}

class _AddMachineScreenState extends State<AddMachineScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: "Add Sensor"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: OverflowBar(
                overflowAlignment: OverflowBarAlignment.center,
                overflowSpacing: 10,
                children: [
                  FormFieldWidget(
                    controller: _nameController,
                    title: "Sensor Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your sensor name";
                      }
                      return null;
                    },
                  ),
                  CustomButton(text: "Add", onPressed: () {
                    _submitForm();
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _submitForm() {}

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
