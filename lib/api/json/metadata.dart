class Camera {
  int? id;
  String? slug;
  String? name;
  String? make;
  String? model;

  Camera({
    this.id,
    this.slug,
    this.name,
    this.make,
    this.model,
  });

  Camera.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    slug = json['Slug'];
    name = json['Name'];
    make = json['Make'];
    model = json['Model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['Slug'] = slug;
    data['Name'] = name;
    data['Make'] = make;
    data['Model'] = model;
    return data;
  }
}

class Lens {
  int? id;
  String? slug;
  String? name;
  String? make;
  String? model;
  String? type;

  Lens({
    this.id,
    this.slug,
    this.name,
    this.make,
    this.model,
    this.type,
  });

  Lens.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    slug = json['Slug'];
    name = json['Name'];
    make = json['Make'];
    model = json['Model'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['Slug'] = slug;
    data['Name'] = name;
    data['Make'] = make;
    data['Model'] = model;
    data['Type'] = type;
    return data;
  }
}

class Country {
  String? id;
  String? slug;
  String? name;

  Country({
    this.id,
    this.slug,
    this.name,
  });

  Country.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    slug = json['Slug'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['Slug'] = slug;
    data['Name'] = name;
    return data;
  }
}

class Person {
  String? uid;
  String? name;
  List<String>? keywords;

  Person({
    this.uid,
    this.name,
    this.keywords,
  });

  Person.fromJson(Map<String, dynamic> json) {
    uid = json['UID'];
    name = json['Name'];
    keywords = json['Keywords'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UID'] = uid;
    data['Name'] = name;
    data['Keywords'] = keywords;
    return data;
  }
}

class Position {
  String? uid;
  String? cid;
  String? utc;
  double? lat;
  double? lng;

  Position({
    this.uid,
    this.cid,
    this.utc,
    this.lat,
    this.lng,
  });

  Position.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    cid = json['cid'];
    utc = json['utc'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['cid'] = cid;
    data['utc'] = utc;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Color {
  String? example;
  String? name;
  String? slug;

  Color({
    this.example,
    this.name,
    this.slug,
  });

  Color.fromJson(Map<String, dynamic> json) {
    example = json['Example'];
    name = json['Name'];
    slug = json['Slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Example'] = example;
    data['Name'] = name;
    data['Slug'] = slug;
    return data;
  }
}

class Category {
  String? uid;
  String? slug;
  String? name;

  Category({
    this.uid,
    this.slug,
    this.name,
  });

  Category.fromJson(Map<String, dynamic> json) {
    uid = json['UID'];
    slug = json['Slug'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UID'] = uid;
    data['Slug'] = slug;
    data['Name'] = name;
    return data;
  }
}

class Album {
  String? uid;
  String? parentUid;
  String? thumb;
  String? slug;
  String? type;
  String? title;
  String? location;
  String? category;
  String? caption;
  String? description;
  String? notes;
  String? filter;
  String? order;
  String? template;
  String? path;
  String? state;
  String? country;
  int? year;
  int? month;
  int? day;
  bool? favorite;
  bool? private;
  int? photoCount;
  int? linkCount;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Album({
    this.uid,
    this.parentUid,
    this.thumb,
    this.slug,
    this.type,
    this.title,
    this.location,
    this.category,
    this.caption,
    this.description,
    this.notes,
    this.filter,
    this.order,
    this.template,
    this.path,
    this.state,
    this.country,
    this.year,
    this.month,
    this.day,
    this.favorite,
    this.private,
    this.photoCount,
    this.linkCount,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Album.fromJson(Map<String, dynamic> json) {
    uid = json['UID'];
    parentUid = json['ParentUID'];
    thumb = json['Thumb'];
    slug = json['Slug'];
    type = json['Type'];
    title = json['Title'];
    location = json['Location'];
    category = json['Category'];
    caption = json['Caption'];
    description = json['Description'];
    notes = json['Notes'];
    filter = json['Filter'];
    order = json['Order'];
    template = json['Template'];
    path = json['Path'];
    state = json['State'];
    country = json['Country'];
    year = json['Year'];
    month = json['Month'];
    day = json['Day'];
    favorite = json['Favorite'];
    private = json['Private'];
    photoCount = json['PhotoCount'];
    linkCount = json['LinkCount'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UID'] = uid;
    data['ParentUID'] = parentUid;
    data['Thumb'] = thumb;
    data['Slug'] = slug;
    data['Type'] = type;
    data['Title'] = title;
    data['Location'] = location;
    data['Category'] = category;
    data['Caption'] = caption;
    data['Description'] = description;
    data['Notes'] = notes;
    data['Filter'] = filter;
    data['Order'] = order;
    data['Template'] = template;
    data['Path'] = path;
    data['State'] = state;
    data['Country'] = country;
    data['Year'] = year;
    data['Month'] = month;
    data['Day'] = day;
    data['Favorite'] = favorite;
    data['Private'] = private;
    data['PhotoCount'] = photoCount;
    data['LinkCount'] = linkCount;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    return data;
  }
}
