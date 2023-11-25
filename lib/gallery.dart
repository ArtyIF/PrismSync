import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:prismsync/gallery_tile.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool _fetchingImagesStarted = false;
  bool _permissionChecked = false;
  final List<Widget> _galleryTiles = List.empty(growable: true);
  // https://stackoverflow.com/questions/68520264/simple-grid-gallery-with-photo-manager
  int _currentPage = 0;
  int _lastPage = 0;

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  void _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (_currentPage != _lastPage) {
        _fetchImages();
      }
    }
  }

  Future<void> _checkPermission() async {
    if (!_permissionChecked) {
      final PermissionState ps = await PhotoManager.requestPermissionExtend();

      if (!ps.hasAccess) {
        ScaffoldMessenger.of(context).showSnackBar(
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
        ScaffoldMessenger.of(context).showSnackBar(
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

  Future<void> _fetchImages() async {
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
        );
        setState(() {
          _galleryTiles.add(galleryTile);
        });
      }
    }

    return;
  }

  Future<void> _startFetchingImages() async {
    await _checkPermission();
    if (!_permissionChecked) return;

    if (_fetchingImagesStarted) return;
    _fetchingImagesStarted = true;
    _fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    _startFetchingImages();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gallery'),
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
