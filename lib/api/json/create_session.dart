import 'package:prismsync/api/json/user.dart';

class CreateSessionRequest {
  String? username;
  String? password;

  CreateSessionRequest({
    this.username,
    this.password,
  });

  CreateSessionRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}

class CreateSessionResponse {
  //Config? config;
  //Data? data;
  String? id;
  String? provider;
  String? status;
  User? user;

  CreateSessionResponse({
    /*this.config, */
    /*this.data,*/
    this.id,
    this.provider,
    this.status,
    this.user,
  });

  CreateSessionResponse.fromJson(Map<String, dynamic> json) {
    //config = json['config'] != null ? new Config.fromJson(json['config']) : null;
    //data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    id = json['id'];
    provider = json['provider'];
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    /*if (this.config != null) {
      data['config'] = this.config!.toJson();
    }*/
    /*if (this.data != null) {
      data['data'] = this.data!.toJson();
    }*/
    data['id'] = id;
    data['provider'] = provider;
    data['status'] = status;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
