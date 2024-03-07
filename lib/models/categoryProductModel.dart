// To parse this JSON data, do
//
//     final categoryProductModel = categoryProductModelFromJson(jsonString);

import 'dart:convert';

CategoryProductModel categoryProductModelFromJson(String str) => CategoryProductModel.fromJson(json.decode(str));

String categoryProductModelToJson(CategoryProductModel data) => json.encode(data.toJson());

class CategoryProductModel {
    bool error;
    List<Productlist> productlist;
    String message;

    CategoryProductModel({
        required this.error,
        required this.productlist,
        required this.message,
    });

    factory CategoryProductModel.fromJson(Map<String, dynamic> json) => CategoryProductModel(
        error: json["error"],
        productlist: List<Productlist>.from(json["productlist"].map((x) => Productlist.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "productlist": List<dynamic>.from(productlist.map((x) => x.toJson())),
        "message": message,
    };
}

class Productlist {
    int id;
    int brandId;
    String productName;
    int offerPrice;
    int price;
    String sellingRate;
    String sellingMrp;
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

    Productlist({
        required this.id,
        required this.brandId,
        required this.productName,
        required this.offerPrice,
        required this.price,
        required this.sellingRate,
        required this.sellingMrp,
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

    factory Productlist.fromJson(Map<String, dynamic> json) => Productlist(
        id: json["id"],
        brandId: json["brand_id"],
        productName: json["product_name"],
        offerPrice: json["offer_price"],
        price: json["price"],
        sellingRate: json["selling_rate"],
        sellingMrp: json["selling_mrp"],
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
        "selling_rate": sellingRate,
        "selling_mrp": sellingMrp,
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
