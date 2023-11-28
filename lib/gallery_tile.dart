// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:prismsync/global_vars.dart';
import 'package:prismsync/utilities.dart';
import 'package:transparent_image/transparent_image.dart';

class GalleryTile extends StatelessWidget {
  const GalleryTile({
    super.key,
    this.asset,
  });

  final AssetIntermediate? asset;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: asset!.getThumbnailBytes(),
      builder: (context, snapshot) {
        Widget tapMaterial = Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              // TODO: preview in the app itself
              // TODO: preview currently removed
              showErrorSnackBar(context, 'Preview not supported currently');
            },
          ),
        );

        Widget videoIcon = Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 5),
            child: Icon(
              Icons.play_circle,
              color: Colors.white,
              shadows: getIconShadows(),
            ),
          ),
        );
        Widget notBackedUpIcon = Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 5),
            child: Icon(
              Icons.cloud_upload_outlined,
              color: Colors.white,
              shadows: getIconShadows(),
            ),
          ),
        );
        // TODO: other icons, make icons functional

        List<Widget> stackChildren = [
          if (asset!.type == AssetType.video) videoIcon,
          notBackedUpIcon,
          tapMaterial,
        ];
        if (snapshot.hasData) {
          stackChildren.insert(
            0,
            Positioned.fill(
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: MemoryImage(snapshot.data!),
                fit: BoxFit.cover,
                fadeInDuration: Durations.short4,
              ),
            ),
          );
        }
        return Stack(children: stackChildren);
      },
    );
  }
}
