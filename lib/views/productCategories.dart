import 'package:ecommerce/views/helper/navigation.dart';
import 'package:ecommerce/views/provider/categoryProvider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:provider/provider.dart';
import '../apiServices/urls.dart';
import 'bottomBar.dart';
import 'cartpage.dart';
import 'helper/utils.dart';
import 'provider/bottomNavBarProvider.dart';
import 'provider/cartProvider.dart';

class ProductCategories extends StatefulWidget {
  const ProductCategories({super.key});

  @override
  State<ProductCategories> createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: OutlinedButton(
          onPressed: () {
            // Add your button onPressed logic here
          },
          style: ButtonStyle(
            side: MaterialStateProperty.all<BorderSide>(
                BorderSide(color: Colors.red)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: Text('View all products',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500))),
        ),
      ),
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
          "Product categories",
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
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
              Consumer<CartProvider>(
                builder: (context,provider,child) {
                  return Positioned(
                                            top: 5,
                                            right: 5,
                                            child: Container(
                                              child: Center(
                                                  child: FittedBox(
                                                child: Text(
                                                getContext().read<CartProvider>().cartCount.toString() ,
                                                    style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500))
                                                ),
                                              )),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(30)),
                                              height: 18,
                                              width: 18,
                                            ));
                }
              )
            ],
          ),
        ],
      ),
      body: Consumer<CategoryProvider>(builder: (context, provider, child) {
        return ListView(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Wrap(
                spacing: 15.0,
                runSpacing: 10.0,
                children: List.generate(
                  provider.categoryModel!.categorylist.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                       getContext()
                            .read<BottomNavigationBarProvider>()
                            .currentIndex = 2;
                        NavigationUtils.goNextFinishAll(context, BottomBar());
                      },
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(children: [
                            Container(
                                height: 50.h,
                                width: 35.w,
                                child: Image(
                                    image: NetworkImage(Urls.IMAGE_URL +
                                        provider.categoryModel!
                                            .categorylist[index].image))),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              provider.categoryModel!.categorylist[index]
                                  .categoryName,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
