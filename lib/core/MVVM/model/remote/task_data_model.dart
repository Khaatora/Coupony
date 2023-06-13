import 'package:equatable/equatable.dart';

import 'dart:convert';

TaskDataModel taskDataModelFromJson(String str) =>
    TaskDataModel.fromJson(json.decode(str));

String taskDataModelToJson(TaskDataModel data) => json.encode(data.toJson());

class TaskDataModel {
  int status;
  List<Datum> data;

  TaskDataModel({
    required this.status,
    required this.data,
  });

  factory TaskDataModel.fromJson(Map<String, dynamic> json) => TaskDataModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum();

  factory Datum.fromJson(Map<String, dynamic> json) => Datum();

  Map<String, dynamic> toJson() => {};
}
