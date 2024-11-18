import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oaap/authentication/ui_components/widgets/google_button.dart';
import 'package:oaap/authentication/ui_components/widgets/sign_in_up_button.dart';
import 'package:oaap/authentication/ui_components/widgets/text_button.dart';
import 'package:oaap/authentication/services/auth_service.dart';
import '../../../global/global widgets/input_field.dart';

class MySignUpPage extends StatelessWidget {
  final void Function()? onTap;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  MySignUpPage({super.key, this.onTap});

  Future<void> googleSignUp(BuildContext context) async {
    String retStr = await AuthService().signUpWithGoogle();
    String message = '';
    if (retStr == 'account already exists') {
      message = 'A profile is already associated with this account. Please sign in.';
    } else if (retStr == 'error') {
      message = 'Unexpected Error! Please try again later.';
    }

    if (retStr != 'user did not select account' && retStr != 'sign up successful'){
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ));
    }
  }

  Future<void> emailPswdSignUp(BuildContext context) async {
    if (passController.text == confirmPassController.text) {
      try {
        User? user = await AuthService().signUpWithEmailAndPassword(emailController.text, passController.text);
        
        if (user == null) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'You already have an account associated with this profile. Please sign in.'),
            duration: Duration(seconds: 3),
          ));
        }
      } on Exception catch (_) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error! Please try again later.'),
          duration: Duration(seconds: 3),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Passwords don\'t match.'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Create Account.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyInputField(
                    hintText: 'Email',
                    obscureText: false,
                    controller: emailController),
                const SizedBox(
                  height: 20,
                ),
                MyInputField(
                    hintText: 'Password',
                    obscureText: true,
                    controller: passController),
                const SizedBox(
                  height: 20,
                ),
                MyInputField(
                    hintText: 'Confirm Password',
                    obscureText: true,
                    controller: confirmPassController),
                const SizedBox(
                  height: 30,
                ),
                MySignInUpButton(
                  text: 'Sign Up',
                  onTap: () => emailPswdSignUp(context),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Divider(
                      endIndent: 8,
                    )),
                    Text('Or Sign Up With'),
                    Expanded(
                        child: Divider(
                      indent: 8,
                    ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GoogleButton(
                  onTap: () => googleSignUp(context),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Have an account? '),
                    MyTextButton(text: 'Sign In.', onTap: onTap)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
