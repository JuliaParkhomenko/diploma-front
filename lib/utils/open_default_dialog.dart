import 'package:flutter/material.dart';

Future<bool> openDefaultDialog(Widget dialog, BuildContext context) async {
  return await showDialog(
    useRootNavigator: true,
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: dialog,
      );
    },
  );
}
