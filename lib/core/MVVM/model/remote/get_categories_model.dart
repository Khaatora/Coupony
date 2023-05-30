import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) =>
    json.encode(data.toJson());

class CategoriesModel {
  int status;
  List<CampaignCategory> campaignCategories;

  CategoriesModel({
    required this.status,
    required this.campaignCategories,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        status: json["status"],
        campaignCategories: List<CampaignCategory>.from(
            json["campaign_categories"]
                .map((x) => CampaignCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "campaign_categories":
            List<dynamic>.from(campaignCategories.map((x) => x.toJson())),
      };
}

class CampaignCategory {
  String category;
  String campaign;

  CampaignCategory({
    required this.category,
    required this.campaign,
  });

  factory CampaignCategory.fromJson(Map<String, dynamic> json) =>
      CampaignCategory(
        category: json["category"],
        campaign: json["campaign"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "campaign": campaign,
      };
}
