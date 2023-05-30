import 'dart:convert';

Recommendations recommendationsFromJson(String str) =>
    Recommendations.fromJson(json.decode(str));

String recommendationsToJson(Recommendations data) =>
    json.encode(data.toJson());

class Recommendations {
  int status;
  List<String> recommendations;

  Recommendations({
    required this.status,
    required this.recommendations,
  });

  factory Recommendations.fromJson(Map<String, dynamic> json) =>
      Recommendations(
        status: json["status"],
        recommendations:
            List<String>.from(json["recommendations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "recommendations": List<dynamic>.from(recommendations.map((x) => x)),
      };
}
