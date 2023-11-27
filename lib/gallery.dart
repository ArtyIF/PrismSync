import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:prismsync/gallery_tile.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final List<Widget> _galleryTiles = List.empty(growable: true);
  // https://stackoverflow.com/questions/68520264/simple-grid-gallery-with-photo-manager
  int _currentPage = 0;
  bool _fetchingImages = false;

  @override
  void initState() {
    super.initState();
    _checkPermissionThenFetchImages();
  }

  void _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels >= scroll.metrics.maxScrollExtent - 1000) {
      if (!_fetchingImages) {
        _fetchImages();
      }
    }
  }

  Future<bool> _checkPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();

    if (!ps.hasAccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Permission to access photos and videos on your device is required to use this app.'),
          action: SnackBarAction(
            label: 'Open Settings',
            onPressed: () {
              PhotoManager.openSetting();
            },
          ),
        ),
      );
      return false;
    } else if (!ps.isAuth) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Permission to access all photos and videos on your device is recommended to use this app. For that, make sure the "Photos and videos" permission is set to "Always allow all".'),
          action: SnackBarAction(
            label: 'Open Settings',
            onPressed: () {
              PhotoManager.openSetting();
            },
          ),
        ),
      );
    }

    return true;
  }

  Future<void> _fetchImages() async {
    _fetchingImages = true;

    // TODO: caching
    var assets = await PhotoManager.getAssetListPaged(
      page: _currentPage,
      pageCount: 30,
      type: RequestType.common,
    );
    for (var asset in assets) {
      Widget galleryTile = GalleryTile(
        asset: asset,
      );
      _galleryTiles.add(galleryTile);
    }
    setState(() {
      _currentPage++;
      _fetchingImages = false;
    });
  }

  Future<void> _checkPermissionThenFetchImages() async {
    if (await _checkPermission()) {
      _fetchImages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: NotificationListener<ScrollNotification>(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (context, index) => _galleryTiles[index],
          itemCount: _galleryTiles.length,
        ),
        onNotification: (scroll) {
          _handleScrollEvent(scroll);
          return false;
        },
      ),
    );
  }
}
