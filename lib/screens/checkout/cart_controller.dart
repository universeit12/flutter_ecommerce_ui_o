import 'package:get/get.dart';
import '../../../models/product_model.dart';

class CartController extends GetxController {
  // List to store cart items
  var cartItems = <ProductModel>[].obs;

  // Store quantity for each product in cart
  var quantities = <int>[].obs;

  // Store delivery charge
  var deliveryCharge = 50.0; // You can set any default value

  // Total price
  var totalPrice = 0.0.obs;

  // Add a product to the cart
  void addToCart(ProductModel product) {
    int index = cartItems.indexWhere((item) => item.brandName == product.brandName);
    if (index == -1) {
      // If product not in cart, add it
      cartItems.add(product);
      quantities.add(1);
    } else {
      // If product already exists, increase quantity
      quantities[index]++;
    }
    calculateTotalPrice();
  }

  // Remove a product from the cart
  void removeFromCart(ProductModel product) {
    int index = cartItems.indexWhere((item) => item.brandName == product.brandName);
    if (index != -1) {
      cartItems.removeAt(index);
      quantities.removeAt(index);
    }
    calculateTotalPrice();
  }

  // Increment product quantity
  void incrementQuantity(int index) {
    quantities[index]++;
    calculateTotalPrice();
  }

  // Decrement product quantity
  void decrementQuantity(int index) {
    if (quantities[index] > 1) {
      quantities[index]--;
      calculateTotalPrice();
    }
  }

  // Calculate total price including delivery charge
  void calculateTotalPrice() {
    double total = 0.0;
    for (int i = 0; i < cartItems.length; i++) {
      double price = cartItems[i].dicountpercent?.toDouble() ?? cartItems[i].price.toDouble();
      total += price * quantities[i];
    }
    totalPrice.value = total + deliveryCharge;
  }
}
