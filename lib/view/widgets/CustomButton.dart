

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Future<void> Function()? submitForm;
  final String detail;
  final String route;
  final GlobalKey<FormState>? formKey;
  final bool shouldNavigate;
  final bool? useLoading;


  const CustomButton({
    super.key,
    this.submitForm,
    required this.detail,
    required this.route,
    this.formKey,
    this.shouldNavigate=false,
    this.useLoading

  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 43,
      child: ElevatedButton(
        onPressed:() async {
          if (shouldNavigate) {
            Navigator.pushNamed(context, route);
          } else {
            // Jika tombol digunakan untuk validasi dan submit form
            if (formKey?.currentState?.validate() ?? false) {
              if (submitForm != null) {
                try{
                  await submitForm!();
                  Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
                }catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please fill all fields correctly")),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),

          ),
        ),
        child: Text(
          detail,
          style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold

          ),
        ),
      ),
    );
  }
}
