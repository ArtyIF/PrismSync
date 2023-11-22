import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  final String title = 'Gallery';

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 150,
        children: [
          for (var i = 1; i <= 7; i++)
            FadeInImage(
              placeholder: const AssetImage('images/loading.png'),
              image: AssetImage('images/$i.jpg'),
              fit: BoxFit.cover,
            )
        ],
      ),
    );
  }
}
