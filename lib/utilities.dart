import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:prismsync/api/json/photo.dart';
import 'package:prismsync/api/utilities.dart';

void showLoadingOverlay(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const PopScope(
      canPop: false,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

void hideLoadingOverlay(BuildContext context) {
  Navigator.pop(context);
}

void showSnackBar({
  required BuildContext context,
  required String text,
  SnackBarAction? action,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      action: action,
    ),
  );
}

void showErrorSnackBar(BuildContext context, String error) {
  showSnackBar(
    context: context,
    text: error,
  );
}

class AssetIntermediate {
  final AssetEntity? localAsset;
  final Photo? cloudAsset;

  late final AssetType type;

  AssetIntermediate({
    this.localAsset,
    this.cloudAsset,
  }) {
    if (localAsset != null) {
      type = localAsset!.type;
      return;
    }
    if (cloudAsset != null) {
      switch (cloudAsset!.type) {
        case 'image' || 'raw' || 'vector':
          type = AssetType.image;
          break;
        case 'video' || 'live' || 'animated':
          type = AssetType.video;
          break;
        default:
          type = AssetType.other;
          break;
      }
      return;
    }
    throw 'No asset specified';
  }

  Future<Uint8List?> getOriginalBytes() async {
    if (localAsset != null) {
      return await localAsset!.originBytes;
    }
    if (cloudAsset != null) {
      for (var file in cloudAsset!.files!) {
        if (file.originalName != null) {
          // TODO: actually fetch the image
          return Uint8List(0);
        }
      }
    }
  }

  Future<Uint8List?> getThumbnailBytes() async {
    if (localAsset != null) {
      return await localAsset!.thumbnailDataWithSize(
        const ThumbnailSize.square(256),
      );
    }
    if (cloudAsset != null) {
      for (var file in cloudAsset!.files!) {
        if (file.originalName == null) {
          // god photoprism is a fucking mess, it doesn't have a thumbnail flag in files
          // TODO: actually fetch the image
          return Uint8List(0);
        }
      }
    }
  }
}
