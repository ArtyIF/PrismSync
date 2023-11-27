class User {
  int? id;
  String? uid;
  String? authProvider;
  String? authId;
  String? name;
  String? displayName;
  String? email;
  String? role;
  String? attr;
  bool? superAdmin;
  bool? canLogin;
  String? loginAt;
  bool? webDAV;
  String? basePath;
  String? uploadPath;
  bool? canInvite;
  UserDetails? details;
  UserSettings? settings;
  String? thumb;
  String? thumbSrc;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.uid,
      this.authProvider,
      this.authId,
      this.name,
      this.displayName,
      this.email,
      this.role,
      this.attr,
      this.superAdmin,
      this.canLogin,
      this.loginAt,
      this.webDAV,
      this.basePath,
      this.uploadPath,
      this.canInvite,
      this.details,
      this.settings,
      this.thumb,
      this.thumbSrc,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    uid = json['UID'];
    authProvider = json['AuthProvider'];
    authId = json['AuthID'];
    name = json['Name'];
    displayName = json['DisplayName'];
    email = json['Email'];
    role = json['Role'];
    attr = json['Attr'];
    superAdmin = json['SuperAdmin'];
    canLogin = json['CanLogin'];
    loginAt = json['LoginAt'];
    webDAV = json['WebDAV'];
    basePath = json['BasePath'];
    uploadPath = json['UploadPath'];
    canInvite = json['CanInvite'];
    details = json['Details'] != null
        ? UserDetails.fromJson(json['Details'])
        : null;
    settings = json['Settings'] != null
        ? UserSettings.fromJson(json['Settings'])
        : null;
    thumb = json['Thumb'];
    thumbSrc = json['ThumbSrc'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['UID'] = uid;
    data['AuthProvider'] = authProvider;
    data['AuthID'] = authId;
    data['Name'] = name;
    data['DisplayName'] = displayName;
    data['Email'] = email;
    data['Role'] = role;
    data['Attr'] = attr;
    data['SuperAdmin'] = superAdmin;
    data['CanLogin'] = canLogin;
    data['LoginAt'] = loginAt;
    data['WebDAV'] = webDAV;
    data['BasePath'] = basePath;
    data['UploadPath'] = uploadPath;
    data['CanInvite'] = canInvite;
    if (details != null) {
      data['Details'] = details!.toJson();
    }
    if (settings != null) {
      data['Settings'] = settings!.toJson();
    }
    data['Thumb'] = thumb;
    data['ThumbSrc'] = thumbSrc;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    return data;
  }
}

class UserDetails {
  int? birthYear;
  int? birthMonth;
  int? birthDay;
  String? nameTitle;
  String? givenName;
  String? middleName;
  String? familyName;
  String? nameSuffix;
  String? nickName;
  String? nameSrc;
  String? gender;
  String? about;
  String? bio;
  String? location;
  String? country;
  String? phone;
  String? siteUrl;
  String? profileUrl;
  String? orgTitle;
  String? orgName;
  String? orgEmail;
  String? orgPhone;
  String? orgUrl;
  String? createdAt;
  String? updatedAt;

  UserDetails(
      {this.birthYear,
      this.birthMonth,
      this.birthDay,
      this.nameTitle,
      this.givenName,
      this.middleName,
      this.familyName,
      this.nameSuffix,
      this.nickName,
      this.nameSrc,
      this.gender,
      this.about,
      this.bio,
      this.location,
      this.country,
      this.phone,
      this.siteUrl,
      this.profileUrl,
      this.orgTitle,
      this.orgName,
      this.orgEmail,
      this.orgPhone,
      this.orgUrl,
      this.createdAt,
      this.updatedAt});

  UserDetails.fromJson(Map<String, dynamic> json) {
    birthYear = json['BirthYear'];
    birthMonth = json['BirthMonth'];
    birthDay = json['BirthDay'];
    nameTitle = json['NameTitle'];
    givenName = json['GivenName'];
    middleName = json['MiddleName'];
    familyName = json['FamilyName'];
    nameSuffix = json['NameSuffix'];
    nickName = json['NickName'];
    nameSrc = json['NameSrc'];
    gender = json['Gender'];
    about = json['About'];
    bio = json['Bio'];
    location = json['Location'];
    country = json['Country'];
    phone = json['Phone'];
    siteUrl = json['SiteURL'];
    profileUrl = json['ProfileURL'];
    orgTitle = json['OrgTitle'];
    orgName = json['OrgName'];
    orgEmail = json['OrgEmail'];
    orgPhone = json['OrgPhone'];
    orgUrl = json['OrgURL'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BirthYear'] = birthYear;
    data['BirthMonth'] = birthMonth;
    data['BirthDay'] = birthDay;
    data['NameTitle'] = nameTitle;
    data['GivenName'] = givenName;
    data['MiddleName'] = middleName;
    data['FamilyName'] = familyName;
    data['NameSuffix'] = nameSuffix;
    data['NickName'] = nickName;
    data['NameSrc'] = nameSrc;
    data['Gender'] = gender;
    data['About'] = about;
    data['Bio'] = bio;
    data['Location'] = location;
    data['Country'] = country;
    data['Phone'] = phone;
    data['SiteURL'] = siteUrl;
    data['ProfileURL'] = profileUrl;
    data['OrgTitle'] = orgTitle;
    data['OrgName'] = orgName;
    data['OrgEmail'] = orgEmail;
    data['OrgPhone'] = orgPhone;
    data['OrgURL'] = orgUrl;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    return data;
  }
}

class UserSettings {
  String? createdAt;
  String? updatedAt;

  UserSettings({this.createdAt, this.updatedAt});

  UserSettings.fromJson(Map<String, dynamic> json) {
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    return data;
  }
}
