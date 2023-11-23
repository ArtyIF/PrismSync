import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  final String title = 'Gallery';

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  int _fetchingImagesState = 0;
  bool _permissionChecked = false;
  final List<Uint8List> _imageDatas = List.empty(growable: true);

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
                }));
        messenger.showSnackBar(snackBar);
      } else if (!ps.isAuth) {
        final snackBar = SnackBar(
            content: const Text(
                "Permission to access all photos and videos on your device is recommended to use this app. For that, make sure the \"Photos and videos\" permission is set to \"Always allow all\"."),
            action: SnackBarAction(
                label: "Open Settings",
                onPressed: () {
                  PhotoManager.openSetting();
                }));
        messenger.showSnackBar(snackBar);
      }
      _permissionChecked = true;
    }
  }

  Future<void> _fetchImages(ScaffoldMessengerState messenger) async {
    if (_fetchingImagesState > 1) return;
    _fetchingImagesState = 2;

    for (int i = 0;
        i < ((await PhotoManager.getAssetCount()) / 30).ceil();
        i++) {
      var assets = await PhotoManager.getAssetListPaged(
          page: i, pageCount: 30, type: RequestType.common);
      List<Uint8List> imageData = List.empty(growable: true);
      for (var asset in assets) {
        Uint8List? assetData =
            await asset.thumbnailDataWithSize(const ThumbnailSize.square(256));
        if (assetData != null) {
          imageData.add(assetData);
        }
      }

      setState(() {
        _imageDatas.addAll(imageData);
      });
    }
    // TODO: https://stackoverflow.com/questions/68520264/simple-grid-gallery-with-photo-manager
    // tldr on the todo: generate widgets right then and there

    return;
  }

  Future<void> _startFetchingImages(ScaffoldMessengerState messenger) async {
    if (_fetchingImagesState > 0) return;
    _fetchingImagesState = 1;

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
              maxCrossAxisExtent: 150, mainAxisSpacing: 5, crossAxisSpacing: 5),
          itemBuilder: ((context, index) => FadeInImage(
                placeholder: const AssetImage("images/loading.png"),
                image: ScrollAwareImageProvider(
                    context: DisposableBuildContext(this),
                    imageProvider: MemoryImage(_imageDatas[index])),
                fit: BoxFit.cover,
                fadeInDuration: Durations.short4,
              )),
          itemCount: _imageDatas.length,
        ));
  }
}
