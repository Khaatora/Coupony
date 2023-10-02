import 'dart:developer';

import 'package:equatable/equatable.dart';


class GetDataCampaignsResponse {
  final List<Campaign> campaigns;

  const GetDataCampaignsResponse({required this.campaigns});

  factory GetDataCampaignsResponse.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    final List<Data> tempData = (json[GetDataCampaignsJsonKeys.data] as List<dynamic>)
        .map(
          (subJson) => Data(
        campaignId: subJson[GetDataCampaignsJsonKeys.campaignId].toInt(),
        clicksNo: subJson[GetDataCampaignsJsonKeys.clicksNo].toInt(),
        category: subJson[GetDataCampaignsJsonKeys.category],
        link: subJson[GetDataCampaignsJsonKeys.link],
        name: subJson[GetDataCampaignsJsonKeys.name],
        rate: subJson[GetDataCampaignsJsonKeys.rate],
        region: subJson[GetDataCampaignsJsonKeys.region],
        startDate: subJson[GetDataCampaignsJsonKeys.startDate].toInt(),
      ),
    )
        .toList();
    final List<Logo> tempLogos = (json[GetDataCampaignsJsonKeys.logos] as List<dynamic>)
        .map((subJson) => Logo(
      url: subJson[GetDataCampaignsJsonKeys.logo],
      name: subJson[GetDataCampaignsJsonKeys.name],
    ))
        .toList();
    return GetDataCampaignsResponse(
      campaigns: tempData.map<Campaign>((data) {
        return Campaign(data: data, logo: tempLogos.firstWhere((logo) => logo.name.toLowerCase() == data.name.toLowerCase()));
      }).toList(),
    );
  }
}

class Data extends Equatable{
  final int campaignId;
  final int clicksNo;
  final String category;
  final String link;
  final String name;
  final String rate;
  final String region;
  final int startDate;
  final bool isFav;

  const Data({
    required this.campaignId,
    required this.clicksNo,
    required this.category,
    required this.link,
    required this.name,
    required this.rate,
    required this.region,
    required this.startDate,
    this.isFav = false,
  });

  @override
  List<Object?> get props => [
    campaignId,
    clicksNo,
    category,
    link,
    name,
    rate,
    region,
    startDate,
    isFav,
  ];
}

class Logo extends Equatable{
  final String url;
  final String name;

  const Logo({
    required this.url,
    required this.name,
  });

  @override
  List<Object?> get props => [
    url,
    name,
  ];
}

class GetDataCampaignsJsonKeys {
  static const String data = "data";
  static const String logos = "logos";

  static const String campaignId = "campaign_id";
  static const String clicksNo = "clicks_no";
  static const String category = "category";
  static const String link = "link";
  static const String name = "name";
  static const String rate = "rate";
  static const String region = "region";
  static const String startDate = "start_date";
  static const String logo = "logo";
}

class Campaign{
  final Data data;
  final Logo logo;

  const Campaign({required this.data, required this.logo});

  Campaign copyWith({
    Data? data,
    Logo? logo
}){
    return Campaign(data: data ?? this.data, logo: logo ?? this.logo);
  }

  @override
  String toString() {
    return "Name :${data.name}, CampaignId :${data.campaignId}, Category :${data.category}, LogoUrl :${logo.url}";
  }
}