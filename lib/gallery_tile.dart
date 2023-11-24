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
              // TODO: preview in app
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
