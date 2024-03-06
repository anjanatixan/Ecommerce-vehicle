import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce/apiServices/urls.dart';
import 'package:ecommerce/apiServices/webService.dart';
import 'package:ecommerce/models/cartModel.dart';
import 'package:ecommerce/views/cartpage.dart';
import 'package:ecommerce/views/helper/navigation.dart';
import 'package:ecommerce/views/helper/utils.dart';
import 'package:ecommerce/views/provider/cartProvider.dart';
import 'package:provider/provider.dart';

class CartRepo {
  ApiService _service = ApiService();

  Future<String> addToCart() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var body = jsonEncode({
      "shop_id": 1329,
      "product_id": getContext().read<CartProvider>().productId,
      "qty": 1
    });

    final response =
        await _service.postResponse(Urls.ADD_TO_CART, body, headers);
          NavigationUtils.goBack(getContext());
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
       NavigationUtils.goNext(getContext(), CartPage());
    
    } else {}
    return "";
  }


  Future<String> fetchCart() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var body = jsonEncode({
      "shop_id": 1329
     
    });

    final response =
        await _service.postResponse(Urls.MY_CART, body, headers);
        
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
       Map<String, dynamic> responseBody = jsonDecode(response.body);
      CartModel model = CartModel.fromJson(responseBody);
      getContext().read<CartProvider>().setCart(model);
      log("message" + responseBody.toString()); 
    
    } else {}
    return "";
  }

  Future<String> deleteCart() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var body = jsonEncode({
      "id": getContext().read<CartProvider>().cartId
     
    });

    final response =
        await _service.postResponse(Urls.DELETE_CART, body, headers);
        
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
       Map<String, dynamic> responseBody = jsonDecode(response.body);
     
      log("message" + responseBody.toString()); 
    await getContext().read<CartProvider>().fetchCart();
    } else {}
    return "";
  }
}
