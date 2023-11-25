import 'package:flutter/material.dart';

final List<Shadow> _iconShadowsList = [];

List<Shadow> getIconShadows() {
  if (_iconShadowsList.isEmpty) {
    for (var boxShadow in kElevationToShadow[1]!) {
      _iconShadowsList.add(
        Shadow(
          blurRadius: boxShadow.blurRadius,
          offset: boxShadow.offset,
          color: boxShadow.color,
        ),
      );
    }
  }
  return _iconShadowsList;
}
