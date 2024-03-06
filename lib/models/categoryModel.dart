// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    bool error;
    List<Categorylist> categorylist;
    String message;

    CategoryModel({
        required this.error,
        required this.categorylist,
        required this.message,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        error: json["error"],
        categorylist: List<Categorylist>.from(json["categorylist"].map((x) => Categorylist.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "categorylist": List<dynamic>.from(categorylist.map((x) => x.toJson())),
        "message": message,
    };
}

class Categorylist {
    int id;
    String categoryName;
    int catId;
    String image;
    DateTime createdAt;
    DateTime updatedAt;
    int status;

    Categorylist({
        required this.id,
        required this.categoryName,
        required this.catId,
        required this.image,
        required this.createdAt,
        required this.updatedAt,
        required this.status,
    });

    factory Categorylist.fromJson(Map<String, dynamic> json) => Categorylist(
        id: json["id"],
        categoryName: json["category_name"],
        catId: json["cat_id"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "cat_id": catId,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
    };
}
