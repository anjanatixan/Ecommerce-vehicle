// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
    bool error;
    List<Cart> cart;
    String message;

    CartModel({
        required this.error,
        required this.cart,
        required this.message,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        error: json["error"],
        cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
        "message": message,
    };
}

class Cart {
    int id;
    int shopId;
    int productId;
    int qty;
    DateTime createdAt;
    DateTime updatedAt;
    int tax;
    int offerPrice;
    int price;
    String productName;
    String description;
    String images;

    Cart({
        required this.id,
        required this.shopId,
        required this.productId,
        required this.qty,
        required this.createdAt,
        required this.updatedAt,
        required this.tax,
        required this.offerPrice,
        required this.price,
        required this.productName,
        required this.description,
        required this.images,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        shopId: json["shop_id"],
        productId: json["product_id"],
        qty: json["qty"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        tax: json["tax"],
        offerPrice: json["offer_price"],
        price: json["price"],
        productName: json["product_name"],
        description: json["description"],
        images: json["images"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "product_id": productId,
        "qty": qty,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "tax": tax,
        "offer_price": offerPrice,
        "price": price,
        "product_name": productName,
        "description": description,
        "images": images,
    };
}
