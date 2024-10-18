import 'package:flutter/material.dart';
import 'input_field.dart';

class MySignInPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  MySignInPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const MyLogo(
          //   lineSize: 18,
          //   textSize: 15,
          // ),
          const Text(
            "Sign in",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 30,
          ),
          //const MyTextfieldHeading(heading: 'Email'),
          MyInputField(
              hintText: '', obscureText: false, controller: emailController),
          const SizedBox(
            height: 20,
          ),
          //const MyTextfieldHeading(heading: 'Password'),
          MyInputField(
              hintText: '', obscureText: true, controller: passController),
          // MyTextButton(
          //   text: 'Forgot your password?',
          //   onTap: () {},
          //   bgColor: Colors.transparent,
          //   textColor: Colors.grey,
          // ),
          const SizedBox(
            height: 30,
          ),
          // MyContainerButton(
          //   text: 'SIGN IN',
          //   onTap: () => signIn(context),
          // ),
          // MyTextButton(
          //   text: 'Create Account.',
          //   onTap: onTap,
          //   bgColor: Colors.transparent,
          //   textColor: Colors.grey,
          // ),
        ],
      ),
    );
  }
}