// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
    bool error;
    List<Productdetail> productdetails;
    int rating;
    String message;

    ProductDetailsModel({
        required this.error,
        required this.productdetails,
        required this.rating,
        required this.message,
    });

    factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
        error: json["error"],
        productdetails: List<Productdetail>.from(json["productdetails"].map((x) => Productdetail.fromJson(x))),
        rating: json["rating"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "productdetails": List<dynamic>.from(productdetails.map((x) => x.toJson())),
        "rating": rating,
        "message": message,
    };
}

class Productdetail {
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
    int catId;
    List<String> images;

    Productdetail({
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
        required this.catId,
        required this.images,
    });

    factory Productdetail.fromJson(Map<String, dynamic> json) => Productdetail(
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
        catId: json["cat_id"],
        images: List<String>.from(json["images"].map((x) => x)),
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
        "cat_id": catId,
        "images": List<dynamic>.from(images.map((x) => x)),
    };
}
