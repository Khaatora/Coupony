class GetDataCampaignsResponse {
  final List<Data> data;
  final List<Logo> logo;

  GetDataCampaignsResponse({required this.data, required this.logo});

  factory GetDataCampaignsResponse.fromJson(Map<String, dynamic> json) {
    return GetDataCampaignsResponse(
      data: (json[GetDataCampaignsJsonKeys.data] as List<Map<String, dynamic>>)
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
          .toList(),
      logo: (json[GetDataCampaignsJsonKeys.data] as List<Map<String, dynamic>>)
          .map((subJson) => Logo(
                logo: subJson[GetDataCampaignsJsonKeys.logo],
                name: subJson[GetDataCampaignsJsonKeys.name],
              ))
          .toList(),
    );
  }
}

class Data {
  final int campaignId;
  final int clicksNo;
  final String category;
  final String link;
  final String name;
  final String rate;
  final String region;
  final int startDate;

  const Data({
    required this.campaignId,
    required this.clicksNo,
    required this.category,
    required this.link,
    required this.name,
    required this.rate,
    required this.region,
    required this.startDate,
  });
}

class Logo {
  final String logo;
  final String name;

  Logo({
    required this.logo,
    required this.name,
  });
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
