import 'package:flutter/material.dart';

void showLoadingOverlay(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const PopScope(
      canPop: false,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

void hideLoadingOverlay(BuildContext context) {
  Navigator.pop(context);
}

void showSnackBar({
  required BuildContext context,
  required String text,
  SnackBarAction? action,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      action: action,
    ),
  );
}

bool showSnackBarOnError(BuildContext context, String? error) {
  if (error != null) {
    showSnackBar(
      context: context,
      text: error,
    );
    return true;
  }
  return false;
}
