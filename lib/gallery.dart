import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:prismsync/gallery_tile.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  final String title = 'Gallery';

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool _fetchingImagesStarted = false;
  bool _permissionChecked = false;
  final List<Widget> _galleryTiles = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
  }

  Future<void> _checkPermission(ScaffoldMessengerState messenger) async {
    if (!_permissionChecked) {
      final PermissionState ps = await PhotoManager.requestPermissionExtend();

      if (!ps.hasAccess) {
        messenger.showSnackBar(
          SnackBar(
            content: const Text(
                "Permission to access photos and videos on your device is required to use this app."),
            action: SnackBarAction(
              label: "Open Settings",
              onPressed: () {
                PhotoManager.openSetting();
              },
            ),
          ),
        );
        return;
      } else if (!ps.isAuth) {
        messenger.showSnackBar(
          SnackBar(
            content: const Text(
                "Permission to access all photos and videos on your device is recommended to use this app. For that, make sure the \"Photos and videos\" permission is set to \"Always allow all\"."),
            action: SnackBarAction(
              label: "Open Settings",
              onPressed: () {
                PhotoManager.openSetting();
              },
            ),
          ),
        );
      }
      _permissionChecked = true;
    }
  }

  Future<void> _fetchImages(ScaffoldMessengerState messenger) async {
    // TODO: caching
    // TODO: only generate when the user scrolls, otherwise the app does nothing while it's still generating things
    for (int i = 0; i < 1; i++) {
      var assets = await PhotoManager.getAssetListPaged(
          page: i,
          pageCount: await PhotoManager.getAssetCount(),
          type: RequestType.common);
      for (var asset in assets) {
        Widget galleryTile = GalleryTile(
          asset: asset,
          messenger: messenger,
        );
        setState(() {
          _galleryTiles.add(galleryTile);
        });
      }
    }

    return;
  }

  Future<void> _startFetchingImages(ScaffoldMessengerState messenger) async {
    await _checkPermission(messenger);
    if (!_permissionChecked) return;
  
    if (_fetchingImagesStarted) return;
    _fetchingImagesStarted = true;
    _fetchImages(messenger);
  }

  @override
  Widget build(BuildContext context) {
    _startFetchingImages(ScaffoldMessenger.of(context));
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (context, index) => _galleryTiles[index],
          itemCount: _galleryTiles.length,
        ));
  }
}
