class GetCouponResponse{
  final int status;
  final CouponData couponData;

  const GetCouponResponse({required this.status, required this.couponData,});

  factory GetCouponResponse.fromJson(Map<String, dynamic> json) {
    return GetCouponResponse(
      status: json[GetCouponAPIKeys.status].toInt(),
      couponData: CouponData.fromJson(json[GetCouponAPIKeys.data]),
    );
  }
//
}


class CouponData{
  final int id;
  final String code;
  final int campaignId;
  final String description;
  final String channel;
  final int clicksNo;


  CouponData(
      {required this.id,
      required this.code,
      required this.campaignId,
      required this.description,
      required this.channel,
      required this.clicksNo,});

  factory CouponData.fromJson(Map<String, dynamic> json) {
    return CouponData(
      id: (json[GetCouponAPIKeys.id]).toInt(),
      code: json[GetCouponAPIKeys.code],
      campaignId: json[GetCouponAPIKeys.campaignId].toInt(),
      description: json[GetCouponAPIKeys.description],
      channel: json[GetCouponAPIKeys.channel],
      clicksNo: json[GetCouponAPIKeys.clicksNo].toInt(),
    );
  }
//
}

class GetCouponAPIKeys{
  static const String status = "status";
  static const String id = "id";
  static const String code = "code";
  static const String campaignId = "campaign_id";
  static const String description = "description";
  static const String channel = "channel";
  static const String clicksNo = "clicks_no";
  static const String data = "data";
}

// "get_coupon": {
// "status": 200,
// "data": {
// "id": 1,
// "code": "2ih287nh1",
// "campaign_id": 1,
// "description": "50% off, one time only!",
// "channel": "home",
// "clicks_no": 0
// }
// },