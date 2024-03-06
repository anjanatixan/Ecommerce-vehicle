import 'package:ecommerce/models/categoryModel.dart';
import 'package:ecommerce/models/productDetailsModel.dart';
import 'package:ecommerce/models/productModel.dart';
import 'package:ecommerce/views/helper/navigation.dart';
import 'package:ecommerce/views/helper/utils.dart';
import 'package:ecommerce/views/repo/categoryRepo.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier{
  CategoryModel? categoryModel;
  ProductModel? productModel;
  ProductDetailsModel? productDetailsModel;
  CategoryRepo categoryRepo=CategoryRepo();
  int paginationIndex=1;
  int? productId;

  setProductId(int id){
    this.productId=id;
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

   setCategoryList(CategoryModel model) {
    this.categoryModel = model;
    notifyListeners();
  }

    setProductList(ProductModel model) {
    this.productModel = model;
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
}