// To parse this JSON data, do
//
//     final brandModel = brandModelFromJson(jsonString);

import 'dart:convert';

BrandModel brandModelFromJson(String str) => BrandModel.fromJson(json.decode(str));

String brandModelToJson(BrandModel data) => json.encode(data.toJson());

class BrandModel {
    bool error;
    List<Brandlist> brandlist;
    String message;

    BrandModel({
        required this.error,
        required this.brandlist,
        required this.message,
    });

    factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        error: json["error"],
        brandlist: List<Brandlist>.from(json["brandlist"].map((x) => Brandlist.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "brandlist": List<dynamic>.from(brandlist.map((x) => x.toJson())),
        "message": message,
    };
}

class Brandlist {
    int id;
    int catId;
    String brandName;
    int status;
    int vendorId;
    DateTime createdAt;
    DateTime updatedAt;
     bool selected; 

    Brandlist({
        required this.id,
        required this.catId,
        required this.brandName,
        required this.status,
        required this.vendorId,
        required this.createdAt,
        required this.updatedAt,
        this.selected = false,
    });

    factory Brandlist.fromJson(Map<String, dynamic> json) => Brandlist(
        id: json["id"],
        catId: json["cat_id"],
        brandName: json["brand_name"],
        status: json["status"],
        vendorId: json["vendor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        selected: json['selected'] ?? false,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "brand_name": brandName,
        "status": status,
        "vendor_id": vendorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "selected":selected
        
    };
}
