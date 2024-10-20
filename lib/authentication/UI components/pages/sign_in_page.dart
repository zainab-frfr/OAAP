import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oaap/authentication/UI%20components/widgets/google_button.dart';
import 'package:oaap/authentication/UI%20components/widgets/sign_in_up_button.dart';
import 'package:oaap/authentication/UI%20components/widgets/text_button.dart';
import 'package:oaap/authentication/services/auth_service.dart';
import '../widgets/input_field.dart';

class MySignInPage extends StatelessWidget {
  final void Function()? onTap;

  final emailController = TextEditingController();
  final passController = TextEditingController();

  MySignInPage({super.key, this.onTap});

  Future<void> signIn(BuildContext context) async{
    User? user = await AuthService().signInWithGoogle();
    if(user==null){
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You do not have an account associated with this profile. Please sign up.'), 
          duration:  Duration(seconds: 3),
        )
      );
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
                const SizedBox(height: 150,),
                const Text(
                  "Welcome Back.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyInputField(
                    hintText: 'Email', 
                    obscureText: false, 
                    controller: emailController)
                ,
                const SizedBox(
                  height: 20,
                ),
                MyInputField(
                    hintText: 'Password', 
                    obscureText: true, 
                    controller: passController
                ),
                const SizedBox(
                  height: 30,
                ),
                const MySignInUpButton(text: 'Sign In'),
                const SizedBox(
                  height: 80,
                ),        
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        endIndent: 8,
                      )
                    ),
                    Text('Or Sign In With'),
                    Expanded(
                      child: Divider(
                        indent: 8,
                      )
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                GoogleButton(onTap: () => signIn(context),),
                const SizedBox(height: 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New here? '),
                    MyTextButton(text: 'Sign Up.', onTap: onTap)
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
