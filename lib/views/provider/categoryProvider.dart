import 'dart:developer';

import 'package:ecommerce/models/categoryModel.dart';
import 'package:ecommerce/models/productDetailsModel.dart';
import 'package:ecommerce/models/productModel.dart';
import 'package:ecommerce/models/searchModel.dart';
import 'package:ecommerce/views/helper/navigation.dart';
import 'package:ecommerce/views/helper/utils.dart';
import 'package:ecommerce/views/repo/categoryRepo.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  CategoryModel? categoryModel;
  ProductModel? productModel;
  SearchModel? searchModel;
  ProductDetailsModel? productDetailsModel;
  CategoryRepo categoryRepo = CategoryRepo();
  int paginationIndex = 1;
  int? productId;
  String? search;

  setSearch(String text) {
    this.search = text;
  }

  paginate() {
    paginationIndex++;
    log(".................." + paginationIndex.toString());
    fetchProductlist();
  }

  setProductId(int id) {
    this.productId = id;
  }

  fetchCategorylist() async {
    showLoading(getContext());
    await categoryRepo.getCategorylist();
    NavigationUtils.goBack(getContext());
  }

  fetchProductlist() async {
    showLoading(getContext());
    await categoryRepo.getProductList(paginationIndex);
    NavigationUtils.goBack(getContext());
  }

  fetchSearchlist() async {
    showLoading(getContext());
    await categoryRepo.getSearchList(paginationIndex);
    NavigationUtils.goBack(getContext());
  }

  setCategoryList(CategoryModel model) {
    this.categoryModel = model;
    notifyListeners();
  }

  setProductList(ProductModel model) {
    if (this.productModel == null) {
      this.productModel = model;
    } else {
      this.productModel!.product.addAll(model.product);
    }

    notifyListeners();
  }

  fetchProductdetails() async {
    showLoading(getContext());
    await categoryRepo.getProductDetails();
    NavigationUtils.goBack(getContext());
  }

  setProductDetails(ProductDetailsModel model) {
    this.productDetailsModel = model;
    notifyListeners();
  }

  setSearchList(SearchModel model) {
    this.searchModel = model;
    notifyListeners();
  }
}
