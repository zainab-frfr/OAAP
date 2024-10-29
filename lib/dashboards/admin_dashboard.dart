import 'package:flutter/material.dart';
import 'package:oaap/dashboards/widgets/admin_action_tile.dart';
import 'widgets/my_round_appbar.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight + 20),
              child: AppBar(
                shape: const CustomAppBarShape(),
                backgroundColor: (MediaQuery.platformBrightnessOf(context) ==
                        Brightness.light)
                    ? const Color.fromARGB(255, 81, 161, 227)
                    : const Color.fromARGB(255, 38, 37, 37),
                elevation: 0,
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.sizeOf(context).height * 0.25,
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width - 40,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AdminActionTile(
                        colors: [
                        Color.fromARGB(255, 237, 231, 178),
                        Color.fromARGB(255, 157, 211, 255),
                        ], 
                        text: 'Client Category Management'
                      ),
                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.12,),
                      const AdminActionTile(
                        colors: [
                        Color.fromARGB(255, 237, 231, 178),
                        Color.fromARGB(255, 157, 211, 255),
                        ], 
                        text: 'Client Category Management'
                      )
                    ],
                  ),
                ),
              )),
              Positioned(
              top: MediaQuery.sizeOf(context).height * 0.45,
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width - 40,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AdminActionTile(
                        colors: [
                        Color.fromARGB(255, 237, 231, 178),
                        Color.fromARGB(255, 157, 211, 255),
                        ], 
                        text: 'Client Category Management'
                      ),
                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.12,),
                      const AdminActionTile(
                        colors: [
                        Color.fromARGB(255, 237, 231, 178),
                        Color.fromARGB(255, 157, 211, 255),
                        ], 
                        text: 'Client Category Management'
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
