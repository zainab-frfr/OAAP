import 'package:flutter/material.dart';
import 'package:oaap/settings/bloc/theme_bloc.dart';
import 'package:provider/provider.dart';

class MyThemeTile extends StatelessWidget {
  const MyThemeTile({super.key});

  @override
  Widget build(BuildContext context) {
    String valueOfFormField = context.select((ThemeBloc bloc) => bloc.state.themeString);
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 1.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Theme',),
                FittedBox(
                  fit:  BoxFit.scaleDown,
                  child: SizedBox(
                    width: 200,
                    child: DropdownButtonFormField(
                      isDense: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none
                      ),
                      enableFeedback: true,
                      value: valueOfFormField,
                      items: const [
                        DropdownMenuItem(value: 'System Theme' , child: Text('System Theme', overflow: TextOverflow.ellipsis,)),
                        DropdownMenuItem(value: 'Light Theme' , child: Text('Light Theme', overflow: TextOverflow.ellipsis,)),
                        DropdownMenuItem(value: 'Dark Theme' , child: Text('Dark Theme', overflow: TextOverflow.ellipsis,)),
                      ], 
                      onChanged: (value) {
                        context.read<ThemeBloc>().add(ThemeChanged(theme: value!, context: context));
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