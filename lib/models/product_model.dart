import 'dart:convert';

class ProductModel {
  bool? success;
  String? message;
  ProductData? data;

  ProductModel({
    this.success,
    this.message,
    this.data,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    data = (json['data'] as Map<String,dynamic>?) != null ? ProductData.fromJson(json['data'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['message'] = message;
    json['data'] = data?.toJson();
    return json;
  }
}

class ProductData {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;

  ProductData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
  });

  ProductData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] as int?;
    data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();
    firstPageUrl = json['first_page_url'] as String?;
    from = json['from'] as int?;
    nextPageUrl = json['next_page_url'];
    path = json['path'] as String?;
    perPage = json['per_page'] as int?;
    prevPageUrl = json['prev_page_url'];
    to = json['to'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['current_page'] = currentPage;
    json['data'] = data?.map((e) => e.toJson()).toList();
    json['first_page_url'] = firstPageUrl;
    json['from'] = from;
    json['next_page_url'] = nextPageUrl;
    json['path'] = path;
    json['per_page'] = perPage;
    json['prev_page_url'] = prevPageUrl;
    json['to'] = to;
    return json;
  }
}

class Data {
  int? id;
  String? image;
  String? name;
  int? price;
  int? sold;
  int? categoryId;
  String? description;
  String? reviewsAvgRating;

  Data({
    this.id,
    this.image,
    this.name,
    this.price,
    this.sold,
    this.categoryId,
    this.description,
    this.reviewsAvgRating,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    image = json['image'] as String?;
    name = json['name'] as String?;
    price = json['price'] as int?;
    sold = json['sold'] as int?;
    categoryId = json['category_id'] as int?;
    description = json['description'] as String?;
    reviewsAvgRating = json['reviews_avg_rating'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['image'] = image;
    json['name'] = name;
    json['price'] = price;
    json['sold'] = sold;
    json['category_id'] = categoryId;
    json['description'] = description;
    json['reviews_avg_rating'] = reviewsAvgRating;
    return json;
  }
}
