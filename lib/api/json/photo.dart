// TODO: clean this up, we don't need everything here

class PhotoList {
  List<Photo>? photos;

  PhotoList({
    this.photos,
  });

  PhotoList.fromJson(List<Map<String, dynamic>>? json) {
    if (json != null) {
      photos = <Photo>[];
      for (var v in json) {
        photos!.add(Photo.fromJson(v));
      }
    }
  }

  List<Map<String, dynamic>> toJson() {
    final List<Map<String, dynamic>> data = [];
    if (photos != null) {
      for (var v in photos!) {
        data.add(v.toJson());
      }
    }
    return data;
  }
}

class Photo {
  String? id;
  String? uid;
  String? type;
  String? typeSrc;
  String? takenAt;
  String? takenAtLocal;
  String? takenSrc;
  String? timeZone;
  String? path;
  String? name;
  String? originalName;
  String? title;
  String? description;
  int? year;
  int? month;
  int? day;
  String? country;
  int? stack;
  bool? favorite;
  bool? private;
  int? iso;
  int? focalLength;
  double? fNumber;
  String? exposure;
  int? quality;
  int? resolution;
  int? color;
  bool? scan;
  bool? panorama;
  int? cameraId;
  String? cameraSrc;
  String? cameraMake;
  String? cameraModel;
  int? lensId;
  String? lensModel;
  int? altitude;
  double? lat;
  double? lng;
  String? cellId;
  String? placeId;
  String? placeSrc;
  String? placeLabel;
  String? placeCity;
  String? placeState;
  String? placeCountry;
  String? instanceId;
  String? fileUid;
  String? fileRoot;
  String? fileName;
  String? hash;
  int? width;
  int? height;
  bool? portrait;
  bool? merged;
  String? createdAt;
  String? updatedAt;
  String? editedAt;
  String? checkedAt;
  String? deletedAt;
  List<PhotoFile>? files;

