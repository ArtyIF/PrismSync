# PrismSync

TODO: fill this

Outline on how sync will work:
- There'll be a PrismSync folder in the WebDAV imports folder (use https://pub.dev/packages/webdav_client for WebDAV)
- The path will be based on originFile's path
- originFiles will be uploaded to that folder and import will be triggered
- Check PP's API and see how to best approach downloading a file. Maybe create a local JSON file that tracks download
  associations and download it to a chosen path? Ask user at first download, then let the user change it in settings