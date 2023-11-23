import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  final String title = 'Gallery';

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool _fetchingImagesStarted = false;
  bool _permissionChecked = false;
  final List<Widget> _imageWidgets = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
  }

  Future<void> _checkPermission(ScaffoldMessengerState messenger) async {
    if (!_permissionChecked) {
      final PermissionState ps = await PhotoManager.requestPermissionExtend();

      if (!ps.hasAccess) {
        final snackBar = SnackBar(
          content: const Text(
              "Permission to access photos and videos on your device is required to use this app."),
          action: SnackBarAction(
            label: "Open Settings",
            onPressed: () {
              PhotoManager.openSetting();
            },
          ),
        );
        messenger.showSnackBar(snackBar);
      } else if (!ps.isAuth) {
        final snackBar = SnackBar(
          content: const Text(
              "Permission to access all photos and videos on your device is recommended to use this app. For that, make sure the \"Photos and videos\" permission is set to \"Always allow all\"."),
          action: SnackBarAction(
            label: "Open Settings",
            onPressed: () {
              PhotoManager.openSetting();
            },
          ),
        );
        messenger.showSnackBar(snackBar);
      }
      _permissionChecked = true;
    }
  }

  Future<void> _fetchImages(ScaffoldMessengerState messenger) async {
    // TODO: caching
    for (int i = 0;
        i < ((await PhotoManager.getAssetCount()) / 60).ceil();
        i++) {
      var assets = await PhotoManager.getAssetListPaged(
          page: i, pageCount: 60, type: RequestType.common);
      List<Widget> imageWidgets = List.empty(growable: true);
      for (var asset in assets) {
        Widget imagePreview = FutureBuilder(
          future: asset.thumbnailDataWithSize(const ThumbnailSize.square(256)),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FadeInImage(
                placeholder: const AssetImage("images/loading.png"),
                image: MemoryImage(snapshot.data!),
                fit: BoxFit.cover,
                fadeInDuration: Durations.short4,
              );
            }
            return const Placeholder();
          },
        );
        imageWidgets.add(imagePreview);
      }

      setState(() {
        _imageWidgets.addAll(imageWidgets);
      });
    }

    return;
  }

  Future<void> _startFetchingImages(ScaffoldMessengerState messenger) async {
    if (_fetchingImagesStarted) return;
    _fetchingImagesStarted = true;

    await _checkPermission(messenger);
    if (!_permissionChecked) return;
    _fetchImages(messenger);

    return;
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
          itemBuilder: (context, index) => _imageWidgets[index],
          itemCount: _imageWidgets.length,
        ));
  }
}
