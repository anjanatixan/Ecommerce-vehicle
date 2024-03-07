import 'dart:developer';

import 'package:ecommerce/models/brandModel.dart';
import 'package:ecommerce/models/categoryModel.dart';
import 'package:ecommerce/models/categoryProductModel.dart';
import 'package:ecommerce/models/productDetailsModel.dart';
import 'package:ecommerce/models/productModel.dart';
import 'package:ecommerce/models/searchModel.dart';
import 'package:ecommerce/models/subCategoryModel.dart';
import 'package:ecommerce/views/helper/navigation.dart';
import 'package:ecommerce/views/helper/utils.dart';
import 'package:ecommerce/views/repo/categoryRepo.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  CategoryModel? categoryModel;
  ProductModel? productModel;
  SearchModel? searchModel;
  ProductDetailsModel? productDetailsModel;
  SubCategoryModel? subCategoryModel;
  BrandModel? brandModel;
  CategoryProductModel? categoryProductModel;
  CategoryRepo categoryRepo = CategoryRepo();
  int paginationIndex = 1;
  int? productId;
  int? catId;
  int? subCategoryId;
  String? search;
  int? brandId;

  setBrandId(int id) {
    this.brandId = id;
  }

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

  setSubCategoryId(int id) {
    this.subCategoryId = id;
  }

  setCatId(int id) {
    this.catId = id;
    notifyListeners();
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

  fetchSubCategory() async {
    await categoryRepo.getSubCategory();
  }

  setSubcategory(SubCategoryModel model) {
    this.subCategoryModel = model;
    notifyListeners();
  }

  fetchBrandList() async {
    await categoryRepo.getBrandList();
  }

  setBrandList(BrandModel model) {
    this.brandModel = model;
    for (int i = 0; i < this.brandModel!.brandlist.length; i++) {
      this.brandModel!.brandlist[i].selected = false;
    }
    notifyListeners();
  }

  selectBrandIndex(var e) {
    int index =
        this.brandModel!.brandlist.indexWhere((element) => element == e);
    for (int i = 0; i < this.brandModel!.brandlist.length; i++) {
      this.brandModel!.brandlist[i].selected = false;
    }
    this.brandModel!.brandlist[index].selected =
        !this.brandModel!.brandlist[index].selected;
    if (this.brandModel!.brandlist[index].selected == true) {
      setBrandId(this.brandModel!.brandlist[index].id);
    } else {
      brandId = null;
    }
    notifyListeners();
  }

  fetchCategoryProductlist() async {
    showLoading(getContext());
    await categoryRepo.getCategoryProduct(paginationIndex);
    NavigationUtils.goBack(getContext());
  }

  setCategoryProduct(CategoryProductModel model) {
    this.categoryProductModel = model;
    notifyListeners();
  }

  fetchfilterProductlist() async {
    showLoading(getContext());
    await categoryRepo.getFilterProductList(paginationIndex);
    NavigationUtils.goBack(getContext());
  }
}
