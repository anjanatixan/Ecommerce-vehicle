import 'package:ecommerce/models/cartModel.dart';
import 'package:ecommerce/views/helper/navigation.dart';
import 'package:ecommerce/views/helper/utils.dart';
import 'package:ecommerce/views/repo/cartRepo.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier{
   int? productId;
   CartModel? cartModel;
   CartRepo cartRepo=CartRepo();
   int? cartId;
   int cartCount=0;
   
   setCartCount(int count){
    this.cartCount=count;
   }

   setCartId(int id){
    this.cartId=id;
   }

  setProductId(int id){
    this.productId=id;
  }

 addToCart() async {
    showLoading(getContext());
    await cartRepo.addToCart();
   
  }

  fetchCart() async {
    showLoading(getContext());
    await cartRepo.fetchCart();
   NavigationUtils.goBack(getContext());
  }

   setCart(CartModel model) {
    this.cartModel = model;
    cartCount=this.cartModel!.cart.length;
    
    notifyListeners();
  }

  deleteCart() async {
    showLoading(getContext());
    await cartRepo.deleteCart();
   NavigationUtils.goBack(getContext());
  }
}