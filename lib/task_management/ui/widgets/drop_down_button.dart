import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyDropDownButton extends StatelessWidget {
  final String valueOfFormField;
  final List<String> dropDownMenuItems;
  final ValueChanged<String> onValueChanged;

  const MyDropDownButton(
      {super.key,
      required this.valueOfFormField,
      required this.dropDownMenuItems, required this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        width: 200,
        child: DropdownButtonFormField(
          selectedItemBuilder: (context) {
          return dropDownMenuItems.map((item) {
            return Align(
              alignment: Alignment.centerLeft, // Align the text if needed
              child: SizedBox(
                width: 150,
                child: Text(
                  item,
                  overflow: TextOverflow.ellipsis, // Truncate long selected text
                  maxLines: 1, // Keep it on a single line
                ),
              ),
            );
          }).toList();
        },
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
            if (value != null) {
              onValueChanged(value);
            }
            //context.read<ThemeBloc>().add(ThemeChanged(theme: value!, context: context));
          },
        ),
      ),
    );
  }
}
