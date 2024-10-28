import 'package:flutter/material.dart';

void showCircleProgressIndicator(BuildContext context){
    showDialog(
      useRootNavigator: true,
      context: context,
      barrierDismissible: false, // to prevent dialog from closing manually
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
