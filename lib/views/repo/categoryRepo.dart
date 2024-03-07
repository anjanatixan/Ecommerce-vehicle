import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce/apiServices/urls.dart';
import 'package:ecommerce/apiServices/webService.dart';
import 'package:ecommerce/models/brandModel.dart';
import 'package:ecommerce/models/categoryModel.dart';
import 'package:ecommerce/models/categoryProductModel.dart';
import 'package:ecommerce/models/productDetailsModel.dart';
import 'package:ecommerce/models/productModel.dart';
import 'package:ecommerce/models/searchModel.dart';
import 'package:ecommerce/models/subCategoryModel.dart';
import 'package:ecommerce/views/helper/utils.dart';
import 'package:ecommerce/views/provider/categoryProvider.dart';
import 'package:provider/provider.dart';

class CategoryRepo {
  ApiService _service = ApiService();

  Future<String> getCategorylist() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    final response = await _service.getResponse(Urls.CATEGORY, headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      CategoryModel model = CategoryModel.fromJson(responseBody);
      getContext().read<CategoryProvider>().setCategoryList(model);
      log("message" + responseBody.toString());
    } else {}
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
    } else {}
    return "";
  }

 

  Future<String> getSearchList(int paginationIndex) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var body = jsonEncode({
      "productname": getContext().read<CategoryProvider>().search,
      "index": paginationIndex,
    });
    final response = await _service.postResponse(Urls.SEARCH, body, headers);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      SearchModel model = SearchModel.fromJson(responseBody);
      getContext().read<CategoryProvider>().setSearchList(model);
      log("message" + responseBody.toString());
    } else {}
    return "";
  }

  Future<String> getProductDetails() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var body = jsonEncode(
        {"productid": getContext().read<CategoryProvider>().productId});
    final response =
        await _service.postResponse(Urls.PRODUCT_DETAILS, body, headers);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      ProductDetailsModel model = ProductDetailsModel.fromJson(responseBody);
      getContext().read<CategoryProvider>().setProductDetails(model);
      log("message" + responseBody.toString());
    } else {}
    return "";
  }

  Future<String> getSubCategory() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var body =
        jsonEncode({"cat_id": getContext().read<CategoryProvider>().catId});
    log("message" + getContext().read<CategoryProvider>().catId.toString());
    final response =
        await _service.postResponse(Urls.SUBCATEGORY, body, headers);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      SubCategoryModel model = SubCategoryModel.fromJson(responseBody);
      getContext().read<CategoryProvider>().setSubcategory(model);
      log("message" + responseBody.toString());
    } else {}
    return "";
  }


  Future<String> getBrandList() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var body =
        jsonEncode({"subcat_id": getContext().read<CategoryProvider>().subCategoryId});
    log("message" + getContext().read<CategoryProvider>().subCategoryId.toString());
    final response =
        await _service.postResponse(Urls.BRANDlIST, body, headers);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      BrandModel model = BrandModel.fromJson(responseBody);
      getContext().read<CategoryProvider>().setBrandList(model);
      log("message" + responseBody.toString());
    } else {}
    return "";
  }

    Future<String> getCategoryProduct(int paginationIndex) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var body = jsonEncode({
      "categoryid": getContext().read<CategoryProvider>().subCategoryId,
      "index": paginationIndex,
    });
    final response = await _service.postResponse(Urls.CATEGORYPRODUCT, body, headers);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      CategoryProductModel model = CategoryProductModel.fromJson(responseBody);
      getContext().read<CategoryProvider>().setCategoryProduct(model);
      log("message" + responseBody.toString());
    } else {}
    return "";
  }

  Future<String> getFilterProductList(int paginationIndex) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var body = jsonEncode({
      "brand_id":getContext().read<CategoryProvider>().brandId,
      "index": paginationIndex,
    });
    log(getContext().read<CategoryProvider>().brandId.toString());
    final response = await _service.postResponse(Urls.FILTERDATA, body, headers);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      ProductModel model = ProductModel.fromJson(responseBody);
      getContext().read<CategoryProvider>().setProductList(model);
      log("message" + responseBody.toString());
    } else {}
    return "";
  }
}
