import 'package:ecommerce/apiServices/urls.dart';
import 'package:ecommerce/views/helper/utils.dart';
import 'package:ecommerce/views/provider/categoryProvider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'cartpage.dart';
import 'helper/navigation.dart';
import 'provider/cartProvider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedIndex = 0;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      await getContext().read<CategoryProvider>().fetchProductdetails();
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "  Deliver to:",
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.red,
                  size: 18.sp,
                ),
                Text(
                  "My shop",
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite_border,
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
      body: Consumer<CategoryProvider>(builder: (context, provider, child) {
        return provider.productDetailsModel != null
            ? ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    child: Container(
                        height: 300.h,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey.shade300,
                                  size: 18.sp,
                                ),
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    selectedIndex = index;

                                    setState(() {});
                                  },
                                  aspectRatio: 1.0,
                                  enlargeCenterPage: false,
                                  viewportFraction: 1.0,
                                  scrollDirection: Axis.horizontal,
                                  autoPlay: true,
                                ),
                                items: provider.productDetailsModel!
                                    .productdetails.first.images
                                    .map((item) => Container(
                                          child: Center(
                                              child: Image.network(
                                                  Urls.IMAGE_URL + item,
                                                  fit: BoxFit.contain,
                                                  width: 1000)),
                                        ))
                                    .toList()
                                    .cast<Widget>(),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: Indicator(
                      length: provider.productDetailsModel!.productdetails.first
                          .images.length,
                      activeIndex: selectedIndex,
                      images: provider
                          .productDetailsModel!.productdetails.first.images,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                provider.productDetailsModel!.productdetails
                                    .first.productName,
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            SizedBox(
                                width:
                                    10.0), // Add space between text and rating
                            RatingBar.builder(
                              initialRating: provider
                                  .productDetailsModel!.rating
                                  .toDouble(), // Initial rating value
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: provider.productDetailsModel!.rating,
                              itemSize: 20.0,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.greenAccent,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating); // Use the rating as needed
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          provider.productDetailsModel!.productdetails.first
                              .description,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400)),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Exclusive Launch offer',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400)),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '₹ ${provider.productDetailsModel!.productdetails.first.offerPrice}',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Text(
                                      '  ${provider.productDetailsModel!.productdetails.first.price}',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    Text(
                                      '  10% off',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 13.sp,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_offer_outlined,
                                      size: 18.sp,
                                    ),
                                    Text(
                                      ' Get assured',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    Text(
                                      ' 10% cash back',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Text(
                                      ' for every offer',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.red,
                                  size: 18.sp,
                                ),
                                Text(
                                  "My shop ,25/2246 kalamassery",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                            Text(
                              ' Change',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(color: Colors.grey)), // Border color
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Available coupons for you',
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight
                                            .w500)), // Button text color
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 18.sp,
                              ), // Suffix arrow icon
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50.h,
                                child: OutlinedButton(
                                  onPressed: () {
                                    getContext()
                                        .read<CartProvider>()
                                        .setProductId(provider
                                            .productDetailsModel!
                                            .productdetails
                                            .first
                                            .id);
                                    getContext()
                                        .read<CartProvider>()
                                        .addToCart();
                                  },
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all<BorderSide>(
                                        BorderSide(
                                            color:
                                                Colors.grey)), // Border color
                                  ),
                                  child: Text(
                                    'Add to cart',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight
                                                .w600)), // Button text color
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Container(
                                height: 50.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Add your button onPressed logic here
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xffD8BE11)),
                                  ),
                                  child: Text(
                                    'But now',
                                    style: GoogleFonts.lato(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            : Container();
      }),
    );
  }
}

class Indicator extends StatelessWidget {
  final int length;
  final int activeIndex;
  final List<dynamic> images;

  Indicator(
      {required this.length, required this.activeIndex, required this.images});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: images
          .asMap()
          .map((index, i) {
            return MapEntry(
                index,
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: index == activeIndex ? 22.0 : 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: index == activeIndex ? Colors.red : Colors.grey),
                ));
          })
          .values
          .toList(),
    );
  }
}
