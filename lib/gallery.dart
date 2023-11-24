import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:open_filex/open_filex.dart';

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
        Widget imagePreview = FutureBuilder(
          future: asset.thumbnailDataWithSize(const ThumbnailSize.square(256)),
          builder: (context, snapshot) {
            Widget tapMaterial = Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  // TODO: preview in app
                  final File? originFile = await asset.originFile;
                  print(originFile);
                  if (originFile != null) {
                    _openFile(messenger, originFile.path);
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text("Failed to get file for image"),
                      ),
                    );
                  }
                },
              ),
            );
            if (snapshot.hasData) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: MemoryImage(snapshot.data!),
                      fit: BoxFit.cover,
                      fadeInDuration: Durations.short4,
                    ),
                  ),
                  tapMaterial,
                ],
              );
            } else {
              return tapMaterial;
            }
          },
        );
        setState(() {
          _imageWidgets.add(imagePreview);
        });
      }
    }

    return;
  }

  Future<void> _openFile(ScaffoldMessengerState messenger, String path) async {
    OpenResult result = await OpenFilex.open(path);
    switch (result.type) {
      case ResultType.error:
        messenger.showSnackBar(
          SnackBar(
            content: Text(result.message),
          ),
        );
        break;
      case ResultType.fileNotFound:
        messenger.showSnackBar(
          SnackBar(
            content: Text("File $path wasn't found"),
          ),
        );
        break;
      case ResultType.noAppToOpen:
        messenger.showSnackBar(
          SnackBar(
            content: Text("No app to open $path seems to be installed"),
          ),
        );
        break;
      case ResultType.permissionDenied:
        messenger.showSnackBar(
          SnackBar(
            content: Text("Permission to open $path was denied"),
          ),
        );
        break;
      default:
    }
  }

  Future<void> _startFetchingImages(ScaffoldMessengerState messenger) async {
    if (_fetchingImagesStarted) return;
    _fetchingImagesStarted = true;

    await _checkPermission(messenger);
    if (!_permissionChecked) return;
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
          itemBuilder: (context, index) => _imageWidgets[index],
          itemCount: _imageWidgets.length,
        ));
  }
}
