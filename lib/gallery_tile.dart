import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:transparent_image/transparent_image.dart';

class GalleryTile extends StatelessWidget {
  const GalleryTile({
    super.key,
    required this.asset,
    required this.messenger,
  });

  final AssetEntity asset;
  final ScaffoldMessengerState messenger;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(const ThumbnailSize.square(256)),
      builder: (context, snapshot) {
        Widget tapMaterial = Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              // TODO: preview in the app itself
              final File? originFile = await asset.originFile;
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
              if (asset.type == AssetType.video)
                const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, right: 5),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      shadows: [
                        Shadow(blurRadius: 5.0),
                      ],
                    ),
                  ),
                ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 5, left: 5),
                  child: Icon(
                    Icons.cloud_upload_outlined,
                    color: Colors.white,
                    shadows: [
                      Shadow(blurRadius: 5.0),
                    ],
                  ),
                ),
              ),
              // TODO: icons for not-backed-up-yet (see above) and PhotoPrism-only
              // TODO: (cloud_download, also greyed out, pressing triggers download
              // TODO: if PP is available), as well as others
              tapMaterial,
            ],
          );
        } else {
          return tapMaterial;
        }
      },
    );
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
}
