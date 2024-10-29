import 'package:flutter/material.dart';
import 'package:oaap/authentication/services/auth_service.dart';
import 'package:oaap/client_category_management/ui_components/my_elevated_button.dart';

class MyLogoutButton extends StatelessWidget {
  const MyLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 1.5,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text('Are you sure you want to logout?'),
                    contentPadding: const EdgeInsets.symmetric( vertical: 40, horizontal: 20),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyElevatedButton(
                              width: 80,
                              height: 40,
                              child: const Text('Cancel'),
                              onTap: () {
                                Navigator.pop(context);
                              }),
                          MyElevatedButton(
                              width: 80,
                              height: 40,
                              child: const Text('Ok'),
                              onTap: () async {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                await AuthService().signOut();
                                // ignore: use_build_context_synchronously
                                Navigator.popAndPushNamed(context, '/authGate');
                              })
                        ],
                      )
                    ],
                  );
                });
          },
          child: Ink(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.09,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: const Align(
                  alignment: Alignment.centerLeft, child: Text('Logout'))),
        ),
      ),
    );
  }
}
