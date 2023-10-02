// "status": 200,
// "data": [
// {
// "id": 1,
// "campaign_id": 1,
// "banner": "https://mir-s3-cdn-cf.behance.net/projects/404/1cb86469753415.Y3JvcCwxMTUwLDg5OSwxMzc1LDY0Mw.jpg",
// "channel": "home",
// "region": "GCC"
// },
// {
// "id": 2,
// "campaign_id": 1,
// "banner": "https://mir-s3-cdn-cf.behance.net/projects/404/1cb86469753415.Y3JvcCwxMTUwLDg5OSwxMzc1LDY0Mw.jpg",
// "channel": "home",
// "region": "GCC"
// },
// {
// "id": 3,
// "campaign_id": 1,
// "banner": "https://mir-s3-cdn-cf.behance.net/projects/404/1cb86469753415.Y3JvcCwxMTUwLDg5OSwxMzc1LDY0Mw.jpg",
// "channel": "home",
// "region": "GCC"
// },
// ]

class GetBannerResponse {
  final int status;
  final List<BannerData> data;

  const GetBannerResponse({required this.status, required this.data});

  factory GetBannerResponse.fromJson(Map<String, dynamic> json) {
    return GetBannerResponse(
      status: json[GetBannerJsonKeys.status],
      data: (json[GetBannerJsonKeys.data] as List<dynamic>)
          .map((element) {
        return BannerData.fromJson(element);
      }).toList(),
    );
  }
}

class BannerData {
  final int campaignId;
  final int id;
  final String banner;
  final String channel;
  final String region;

  const BannerData({
    required this.campaignId,
    required this.id,
    required this.banner,
    required this.channel,
    required this.region,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) {
    return BannerData(
      campaignId: json[GetBannerJsonKeys.campaignId].toInt(),
      id: json[GetBannerJsonKeys.id].toInt(),
      channel: json[GetBannerJsonKeys.channel],
      banner: json[GetBannerJsonKeys.banner],
      region: json[GetBannerJsonKeys.region],
    );
  }
//
}

class GetBannerJsonKeys {
  static const String campaignId = "campaign_id";
  static const String data = "data";
  static const String status = "status";
  static const String id = "id";
  static const String banner = "banner";
  static const String channel = "channel";
  static const String region = "region";
}
