import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/product/product_card.dart';
import '../../../constants.dart';
import '../../product/views/product_details_screen.dart';
import '../controller.dart';
// Import the controller

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookmarkController bookmarkController = Get.put(BookmarkController());  // Get the controller

    return Scaffold(
      body: Obx(() => bookmarkController.bookmarkedProducts.isEmpty
          ? Center(child: Text('No bookmarked products'))
          : CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: defaultPadding,
                crossAxisSpacing: defaultPadding,
                childAspectRatio: 0.66,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  var product = bookmarkController.bookmarkedProducts[index];

                  return ProductCard(
                    image: product.image,
                    brandName: product.brandName,
                    title: product.title,
                    price: product.price,
                    priceAfetDiscount: product.priceAfetDiscount,
                    dicountpercent: product.dicountpercent,
                    press: () {
                      //Navigator.pushNamed(context, productDetailsScreenRoute, arguments: product,p);
                      Get.to(()=> ProductDetailsScreen(product: product,));
                    },
                    onPressed: (){
                      bookmarkController.toggleBookmark(product);
                    },
                    isTrue: true,
                  );
                },
                childCount: bookmarkController.bookmarkedProducts.length,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
