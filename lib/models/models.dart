
// To parse this JSON data, do
//
//     final commonModel = commonModelFromJson(jsonString);

import 'dart:convert';

CommonModel commonModelFromJson(String str) => CommonModel.fromJson(json.decode(str));

String commonModelToJson(CommonModel data) => json.encode(data.toJson());

class CommonModel {
  CommonModel({
    this.error_flag,
    this.message,
  });

  String? error_flag;
  String? message;

  factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
    error_flag: json["error_flag"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error_flag": error_flag,
    "message": message,
  };
}
