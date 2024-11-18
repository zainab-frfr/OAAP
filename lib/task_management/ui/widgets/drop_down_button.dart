import 'package:flutter/material.dart';

class MyDropDownButton extends StatelessWidget {
  final String valueOfFormField;
  final List<String> dropDownMenuItems;

  const MyDropDownButton(
      {super.key,
      required this.valueOfFormField,
      required this.dropDownMenuItems});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        width: 200,
        child: DropdownButtonFormField(
          isDense: true,
          decoration: const InputDecoration(border: InputBorder.none),
          enableFeedback: true,
          value: valueOfFormField,
          items: dropDownMenuItems
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            //context.read<ThemeBloc>().add(ThemeChanged(theme: value!, context: context));
          },
        ),
      ),
    );
  }
}
