// TODO: cleanup, we don't need this much stuff

import 'package:prismsync/api/json/metadata.dart';

class Config {
  String? mode;
  String? name;
  String? about;
  String? edition;
  String? version;
  String? copyright;
  String? flags;
  String? baseUri;
  String? staticUri;
  String? cssUri;
  String? jsUri;
  String? manifestUri;
  String? apiUri;
  String? contentUri;
  String? videoUri;
  String? wallpaperUri;
  String? siteUrl;
  String? siteDomain;
  String? siteAuthor;
  String? siteTitle;
  String? siteCaption;
  String? siteDescription;
  String? sitePreview;
  String? legalInfo;
  String? legalUrl;
  String? appName;
  String? appMode;
  String? appIcon;
  String? appColor;
  bool? restart;
  bool? debug;
  bool? trace;
  bool? test;
  bool? demo;
  bool? sponsor;
  bool? readonly;
  bool? uploadNsfw;
  bool? public;
  String? authMode;
  String? usersPath;
  String? loginUri;
  String? registerUri;
  int? passwordLength;
  String? passwordResetUri;
  bool? experimental;
  // TODO: the album types below are nothing more than an educated guess (they returned an empty list and null for me)
  List<String>? albumCategories;
  List<Album>? albums;
  List<Camera>? cameras;
  List<Lens>? lenses;
  List<Country>? countries;
  List<Person>? people;
  List<Thumb>? thumbs;
  int? tier;
  String? membership;
  String? customer;
  String? mapKey;
  String? downloadToken;
  String? previewToken;
  DisableFeatures? disable;
  Count? count;
  Position? pos;
  List<int>? years;
  List<Color>? colors;
  List<Category>? categories;
  int? clip;
  //Server? server;
  //Albums? settings;
  //Acl? acl;
  //Ext? ext;

  Config({
    this.mode,
    this.name,
    this.about,
    this.edition,
    this.version,
    this.copyright,
    this.flags,
    this.baseUri,
    this.staticUri,
    this.cssUri,
    this.jsUri,
    this.manifestUri,
    this.apiUri,
    this.contentUri,
    this.videoUri,
    this.wallpaperUri,
    this.siteUrl,
    this.siteDomain,
    this.siteAuthor,
    this.siteTitle,
    this.siteCaption,
    this.siteDescription,
    this.sitePreview,
    this.legalInfo,
    this.legalUrl,
    this.appName,
    this.appMode,
    this.appIcon,
    this.appColor,
    this.restart,
    this.debug,
    this.trace,
    this.test,
    this.demo,
    this.sponsor,
    this.readonly,
    this.uploadNsfw,
    this.public,
    this.authMode,
    this.usersPath,
    this.loginUri,
    this.registerUri,
    this.passwordLength,
    this.passwordResetUri,
    this.experimental,
    this.albumCategories,
    this.albums,
    this.cameras,
    this.lenses,
    this.countries,
    this.people,
    this.thumbs,
    this.tier,
    this.membership,
    this.customer,
    this.mapKey,
    this.downloadToken,
    this.previewToken,
    this.disable,
    this.count,
    this.pos,
    this.years,
    this.colors,
    this.categories,
    this.clip,
    //this.server,
    //this.settings,
    //this.acl,
    //this.ext,
  });

