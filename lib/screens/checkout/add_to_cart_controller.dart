import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/address_model.dart';
import '../../models/product_model.dart';

class AddToCartController extends GetxController {
  var cartItems = <ProductModel>[].obs; // List of cart items
  var quantity = 1.obs;  // Reactive quantity for single product
  var selectedColor = 0.obs;
  var selectedSize = 0.obs;


  double unitPrice = 0.0;  // Initialize with product's unit price
  var totalPrice = 0.0.obs; // Reactive total price
  var quantities = <int>[].obs; // Reactive quantities list for cart items

  // Delivery charge and location variables
  var deliveryCharge = 50.0.obs; // Default delivery charge
  var deliveryLocation = "Inside Dhaka".obs;
  var paymentMethod = 'Cash on Delivery'.obs; // Default payment method

  var orders = <ProductModel>[].obs;  // Track successfully purchased products

  void completeOrder() {
    orders.addAll(cartItems);  // Add all cart items to orders
    cartItems.clear();         // Clear the cart
    //updateTotalPrice();
  }

  // Method to update delivery charge based on selection

  Rx<Address?> address = Rx<Address?>(null);

  // Text controllers for the address fields
  final nameController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();

  // Method to populate text fields with the current address
  void loadAddressToFields() {
    if (address.value != null) {
      nameController.text = address.value!.name;
      streetController.text = address.value!.street;
      cityController.text = address.value!.city;
      zipCodeController.text = address.value!.zipCode;
    }
  }

  // Method to save the address
  void saveAddress(Address newAddress) {
    address.value = newAddress;
  }

  // Clean up controllers
  @override
  void onClose() {
    nameController.dispose();
    streetController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    super.onClose();
  }


  // Computed property to return the total item count in the cart
  int get itemCount => cartItems.length;

  // Method to add an item to the cart
  void addItem(ProductModel product) {
    cartItems.add(product);
  }

  // Method to remove an item from the cart
  void removeItem(ProductModel product) {
    cartItems.remove(product);
  }

  // Method to set the unit price (you can call this when the product is loaded)
  void setUnitPrice(double price) {
    unitPrice = price;
    calculateTotalPrice();  // Calculate total price initially
  }

  // Method to calculate the total price for a single product based on quantity and unit price
  void calculateTotalPrice() {
    totalPrice.value = unitPrice * quantity.value;
  }



  // Increment product quantity (on product details screen) and recalculate price
  void incrementQuantity() {
    quantity.value++;
    calculateTotalPrice();
  }

  // Decrement product quantity (on product details screen) and recalculate price
  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
      calculateTotalPrice();
    }
  }

  // Select color
  void selectColor(int index) {
    selectedColor.value = index;
  }

  // Select size
  void selectSize(int index) {
    selectedSize.value = index;
  }

  // Add to cart logic
  void addToCart(ProductModel product) {
    if (product.id == null) {
      print('Product ID is null. Cannot add to cart.');
      return;
    }
    int index = cartItems.indexWhere((item) => item.id == product.id);
    if (index == -1) {
      cartItems.add(product);
      quantities.add(quantity.value);
    } else {
      quantities[index]++;
    }
    calculateTotalPrice2();
  }


  // Remove a product from the cart
  void removeFromCart(ProductModel product) {
    int index = cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      cartItems.removeAt(index);
      quantities.removeAt(index);
    }
    calculateTotalPrice2(); // Recalculate total for all cart items
  }

  // Increment quantity for a product and recalculate total price
  void incrementQuantity2(int index) {
    quantities[index]++;
    calculateTotalPrice2(); // Recalculate total for all cart items
  }

  // Decrement quantity for a product and recalculate total price
  void decrementQuantity2(int index) {
    if (quantities[index] > 1) {
      quantities[index]--;
      calculateTotalPrice2(); // Recalculate total for all cart items
    }
  }

  // Calculate total price including delivery charge for all cart items
  /*
  void calculateTotalPrice2() {
    double total = 0.0;
    for (int i = 0; i < cartItems.length; i++) {
      double price = cartItems[i].priceAfetDiscount?.toDouble() ?? cartItems[i].price.toDouble();
      total += price * quantities[i];
    }
    totalPrice.value = total + deliveryCharge.value;
  }*/

  void calculateTotalPrice2() {
    double subtotal = 0.0;
    for (int i = 0; i < cartItems.length; i++) {
      final price = cartItems[i].priceAfetDiscount?.toDouble() ?? cartItems[i].price.toDouble();
      subtotal += price * quantities[i];
    }
    totalPrice.value = subtotal + deliveryCharge.value;
  }

  // Method to update delivery charge based on selected location
  void updateDeliveryCharge(String location) {
    deliveryLocation.value = location;
    deliveryCharge.value = (location == 'Inside Dhaka') ? 50.0 : 120.0; // Change delivery charge based on location
    calculateTotalPrice2(); // Recalculate the total price whenever delivery charge changes
  }
}
