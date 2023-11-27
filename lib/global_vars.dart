import 'package:flutter/material.dart';

class GlobalVariables {
  static String? baseUrl;
  static bool inPublicMode = false;
  static String? sessionId;
  static final List<Shadow> iconShadowsList = [];
}

List<Shadow> getIconShadows() {
  if (GlobalVariables.iconShadowsList.isEmpty) {
    for (var boxShadow in kElevationToShadow[1]!) {
      GlobalVariables.iconShadowsList.add(
        Shadow(
          blurRadius: boxShadow.blurRadius,
          offset: boxShadow.offset,
          color: boxShadow.color,
        ),
      );
    }
  }
  return GlobalVariables.iconShadowsList;
}
