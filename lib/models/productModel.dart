// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    bool error;
    List<Product> product;
    String message;

    ProductModel({
        required this.error,
        required this.product,
        required this.message,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
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
    int tax;
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
        required this.tax,
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
        tax: json["tax"],
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
        "tax": tax,
        "images": images,
    };
}
