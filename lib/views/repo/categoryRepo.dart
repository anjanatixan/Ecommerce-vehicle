import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce/apiServices/urls.dart';
import 'package:ecommerce/apiServices/webService.dart';
import 'package:ecommerce/models/categoryModel.dart';
import 'package:ecommerce/models/productDetailsModel.dart';
import 'package:ecommerce/models/productModel.dart';
import 'package:ecommerce/views/helper/utils.dart';
import 'package:ecommerce/views/provider/categoryProvider.dart';
import 'package:provider/provider.dart';

class CategoryRepo{
   ApiService _service = ApiService();

  Future<String> getCategorylist() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    final response = await _service.getResponse(
        Urls.CATEGORY, headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      CategoryModel model = CategoryModel.fromJson(responseBody);
      getContext().read<CategoryProvider>().setCategoryList(model);
      log("message" + responseBody.toString());
    } else {
     
    }
    return "";
  }

  Future<String> getProductList(int paginationIndex) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var body = jsonEncode({
      "index": paginationIndex,
    
    });
    final response = await _service.postResponse(Urls.PRODUCT, body, headers);
log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      ProductModel model = ProductModel.fromJson(responseBody);
      getContext().read<CategoryProvider>().setProductList(model);
      log("message" + responseBody.toString());
    } else {
       
    }
    return "";
  }


   Future<String> getProductDetails() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var body = jsonEncode({
     "productid":getContext().read<CategoryProvider>().productId
    
    });
    final response = await _service.postResponse(Urls.PRODUCT_DETAILS, body, headers);
log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      ProductDetailsModel model = ProductDetailsModel.fromJson(responseBody);
      getContext().read<CategoryProvider>().setProductDetails(model);
      log("message" + responseBody.toString());
    } else {
       
    }
    return "";
  }
}