import '../extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'ui.dart';

showConfirmDialog(
    {required BuildContext context, required Function onConfirm, Function? onCancel}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.colorScheme.errorContainer,
          title: Text(
            "Warning!",
            style:
                TextStyle(color: context.colorScheme.onErrorContainer, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Are you sure to proceed?",
            style:
                TextStyle(color: context.colorScheme.onErrorContainer, fontWeight: FontWeight.w600),
          ),
          actions: [
            ReusableButton(
                title: "Yes",
                onTap: () {
                  onConfirm();
                  Navigator.pop(context);
                }),
            ReusableButton(title: "Cancel", onTap: onCancel ?? () => Navigator.pop(context)),
          ],
        );
      });
}
