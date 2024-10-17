import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:oaap/theme/theme_notifier.dart';
import 'package:provider/provider.dart';

class MyThemeTile extends StatelessWidget {
  const MyThemeTile({super.key});

  @override
  Widget build(BuildContext context) {
     ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Theme', style: TextStyle(fontWeight: FontWeight.bold),),
                FittedBox(
                  fit:  BoxFit.scaleDown,
                  child: SizedBox(
                    width: 120,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none
                      ),
                      enableFeedback: true,
                      value: themeNotifier.themeMode == ThemeMode.system
                        ? 'System Theme'
                        : themeNotifier.themeMode == ThemeMode.light
                            ? 'Light Theme'
                            : 'Dark Theme',
                      items: const [
                        DropdownMenuItem(value: 'System Theme' , child: Text('System Theme')),
                        DropdownMenuItem(value: 'Light Theme' , child: Text('Light Theme')),
                        DropdownMenuItem(value: 'Dark Theme' , child: Text('Dark Theme')),
                      ], 
                      onChanged: (value) {
                        switch (value) {
                          case 'System Theme':
                            themeNotifier.setTheme(ThemeMode.system);
                            break;  
                          case 'Light Theme':
                            themeNotifier.setTheme(ThemeMode.light);
                            break;  
                          case 'Dark Theme':
                            themeNotifier.setTheme(ThemeMode.dark);
                            break;  
                          default:
                        }
                      },
                    ),
                  ),
                )
              ]
            ),
        ),
        ),
    );
  }
}