  Photo({
    this.id,
    this.uid,
    this.type,
    this.typeSrc,
    this.takenAt,
    this.takenAtLocal,
    this.takenSrc,
    this.timeZone,
    this.path,
    this.name,
    this.originalName,
    this.title,
    this.description,
    this.year,
    this.month,
    this.day,
    this.country,
    this.stack,
    this.favorite,
    this.private,
    this.iso,
    this.focalLength,
    this.fNumber,
    this.exposure,
    this.quality,
    this.resolution,
    this.color,
    this.scan,
    this.panorama,
    this.cameraId,
    this.cameraSrc,
    this.cameraMake,
    this.cameraModel,
    this.lensId,
    this.lensModel,
    this.altitude,
    this.lat,
    this.lng,
    this.cellId,
    this.placeId,
    this.placeSrc,
    this.placeLabel,
    this.placeCity,
    this.placeState,
    this.placeCountry,
    this.instanceId,
    this.fileUid,
    this.fileRoot,
    this.fileName,
    this.hash,
    this.width,
    this.height,
    this.portrait,
    this.merged,
    this.createdAt,
    this.updatedAt,
    this.editedAt,
    this.checkedAt,
    this.deletedAt,
    this.files,
  });

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    uid = json['UID'];
    type = json['Type'];
    typeSrc = json['TypeSrc'];
    takenAt = json['TakenAt'];
    takenAtLocal = json['TakenAtLocal'];
    takenSrc = json['TakenSrc'];
    timeZone = json['TimeZone'];
    path = json['Path'];
    name = json['Name'];
    originalName = json['OriginalName'];
    title = json['Title'];
    description = json['Description'];
    year = json['Year'];
    month = json['Month'];
    day = json['Day'];
    country = json['Country'];
    stack = json['Stack'];
    favorite = json['Favorite'];
    private = json['Private'];
    iso = json['Iso'];
    focalLength = json['FocalLength'];
    fNumber = json['FNumber'];
    exposure = json['Exposure'];
    quality = json['Quality'];
    resolution = json['Resolution'];
    color = json['Color'];
    scan = json['Scan'];
    panorama = json['Panorama'];
    cameraId = json['CameraID'];
    cameraSrc = json['CameraSrc'];
    cameraMake = json['CameraMake'];
    cameraModel = json['CameraModel'];
    lensId = json['LensID'];
    lensModel = json['LensModel'];
    altitude = json['Altitude'];
    lat = json['Lat'];
    lng = json['Lng'];
    cellId = json['CellID'];
    placeId = json['PlaceID'];
    placeSrc = json['PlaceSrc'];
    placeLabel = json['PlaceLabel'];
    placeCity = json['PlaceCity'];
    placeState = json['PlaceState'];
    placeCountry = json['PlaceCountry'];
    instanceId = json['InstanceID'];
    fileUid = json['FileUID'];
    fileRoot = json['FileRoot'];
    fileName = json['FileName'];
    hash = json['Hash'];
    width = json['Width'];
    height = json['Height'];
    portrait = json['Portrait'];
    merged = json['Merged'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    editedAt = json['EditedAt'];
    checkedAt = json['CheckedAt'];
    deletedAt = json['DeletedAt'];
    if (json['Files'] != null) {
      files = <PhotoFile>[];
      json['Files'].forEach((v) {
        files!.add(PhotoFile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['UID'] = uid;
    data['Type'] = type;
    data['TypeSrc'] = typeSrc;
    data['TakenAt'] = takenAt;
    data['TakenAtLocal'] = takenAtLocal;
    data['TakenSrc'] = takenSrc;
    data['TimeZone'] = timeZone;
    data['Path'] = path;
    data['Name'] = name;
    data['OriginalName'] = originalName;
    data['Title'] = title;
    data['Description'] = description;
    data['Year'] = year;
    data['Month'] = month;
    data['Day'] = day;
    data['Country'] = country;
    data['Stack'] = stack;
    data['Favorite'] = favorite;
    data['Private'] = private;
    data['Iso'] = iso;
    data['FocalLength'] = focalLength;
    data['FNumber'] = fNumber;
    data['Exposure'] = exposure;
    data['Quality'] = quality;
    data['Resolution'] = resolution;
    data['Color'] = color;
    data['Scan'] = scan;
    data['Panorama'] = panorama;
    data['CameraID'] = cameraId;
    data['CameraSrc'] = cameraSrc;
    data['CameraMake'] = cameraMake;
    data['CameraModel'] = cameraModel;
    data['LensID'] = lensId;
    data['LensModel'] = lensModel;
    data['Altitude'] = altitude;
    data['Lat'] = lat;
    data['Lng'] = lng;
    data['CellID'] = cellId;
    data['PlaceID'] = placeId;
    data['PlaceSrc'] = placeSrc;
    data['PlaceLabel'] = placeLabel;
    data['PlaceCity'] = placeCity;
    data['PlaceState'] = placeState;
    data['PlaceCountry'] = placeCountry;
    data['InstanceID'] = instanceId;
    data['FileUID'] = fileUid;
    data['FileRoot'] = fileRoot;
    data['FileName'] = fileName;
    data['Hash'] = hash;
    data['Width'] = width;
    data['Height'] = height;
    data['Portrait'] = portrait;
    data['Merged'] = merged;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['EditedAt'] = editedAt;
    data['CheckedAt'] = checkedAt;
    data['DeletedAt'] = deletedAt;
    if (files != null) {
      data['Files'] = files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhotoFile {
  String? uid;
  String? photoUid;
  String? name;
  String? root;
  String? hash;
  int? size;
  bool? primary;
  String? originalName;
  String? codec;
  String? fileType;
  String? mediaType;
  String? mime;
  bool? portrait;
  int? width;
  int? height;
  int? orientation;
  double? aspectRatio;
  String? colors;
  String? luminance;
  int? diff;
  int? chroma;
  String? createdAt;
  String? updatedAt;
  //List<Null>? markers; // TODO: figure out the type

  PhotoFile({
    this.uid,
    this.photoUid,
    this.name,
    this.root,
    this.hash,
    this.size,
    this.primary,
    this.originalName,
    this.codec,
    this.fileType,
    this.mediaType,
    this.mime,
    this.portrait,
    this.width,
    this.height,
    this.orientation,
    this.aspectRatio,
    this.colors,
    this.luminance,
    this.diff,
    this.chroma,
    this.createdAt,
    this.updatedAt,
    /*this.markers*/
  });

  PhotoFile.fromJson(Map<String, dynamic> json) {
    uid = json['UID'];
    photoUid = json['PhotoUID'];
    name = json['Name'];
    root = json['Root'];
    hash = json['Hash'];
    size = json['Size'];
    primary = json['Primary'];
    originalName = json['OriginalName'];
    codec = json['Codec'];
    fileType = json['FileType'];
    mediaType = json['MediaType'];
    mime = json['Mime'];
    portrait = json['Portrait'];
    width = json['Width'];
    height = json['Height'];
    orientation = json['Orientation'];
    aspectRatio = json['AspectRatio'];
    colors = json['Colors'];
    luminance = json['Luminance'];
    diff = json['Diff'];
    chroma = json['Chroma'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    /*if (json['Markers'] != null) {
      markers = <Null>[];
      json['Markers'].forEach((v) {
        markers!.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UID'] = uid;
    data['PhotoUID'] = photoUid;
    data['Name'] = name;
    data['Root'] = root;
    data['Hash'] = hash;
    data['Size'] = size;
    data['Primary'] = primary;
    data['OriginalName'] = originalName;
    data['Codec'] = codec;
    data['FileType'] = fileType;
    data['MediaType'] = mediaType;
    data['Mime'] = mime;
    data['Portrait'] = portrait;
    data['Width'] = width;
    data['Height'] = height;
    data['Orientation'] = orientation;
    data['AspectRatio'] = aspectRatio;
    data['Colors'] = colors;
    data['Luminance'] = luminance;
    data['Diff'] = diff;
    data['Chroma'] = chroma;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    /*if (this.markers != null) {
      data['Markers'] = this.markers!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}
