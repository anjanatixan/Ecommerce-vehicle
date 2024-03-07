// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
    bool error;
    List<Product> product;
    String message;

    SearchModel({
        required this.error,
        required this.product,
        required this.message,
    });

    factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        error: json["error"],
        product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "message": message,
    };
}

class Product {
    int id;
    int brandId;
    String productName;
    int offerPrice;
    int price;
    String description;
    int status;
    int hsncode;
    int priority;
    int prate;
    int noReturnDays;
    DateTime createdAt;
    DateTime updatedAt;
    String images;

    Product({
        required this.id,
        required this.brandId,
        required this.productName,
        required this.offerPrice,
        required this.price,
        required this.description,
        required this.status,
        required this.hsncode,
        required this.priority,
        required this.prate,
        required this.noReturnDays,
        required this.createdAt,
        required this.updatedAt,
        required this.images,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        brandId: json["brand_id"],
        productName: json["product_name"],
        offerPrice: json["offer_price"],
        price: json["price"],
        description: json["description"],
        status: json["status"],
        hsncode: json["hsncode"],
        priority: json["priority"],
        prate: json["prate"],
        noReturnDays: json["no_return_days"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        images: json["images"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "brand_id": brandId,
        "product_name": productName,
        "offer_price": offerPrice,
        "price": price,
        "description": description,
        "status": status,
        "hsncode": hsncode,
        "priority": priority,
        "prate": prate,
        "no_return_days": noReturnDays,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "images": images,
    };
}
