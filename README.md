# PrismSync (pre-proof of concept)

Currently, PrismSync is a very basic gallery previewer, but it's planned to be a proper client for
[PhotoPrism](https://www.photoprism.app/) written in Dart/Flutter with built-in syncing and ability to view local
photos when the configured server is unavailable.

## Install
The app is built and installed like any other Flutter app. The recommended way is to open the project in
[a recommended IDE](https://docs.flutter.dev/get-started/editor), install dependencies (either automatically or with
`flutter pub get`), connect your phone over USB, enable USB debugging and installing apps over USB (look up how to
do that for your device), and run the project in a mode of your choice (debug, profile or release).

Builds will be automated once the project reaches a certain stage.

## Rambling on how syncing will work
- There'll be a PrismSync folder in the WebDAV imports folder (use https://pub.dev/packages/webdav_client for WebDAV)
- The path will be based on originFile's path
- originFiles will be uploaded to that folder and import will be triggered
- Check PP's API and see how to best approach downloading a file. Maybe create a local JSON file that tracks download
  associations and download it to a chosen path? Ask user at first download, then let the user change it in settings