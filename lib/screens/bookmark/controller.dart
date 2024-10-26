import 'package:get/get.dart';


import '../../models/product_model.dart';

class BookmarkController extends GetxController {
  // List to store bookmarked products
  var bookmarkedProducts = <ProductModel>[].obs;

  // Add or remove a product from bookmarks
  void toggleBookmark(ProductModel product) {
    if (bookmarkedProducts.contains(product)) {
      bookmarkedProducts.remove(product);
    } else {
      bookmarkedProducts.add(product);
    }
  }

  // Check if a product is bookmarked
  bool isBookmarked(ProductModel product) {
    return bookmarkedProducts.contains(product);
  }
}
