import 'package:maslaha/core/home_layout/view_model/home_layout_cubit.dart';

class GetCategoriesResponse {
  final int status;
  final List<ListCategory> categories;

  const GetCategoriesResponse({required this.status, required this.categories});

  factory GetCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return GetCategoriesResponse(
      status: json[GetCategoriesAPIKeys.status].toInt(),
      categories: (json[GetCategoriesAPIKeys.data] as List<dynamic>)
          .map((category) => ResponseCategory.fromJson(category))
          .toList(),
    );
  }
//
}

class ResponseCategory extends ListCategory{

  ResponseCategory({required super.id, super.categoryName});

  factory ResponseCategory.fromJson(Map<String, dynamic> json) {
    return ResponseCategory(
      id: json[GetCategoriesAPIKeys.id],
      categoryName: json[GetCategoriesAPIKeys.category],
    );
  }
}

class GetCategoriesAPIKeys {
  static const String category = "category";
  static const String id = "id";
  static const String status = "status";
  static const String data = "data";
}