  Config.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    name = json['name'];
    about = json['about'];
    edition = json['edition'];
    version = json['version'];
    copyright = json['copyright'];
    flags = json['flags'];
    baseUri = json['baseUri'];
    staticUri = json['staticUri'];
    cssUri = json['cssUri'];
    jsUri = json['jsUri'];
    manifestUri = json['manifestUri'];
    apiUri = json['apiUri'];
    contentUri = json['contentUri'];
    videoUri = json['videoUri'];
    wallpaperUri = json['wallpaperUri'];
    siteUrl = json['siteUrl'];
    siteDomain = json['siteDomain'];
    siteAuthor = json['siteAuthor'];
    siteTitle = json['siteTitle'];
    siteCaption = json['siteCaption'];
    siteDescription = json['siteDescription'];
    sitePreview = json['sitePreview'];
    legalInfo = json['legalInfo'];
    legalUrl = json['legalUrl'];
    appName = json['appName'];
    appMode = json['appMode'];
    appIcon = json['appIcon'];
    appColor = json['appColor'];
    restart = json['restart'];
    debug = json['debug'];
    trace = json['trace'];
    test = json['test'];
    demo = json['demo'];
    sponsor = json['sponsor'];
    readonly = json['readonly'];
    uploadNsfw = json['uploadNSFW'];
    public = json['public'];
    authMode = json['authMode'];
    usersPath = json['usersPath'];
    loginUri = json['loginUri'];
    registerUri = json['registerUri'];
    passwordLength = json['passwordLength'];
    passwordResetUri = json['passwordResetUri'];
    experimental = json['experimental'];
    albumCategories = json['albumCategories']?.cast<String>(); // TODO: test
    if (json['albums'] != null) {
      albums = <Album>[];
      json['albums'].forEach((v) {
        albums!.add(Album.fromJson(v));
      });
    }
    if (json['cameras'] != null) {
      cameras = <Camera>[];
      json['cameras'].forEach((v) {
        cameras!.add(Camera.fromJson(v));
      });
    }
    if (json['lenses'] != null) {
      lenses = <Lens>[];
      json['lenses'].forEach((v) {
        lenses!.add(Lens.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <Country>[];
      json['countries'].forEach((v) {
        countries!.add(Country.fromJson(v));
      });
    }
    if (json['people'] != null) {
      people = <Person>[];
      json['people'].forEach((v) {
        people!.add(Person.fromJson(v));
      });
    }
    if (json['thumbs'] != null) {
      thumbs = <Thumb>[];
      json['thumbs'].forEach((v) {
        thumbs!.add(Thumb.fromJson(v));
      });
    }
    tier = json['tier'];
    membership = json['membership'];
    customer = json['customer'];
    mapKey = json['mapKey'];
    downloadToken = json['downloadToken'];
    previewToken = json['previewToken'];
    disable = json['disable'] != null
        ? DisableFeatures.fromJson(json['disable'])
        : null;
    count = json['count'] != null ? Count.fromJson(json['count']) : null;
    pos = json['pos'] != null ? Position.fromJson(json['pos']) : null;
    years = json['years'].cast<int>();
    if (json['colors'] != null) {
      colors = <Color>[];
      json['colors'].forEach((v) {
        colors!.add(Color.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
    clip = json['clip'];
    /*server =
        json['server'] != null ? new Server.fromJson(json['server']) : null;
    settings =
        json['settings'] != null ? new Albums.fromJson(json['settings']) : null;
    acl = json['acl'] != null ? new Acl.fromJson(json['acl']) : null;
    ext = json['ext'] != null ? new Ext.fromJson(json['ext']) : null;*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mode'] = mode;
    data['name'] = name;
    data['about'] = about;
    data['edition'] = edition;
    data['version'] = version;
    data['copyright'] = copyright;
    data['flags'] = flags;
    data['baseUri'] = baseUri;
    data['staticUri'] = staticUri;
    data['cssUri'] = cssUri;
    data['jsUri'] = jsUri;
    data['manifestUri'] = manifestUri;
    data['apiUri'] = apiUri;
    data['contentUri'] = contentUri;
    data['videoUri'] = videoUri;
    data['wallpaperUri'] = wallpaperUri;
    data['siteUrl'] = siteUrl;
    data['siteDomain'] = siteDomain;
    data['siteAuthor'] = siteAuthor;
    data['siteTitle'] = siteTitle;
    data['siteCaption'] = siteCaption;
    data['siteDescription'] = siteDescription;
    data['sitePreview'] = sitePreview;
    data['legalInfo'] = legalInfo;
    data['legalUrl'] = legalUrl;
    data['appName'] = appName;
    data['appMode'] = appMode;
    data['appIcon'] = appIcon;
    data['appColor'] = appColor;
    data['restart'] = restart;
    data['debug'] = debug;
    data['trace'] = trace;
    data['test'] = test;
    data['demo'] = demo;
    data['sponsor'] = sponsor;
    data['readonly'] = readonly;
    data['uploadNSFW'] = uploadNsfw;
    data['public'] = public;
    data['authMode'] = authMode;
    data['usersPath'] = usersPath;
    data['loginUri'] = loginUri;
    data['registerUri'] = registerUri;
    data['passwordLength'] = passwordLength;
    data['passwordResetUri'] = passwordResetUri;
    data['experimental'] = experimental;
    data['albumCategories'] = albumCategories;
    if (albums != null) {
      data['albums'] = albums!.map((v) => v.toJson()).toList();
    }
    if (cameras != null) {
      data['cameras'] = cameras!.map((v) => v.toJson()).toList();
    }
    if (lenses != null) {
      data['lenses'] = lenses!.map((v) => v.toJson()).toList();
    }
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toJson()).toList();
    }
    if (people != null) {
      data['people'] = people!.map((v) => v.toJson()).toList();
    }
    if (thumbs != null) {
      data['thumbs'] = thumbs!.map((v) => v.toJson()).toList();
    }
    data['tier'] = tier;
    data['membership'] = membership;
    data['customer'] = customer;
    data['mapKey'] = mapKey;
    data['downloadToken'] = downloadToken;
    data['previewToken'] = previewToken;
    if (disable != null) {
      data['disable'] = disable!.toJson();
    }
    if (count != null) {
      data['count'] = count!.toJson();
    }
    if (pos != null) {
      data['pos'] = pos!.toJson();
    }
    data['years'] = years;
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    data['clip'] = clip;
    /*if (this.server != null) {
      data['server'] = this.server!.toJson();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    if (this.acl != null) {
      data['acl'] = this.acl!.toJson();
    }
    if (this.ext != null) {
      data['ext'] = this.ext!.toJson();
    }*/
    return data;
  }
}

class Thumb {
  String? size;
  String? usage;
  int? w;
  int? h;

  Thumb({this.size, this.usage, this.w, this.h});

  Thumb.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    usage = json['usage'];
    w = json['w'];
    h = json['h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['usage'] = usage;
    data['w'] = w;
    data['h'] = h;
    return data;
  }
}

class DisableFeatures {
  bool? webdav;
  bool? settings;
  bool? places;
  bool? backups;
  bool? tensorflow;
  bool? faces;
  bool? classification;
  bool? sips;
  bool? ffmpeg;
  bool? exiftool;
  bool? darktable;
  bool? rawtherapee;
  bool? imagemagick;
  bool? heifconvert;
  bool? vectors;
  bool? jpegxl;
  bool? raw;

  DisableFeatures(
      {this.webdav,
      this.settings,
      this.places,
      this.backups,
      this.tensorflow,
      this.faces,
      this.classification,
      this.sips,
      this.ffmpeg,
      this.exiftool,
      this.darktable,
      this.rawtherapee,
      this.imagemagick,
      this.heifconvert,
      this.vectors,
      this.jpegxl,
      this.raw});

  DisableFeatures.fromJson(Map<String, dynamic> json) {
    webdav = json['webdav'];
    settings = json['settings'];
    places = json['places'];
    backups = json['backups'];
    tensorflow = json['tensorflow'];
    faces = json['faces'];
    classification = json['classification'];
    sips = json['sips'];
    ffmpeg = json['ffmpeg'];
    exiftool = json['exiftool'];
    darktable = json['darktable'];
    rawtherapee = json['rawtherapee'];
    imagemagick = json['imagemagick'];
    heifconvert = json['heifconvert'];
    vectors = json['vectors'];
    jpegxl = json['jpegxl'];
    raw = json['raw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['webdav'] = webdav;
    data['settings'] = settings;
    data['places'] = places;
    data['backups'] = backups;
    data['tensorflow'] = tensorflow;
    data['faces'] = faces;
    data['classification'] = classification;
    data['sips'] = sips;
    data['ffmpeg'] = ffmpeg;
    data['exiftool'] = exiftool;
    data['darktable'] = darktable;
    data['rawtherapee'] = rawtherapee;
    data['imagemagick'] = imagemagick;
    data['heifconvert'] = heifconvert;
    data['vectors'] = vectors;
    data['jpegxl'] = jpegxl;
    data['raw'] = raw;
    return data;
  }
}

class Count {
  int? all;
  int? photos;
  int? live;
  int? videos;
  int? cameras;
  int? lenses;
  int? countries;
  int? hidden;
  int? archived;
  int? favorites;
  int? review;
  int? stories;
  int? private;
  int? albums;
  int? privateAlbums;
  int? moments;
  int? privateMoments;
  int? months;
  int? privateMonths;
  int? states;
  int? privateStates;
  int? folders;
  int? privateFolders;
  int? files;
  int? people;
  int? places;
  int? labels;
  int? labelMaxPhotos;

  Count(
      {this.all,
      this.photos,
      this.live,
      this.videos,
      this.cameras,
      this.lenses,
      this.countries,
      this.hidden,
      this.archived,
      this.favorites,
      this.review,
      this.stories,
      this.private,
      this.albums,
      this.privateAlbums,
      this.moments,
      this.privateMoments,
      this.months,
      this.privateMonths,
      this.states,
      this.privateStates,
      this.folders,
      this.privateFolders,
      this.files,
      this.people,
      this.places,
      this.labels,
      this.labelMaxPhotos});

  Count.fromJson(Map<String, dynamic> json) {
    all = json['all'];
    photos = json['photos'];
    live = json['live'];
    videos = json['videos'];
    cameras = json['cameras'];
    lenses = json['lenses'];
    countries = json['countries'];
    hidden = json['hidden'];
    archived = json['archived'];
    favorites = json['favorites'];
    review = json['review'];
    stories = json['stories'];
    private = json['private'];
    albums = json['albums'];
    privateAlbums = json['private_albums'];
    moments = json['moments'];
    privateMoments = json['private_moments'];
    months = json['months'];
    privateMonths = json['private_months'];
    states = json['states'];
    privateStates = json['private_states'];
    folders = json['folders'];
    privateFolders = json['private_folders'];
    files = json['files'];
    people = json['people'];
    places = json['places'];
    labels = json['labels'];
    labelMaxPhotos = json['labelMaxPhotos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all'] = all;
    data['photos'] = photos;
    data['live'] = live;
    data['videos'] = videos;
    data['cameras'] = cameras;
    data['lenses'] = lenses;
    data['countries'] = countries;
    data['hidden'] = hidden;
    data['archived'] = archived;
    data['favorites'] = favorites;
    data['review'] = review;
    data['stories'] = stories;
    data['private'] = private;
    data['albums'] = albums;
    data['private_albums'] = privateAlbums;
    data['moments'] = moments;
    data['private_moments'] = privateMoments;
    data['months'] = months;
    data['private_months'] = privateMonths;
    data['states'] = states;
    data['private_states'] = privateStates;
    data['folders'] = folders;
    data['private_folders'] = privateFolders;
    data['files'] = files;
    data['people'] = people;
    data['places'] = places;
    data['labels'] = labels;
    data['labelMaxPhotos'] = labelMaxPhotos;
    return data;
  }
}
