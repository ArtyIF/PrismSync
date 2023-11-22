import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'gallery.dart';

void main() {
  runApp(const PrismSyncApp());
}

class PrismSyncApp extends StatelessWidget {
  const PrismSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = const ColorScheme.light();
          darkColorScheme = const ColorScheme.dark();
        }

        return MaterialApp(
          theme: ThemeData(
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
          ),
          title: 'PrismSync',
          home: const GalleryPage(),
        );
      },
    );
  }
}
