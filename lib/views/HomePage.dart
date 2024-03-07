import 'package:ecommerce/views/helper/navigation.dart';
import 'package:ecommerce/views/helper/utils.dart';
import 'package:ecommerce/views/productDetails.dart';
import 'package:ecommerce/views/provider/bottomNavBarProvider.dart';
import 'package:ecommerce/views/provider/categoryProvider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:provider/provider.dart';
import '../apiServices/urls.dart';
import 'bottomBar.dart';
import 'cartpage.dart';
import 'productCategories.dart';
import 'provider/cartProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      await getContext().read<CategoryProvider>().fetchCategorylist();
      await getContext().read<CategoryProvider>().fetchProductlist();
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
        title: Text(
          "Good Morning!",
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_active_outlined,
              color: Colors.black,
              size: 18.sp,
            ),
            onPressed: () {},
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                    size: 18.sp,
                  ),
                  onPressed: () {
                    NavigationUtils.goNext(context, CartPage());
                  },
                ),
              ),
              Consumer<CartProvider>(builder: (context, provider, child) {
                return getContext().read<CartProvider>().cartCount != 0
                    ? Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          child: Center(
                              child: FittedBox(
                            child: Text(
                                getContext()
                                    .read<CartProvider>()
                                    .cartCount
                                    .toString(),
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))),
                          )),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30)),
                          height: 18,
                          width: 18,
                        ))
                    : Container();
              })
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Bookings",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600))),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade100,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Container(
                                  height: 35.h,
                                  width: 35.w,
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/calender.jpg"))),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text("View \nBookings",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Offers",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600))),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade100,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Container(
                                  height: 35.h,
                                  width: 35.w,
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/offer.jpg"))),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text("Add/view \nOffers",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Products categories",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500))),
                SizedBox(
                  height: 10.h,
                ),
                Consumer<CategoryProvider>(builder: (context, provider, child) {
                  return provider.categoryModel != null
                      ? Container(
                          height: 100,
                          child: Row(
                            children: [
                              ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Container(
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Column(children: [
                                            Container(
                                              height: 30.h,
                                              width: 35.w,
                                              child: Image(
                                                  image: NetworkImage(Urls
                                                          .IMAGE_URL +
                                                      provider
                                                          .categoryModel!
                                                          .categorylist[index]
                                                          .image)),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                provider
                                                    .categoryModel!
                                                    .categorylist[index]
                                                    .categoryName,
                                                style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    width: 5.w,
                                  );
                                },
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              InkWell(
                                onTap: () {
                                  NavigationUtils.goNext(
                                      context, ProductCategories());
                                },
                                child: Container(
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40, horizontal: 10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("View all",
                                                  style: GoogleFonts.lato(
                                                      textStyle: TextStyle(
                                                          fontSize: 10.sp,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .w500))),
                                              Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey.shade100,
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.black,
                                                    size: 12.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container();
                }),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Featured products",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500))),
                    InkWell(
                      onTap: () {
                        getContext()
                            .read<BottomNavigationBarProvider>()
                            .currentIndex = 2;
                        NavigationUtils.goNextFinishAll(context, BottomBar());
                      },
                      child: Text("View all",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Consumer<CategoryProvider>(
                    builder: (context, providers, child) {
                  return providers.productModel != null
                      ? Wrap(
                          spacing: 5.0,
                          runSpacing: 10.0,
                          children: List.generate(
                            6,
                            (index) {
                              return GestureDetector(
                                onTap: () async {
                                  await getContext()
                                      .read<CategoryProvider>()
                                      .setProductId(providers
                                          .productModel!.product[index].id);
                                  NavigationUtils.goNext(
                                      context, ProductDetails());
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 110.w,
                                    color: Colors.white,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.grey.shade300,
                                                  size: 18.sp,
                                                ),
                                              ),
                                              Center(
                                                child: Image.network(
                                                  Urls.IMAGE_URL +
                                                      providers
                                                          .productModel!
                                                          .product[index]
                                                          .images,
                                                  width: 75.w,
                                                  height: 75.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                providers.productModel!
                                                    .product[index].productName,
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        // Text(
                                                        //   "Rs. ${providers.productModel!.product[index].price.toString()} ",
                                                        //   style: GoogleFonts.lato(
                                                        //     textStyle: TextStyle(
                                                        //         fontSize: 10.sp,
                                                        //         decoration:
                                                        //             TextDecoration
                                                        //                 .lineThrough,
                                                        //         color: Colors.black,
                                                        //         fontWeight:
                                                        //             FontWeight.w500),
                                                        //   ),
                                                        // ),
                                                        Text(
                                                            "Rs. ${providers.productModel!.product[index].offerPrice}",
                                                            style: GoogleFonts.lato(
                                                                textStyle: TextStyle(
                                                                    fontSize:
                                                                        10.sp,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500))),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "4.5 ",
                                                          style:
                                                              GoogleFonts.lato(
                                                            textStyle: TextStyle(
                                                                fontSize: 10.sp,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          size: 16.sp,
                                                          color: Colors
                                                              .greenAccent,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).take(6).toList(),
                        )
                      : Container();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
