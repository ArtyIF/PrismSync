class Camera {
  int? id;
  String? slug;
  String? name;
  String? make;
  String? model;

  Camera({this.id, this.slug, this.name, this.make, this.model});

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

  Lens({this.id, this.slug, this.name, this.make, this.model, this.type});

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

  Country({this.id, this.slug, this.name});

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

  Person({this.uid, this.name, this.keywords});

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

  Position({this.uid, this.cid, this.utc, this.lat, this.lng});

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

  Color({this.example, this.name, this.slug});

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

  Category({this.uid, this.slug, this.name});

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
