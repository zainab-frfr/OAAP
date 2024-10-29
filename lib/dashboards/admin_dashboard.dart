import 'package:flutter/material.dart';
import 'package:oaap/dashboards/widgets/admin_action_tile.dart';
import 'widgets/my_round_appbar.dart';

// ignore: must_be_immutable
class AdminDashboard extends StatelessWidget {
  AdminDashboard({super.key});

  List<Color> colorsLight = [const Color.fromARGB(255, 208, 234, 255),const Color.fromARGB(255, 157, 211, 255),];
  List<Color> colorsDark =  [ const Color.fromARGB(255, 103, 102, 102), const Color.fromARGB(255, 59, 59, 59)];


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
                backgroundColor: (MediaQuery.platformBrightnessOf(context) ==Brightness.light)
                    ? const Color.fromARGB(255, 81, 161, 227)
                    : const Color.fromARGB(255, 38, 37, 37),
                elevation: 0,
              ),
            ),
          ),
            Positioned(
            top: MediaQuery.sizeOf(context).height *0.15,
            left:  MediaQuery.sizeOf(context).width *0.15,
            child: const Text(
              'Admin Dashboard', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
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
                      AdminActionTile(
                        onTap: (){},
                        colors: (MediaQuery.platformBrightnessOf(context) == Brightness.light)
                        ? colorsLight
                        : colorsDark,
                        text: 'All Tasks'
                      ),
                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.12,),
                      AdminActionTile(
                        onTap: (){},
                        colors:(MediaQuery.platformBrightnessOf(context) == Brightness.light)
                        ? colorsLight
                        : colorsDark,
                        text: 'Access Management'
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
                      AdminActionTile(
                        onTap: (){},
                        colors: (MediaQuery.platformBrightnessOf(context) == Brightness.light)
                        ? colorsLight
                        : colorsDark,
                        text: 'Moderator Management'
                      ),
                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.12,),
                      AdminActionTile(
                        onTap: (){
                          Navigator.pushNamed(context, '/clientCategoryManagement');
                        },
                        colors: (MediaQuery.platformBrightnessOf(context) == Brightness.light)
                        ? colorsLight
                        : colorsDark,
                        text: 'Client Category Management'
                      )
                    ],
                  ),
                ),
              )),
              Positioned(
              top: MediaQuery.sizeOf(context).height * 0.65,
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width - 40,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AdminActionTile(
                        onTap: (){},
                        colors: (MediaQuery.platformBrightnessOf(context) == Brightness.light)
                        ? colorsLight
                        : colorsDark,
                        text: 'Performance Reports'
                      ),
                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.12,),
                      AdminActionTile(
                        onTap: (){
                          Navigator.pushNamed(context, '/settings');
                        },
                        colors:(MediaQuery.platformBrightnessOf(context) == Brightness.light)
                        ? colorsLight
                        : colorsDark,
                        text: 'Settings'
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
