import 'package:ecommerce/apiServices/urls.dart';
import 'package:ecommerce/models/subCategoryModel.dart';
import 'package:ecommerce/views/helper/navigation.dart';
import 'package:ecommerce/views/provider/categoryProvider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:provider/provider.dart';
import 'cartpage.dart';
import 'helper/utils.dart';
import 'productDetails.dart';
import 'provider/cartProvider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _searchController = TextEditingController();
  int selectedIndex = -1;
  String? _selectedOption;
  final ScrollController controller = ScrollController();
  var searched = false;
  var filtered = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      selectedIndex = -1;
      getContext().read<CategoryProvider>().paginationIndex = 1;
      getContext().read<CategoryProvider>().productModel!.product = [];
      searched = false;
      filtered = false;

      await getContext().read<CategoryProvider>().fetchProductlist();
    });
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.offset) {
        print('listening here');

        await getContext().read<CategoryProvider>().paginate();
      }
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
          "Featured Products",
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
      body: ListView(controller: controller, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45.h,
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (searchtext) async {
                    if (searchtext.isEmpty) {
                      getContext().read<CategoryProvider>().paginationIndex = 1;
                      searched = false;
                      setState(() {});
                      getContext()
                          .read<CategoryProvider>()
                          .productModel!
                          .product = [];
                      await getContext()
                          .read<CategoryProvider>()
                          .fetchProductlist();
                    } else {
                      await getContext()
                          .read<CategoryProvider>()
                          .setSearch(searchtext);
                      getContext().read<CategoryProvider>().paginationIndex = 1;
                      await getContext()
                          .read<CategoryProvider>()
                          .fetchSearchlist();
                      searched = true;
                      setState(() {});
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    hintText: 'Search ',
                    hintStyle: GoogleFonts.lato(fontSize: 13.sp),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 70.h,
                child: Row(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              selectedIndex = -1;
                              getContext()
                                  .read<CategoryProvider>()
                                  .paginationIndex = 1;
                              getContext()
                                  .read<CategoryProvider>()
                                  .productModel!
                                  .product = [];
                              searched = false;
                              filtered = false;
                            });

                            await getContext()
                                .read<CategoryProvider>()
                                .fetchProductlist();
                          },
                          child: Container(
                            width: 60.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                "All \nProducts",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CircleAvatar(
                          radius: 2,
                          backgroundColor: selectedIndex == -1
                              ? Colors.red
                              : Colors.transparent,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Consumer<CategoryProvider>(
                      builder: (context, provider, child) {
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                provider.categoryModel!.categorylist.length,
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 0),
                                child: InkWell(
                                  onTap: () async {
                                    _selectedOption = null;
                                    getContext()
                                        .read<CategoryProvider>()
                                        .subCategoryId = null;
                                    setState(() {
                                      selectedIndex = index;
                                      searched = false;
                                    });
                                    await getContext()
                                        .read<CategoryProvider>()
                                        .setCatId(provider.categoryModel!
                                            .categorylist[selectedIndex].id);
                                    await getContext()
                                        .read<CategoryProvider>()
                                        .fetchSubCategory();
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 60.w,
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Container(
                                          height: 30.h,
                                          width: 35.w,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Image(
                                                image: NetworkImage(
                                                    Urls.IMAGE_URL +
                                                        provider
                                                            .categoryModel!
                                                            .categorylist[index]
                                                            .image)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      CircleAvatar(
                                        radius: 2,
                                        backgroundColor: selectedIndex == index
                                            ? Colors.red
                                            : Colors.transparent,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              selectedIndex == -1
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text('Shop by subcategory',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                        Consumer<CategoryProvider>(
                            builder: (context, provider, child) {
                          // final List<Subcategorylist> subcategoryNames = provider.subCategoryModel!.subcategorylist;
                          return provider.subCategoryModel != null
                              ? Container(
                                  height: 30.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey), // Border color
                                    borderRadius: BorderRadius.circular(
                                        5.0), // Border radius
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      value: _selectedOption,
                                      hint: Text("Select",
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          )),
                                      onChanged: (String? newValue) async {
                                        setState(() {
                                          _selectedOption = newValue ?? '';
                                        });
                                        await getContext()
                                            .read<CategoryProvider>()
                                            .setSubCategoryId(
                                                int.parse(newValue.toString()));
                                        getContext()
                                            .read<CategoryProvider>()
                                            .paginationIndex = 1;
                                        filtered = true;
                                        setState(() {});
                                        await getContext()
                                            .read<CategoryProvider>()
                                            .fetchCategoryProductlist();
                                      },
                                      items: provider
                                          .subCategoryModel!.subcategorylist
                                          .map((Subcategorylist subcategory) {
                                        return DropdownMenuItem<String>(
                                          value: subcategory.id
                                              .toString(), // Assuming id is unique
                                          child: Text(
                                            subcategory.categoryName,
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                )
                              : Container();
                        }),
                      ],
                    ),
              selectedIndex == -1
                  ? Container()
                  : SizedBox(
                      height: 10.h,
                    ),
            ],
          ),
        ),
        selectedIndex == -1
            ? Container()
            : InkWell(
                onTap: () async {
                  getContext().read<CategoryProvider>().fetchBrandList();
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return MyBottomSheet();
                    },
                  );
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 90.w,
                    height: 30.h,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_list,
                          size: 18.sp,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10.0),
                        Text('Filter',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
        SizedBox(
          height: 10.h,
        ),
        Consumer<CategoryProvider>(builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
                selectedIndex == -1
                    ? 'All products'
                    : provider
                        .categoryModel!.categorylist[selectedIndex].categoryName
                        .toString(),
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                )),
          );
        }),
        searched == true
            ? search()
            : filtered == true
                ? filteredData()
                : allProducts()
      ]),
    );
  }

  Consumer<CategoryProvider> filteredData() {
    return Consumer<CategoryProvider>(builder: (context, provider, child) {
      return provider.categoryProductModel != null
          ? provider.categoryProductModel!.productlist.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 8.0, // Spacing between columns
                        mainAxisSpacing: 8.0, // Spacing between rows
                      ),
                      itemCount: provider.categoryProductModel!.productlist
                          .length, // Number of items in the grid
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () async {
                              await getContext()
                                  .read<CategoryProvider>()
                                  .setProductId(provider.categoryProductModel!
                                      .productlist[index].id);
                              NavigationUtils.goNext(context, ProductDetails());
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: 110.w,
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
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
                                                  provider
                                                      .categoryProductModel!
                                                      .productlist[index]
                                                      .images,
                                              width: 80.w,
                                              height: 80.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            provider.categoryProductModel!
                                                .productlist[index].productName,
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Rs. ${provider.categoryProductModel!.productlist[index].price.toString()} ",
                                                      style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontSize: 10.sp,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Text(
                                                        "Rs. ${provider.categoryProductModel!.productlist[index].offerPrice} ",
                                                        style: GoogleFonts.lato(
                                                            textStyle: TextStyle(
                                                                fontSize: 10.sp,
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
                                                      style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontSize: 10.sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      size: 16.sp,
                                                      color: Colors.greenAccent,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }),
                )
              : Container(
                  height: 200,
                  child: Center(
                    child: Text("No data found"),
                  ),
                )
          : Container();
    });
  }

  Consumer<CategoryProvider> search() {
    return Consumer<CategoryProvider>(builder: (context, provider, child) {
      return provider.searchModel != null
          ? provider.searchModel!.product.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 8.0, // Spacing between columns
                        mainAxisSpacing: 8.0, // Spacing between rows
                      ),
                      itemCount: provider.searchModel!.product
                          .length, // Number of items in the grid
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () async {
                              await getContext()
                                  .read<CategoryProvider>()
                                  .setProductId(
                                      provider.searchModel!.product[index].id);
                              NavigationUtils.goNext(context, ProductDetails());
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: 110.w,
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
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
                                                  provider.searchModel!
                                                      .product[index].images,
                                              width: 80.w,
                                              height: 80.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            provider.searchModel!.product[index]
                                                .productName,
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Rs. ${provider.searchModel!.product[index].price.toString()} ",
                                                      style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontSize: 10.sp,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Text(
                                                        "Rs. ${provider.searchModel!.product[index].offerPrice} ",
                                                        style: GoogleFonts.lato(
                                                            textStyle: TextStyle(
                                                                fontSize: 10.sp,
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
                                                      style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontSize: 10.sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      size: 16.sp,
                                                      color: Colors.greenAccent,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }),
                )
              : Container(
                  height: 200,
                  child: Center(
                    child: Text("No data found"),
                  ),
                )
          : Container();
    });
  }

  Consumer<CategoryProvider> allProducts() {
    return Consumer<CategoryProvider>(builder: (context, provider, child) {
      return provider.productModel!.product.length != 0
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 8.0, // Spacing between columns
                    mainAxisSpacing: 8.0, // Spacing between rows
                  ),
                  itemCount: provider.productModel!.product
                      .length, // Number of items in the grid
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () async {
                          await getContext()
                              .read<CategoryProvider>()
                              .setProductId(
                                  provider.productModel!.product[index].id);
                          NavigationUtils.goNext(context, ProductDetails());
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 110.w,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
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
                                              provider.productModel!
                                                  .product[index].images,
                                          width: 80.w,
                                          height: 80.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        provider.productModel!.product[index]
                                            .productName,
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Rs. ${provider.productModel!.product[index].price.toString()} ",
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 10.sp,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Text(
                                                    "Rs. ${provider.productModel!.product[index].offerPrice} ",
                                                    style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontSize: 10.sp,
                                                            color: Colors.black,
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
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 16.sp,
                                                  color: Colors.greenAccent,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                  }),
            )
          : Container(
              height: 200,
              child: Center(
                child: Text("No data found"),
              ),
            );
    });
  }

  MyBottomSheet() {
    return Consumer<CategoryProvider>(builder: (context, provider, child) {
      return provider.brandModel != null
          ? provider.brandModel!.brandlist.length != 0
              ? Container(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Choose your brands",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )),
                        SizedBox(
                          height: 15.h,
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: provider.brandModel!.brandlist.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var datas = provider.brandModel!.brandlist[index];
                              return CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                dense: true,
                                activeColor: Colors.red,
                                checkColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12.0),
                                title: Text(
                                  datas.brandName.toString(),
                                  style: GoogleFonts.lato(
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                value: datas.selected,
                                onChanged: (bool? value) {
                                  // setState(() {
                                  //   datas.selected= value; // Update the selected state
                                  // });
                                  provider.selectBrandIndex(datas);
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10.h,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            searched = false;
                            filtered = false;
                            setState(() {});
                            getContext()
                                .read<CategoryProvider>()
                                .paginationIndex = 1;
                            getContext()
                                .read<CategoryProvider>()
                                .productModel!
                                .product = [];
                            await getContext()
                                .read<CategoryProvider>()
                                .fetchfilterProductlist();
                            NavigationUtils.goBack(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          child: Text(
                            'Apply filters',
                            style: GoogleFonts.lato(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 200,
                  child: Center(
                    child: Text("No data found"),
                  ),
                )
          : Container();
    });
  }
}
