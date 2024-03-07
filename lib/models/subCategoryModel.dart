// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) => SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
    bool error;
    List<Subcategorylist> subcategorylist;
    String message;

    SubCategoryModel({
        required this.error,
        required this.subcategorylist,
        required this.message,
    });

    factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
        error: json["error"],
        subcategorylist: List<Subcategorylist>.from(json["subcategorylist"].map((x) => Subcategorylist.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "subcategorylist": List<dynamic>.from(subcategorylist.map((x) => x.toJson())),
        "message": message,
    };
}

class Subcategorylist {
    int id;
    String categoryName;
    int catId;
    dynamic image;
    DateTime createdAt;
    DateTime updatedAt;
    int status;

    Subcategorylist({
        required this.id,
        required this.categoryName,
        required this.catId,
        required this.image,
        required this.createdAt,
        required this.updatedAt,
        required this.status,
    });

    factory Subcategorylist.fromJson(Map<String, dynamic> json) => Subcategorylist(
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
