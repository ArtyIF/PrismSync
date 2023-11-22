import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  final String title = 'Gallery';

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  Future<void> _checkPermission(ScaffoldMessengerState messenger) async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
    } else if (ps.hasAccess) {
      final snackBar = SnackBar(
          content: const Text(
              "Permission to access all photos and videos on your device is recommended to use this app. For that, make sure the \"Photos and videos\" permission is set to \"Always allow all\"."),
          action: SnackBarAction(
              label: "Open Settings",
              onPressed: () {
                PhotoManager.openSetting();
              }));
      messenger.showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
          content: const Text(
               "Permission to access photos and videos on your device is required to use this app."),
          action: SnackBarAction(
              label: "Open Settings",
              onPressed: () {
                PhotoManager.openSetting();
              }));
      messenger.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: _checkPermission(ScaffoldMessenger.of(context)),
          builder: (context, snapshot) {
            return GridView.extent(
              maxCrossAxisExtent: 150,
              children: [
                for (var i = 1; i <= 7; i++)
                  FadeInImage(
                    placeholder: const AssetImage('images/loading.png'),
                    image: AssetImage('images/$i.jpg'),
                    fit: BoxFit.cover,
                  )
              ],
            );
          }),
    );
  }
}
