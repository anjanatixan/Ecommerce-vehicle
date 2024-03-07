import 'package:ecommerce/apiServices/urls.dart';
import 'package:ecommerce/views/helper/utils.dart';
import 'package:ecommerce/views/provider/cartProvider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:provider/provider.dart';

import 'helper/navigation.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      await getContext().read<CartProvider>().fetchCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              NavigationUtils.goBack(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 18.sp,
            )),
        title: Text(
          "My cart",
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
        ),
      ),
      body: Consumer<CartProvider>(builder: (context, provider, child) {
        return provider.cartModel != null
            ? ListView.builder(
                itemCount: provider.cartModel!.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              await getContext().read<CartProvider>().setCartId(
                                  provider.cartModel!.cart[index].id);
                              await getContext()
                                  .read<CartProvider>()
                                  .deleteCart();
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, right: 5),
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Color(0xffE80F0F),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 60.h,
                                    width: 80.w,
                                    child: Image(
                                      image: NetworkImage(Urls.IMAGE_URL +
                                          provider
                                              .cartModel!.cart[index].images),
                                      fit: BoxFit.cover,
                                    )),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          provider.cartModel!.cart[index]
                                              .productName,
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.grey,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                      Text(
                                        provider
                                            .cartModel!.cart[index].description,
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500)),
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '₹ ${provider.cartModel!.cart[index].offerPrice}',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Text(
                                            '  ${provider.cartModel!.cart[index].price}',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                          Text(
                                            '  10% off',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Color(0xffE80F0F),
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("  Qty: ",
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                      Row(
                                        children: [
                                          Text(
                                              provider
                                                  .cartModel!.cart[index].qty
                                                  .toString(),
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500))),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            size: 18.sp,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffE80F0F),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  // Add some top padding to reveal the border
                                  height: 30
                                      .h, // Assuming you're using height directly
                                  child: Center(
                                    child: Text(
                                      "Move to wishlist",
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : Container();
      }),
    );
  }
}
