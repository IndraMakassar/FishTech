
import 'package:flutter/material.dart';

class Customformfield extends StatelessWidget {
  final String question;
  final TextEditingController selectedController;
  final String hintText;
  final bool isUnit;
  final String unit;
  final bool isNumber;
  final bool isPrivate;
  final String? Function(String?)? validator;

  const Customformfield({
    super.key,
    required this.question,
    required this.selectedController,
    required this.hintText,
    this.isUnit = false,
    this.unit = "",
    this.isNumber=false,
    this.isPrivate=false,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          obscureText: isPrivate?true:false,
          controller: selectedController,
          keyboardType: isNumber?TextInputType.number:TextInputType.text,
          decoration: InputDecoration(
            suffixIcon: isUnit?
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  unit,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
              ],
            ):null,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
              ),
              borderRadius:BorderRadius.all(Radius.circular(16)) ,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w500
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.green, // Warna border saat enabled
                width: 2,          // Lebar border saat enabled
              ),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.lightGreen, // Warna border saat focus
                width: 2.5,         // Lebar border saat focus
              ),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
          ),
          validator: (value) {
            if (validator != null) {
              return validator!(value);
            }

            if (value == null || value.isEmpty) {
              return 'This field cannot be empty';
            }

            // Check if number is required
            if (isNumber && int.tryParse(value) == null) {
              return 'Please enter a valid number';
            }

            return null; // If everything is valid
          },
        ),
      ],
    );
  }
}
