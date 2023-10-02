class CreateOrderResponse{
  final int status;

  const CreateOrderResponse({required this.status,});

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponse(
      status: json[CreateOrderAPIKeys.status].toInt(),
    );
  }
}

class CreateOrderAPIKeys {
  static const String status = "status";
  static const String code = "code";
}
