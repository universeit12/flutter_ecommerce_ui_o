import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../models/address_model.dart';
import '../add_to_cart_controller.dart';
import 'review_screen.dart';

class CartScreen extends StatelessWidget {
  final AddToCartController cartController = Get.put(AddToCartController());

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (cartController.cartItems.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartController.cartItems[index];
                    final price = product.priceAfetDiscount?.toDouble() ?? product.price.toDouble();

                    return ListTile(
                      leading: Stack(
                        children: [
                          Image.network(product.image),
                          Positioned(
                            left: -10,
                            top: -13,
                            child: IconButton(
                              onPressed: () {
                                cartController.removeFromCart(product);
                              },
                              icon: const Icon(Icons.delete, size: 20),
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      title: Text(
                        product.title,
                        style: const TextStyle(fontSize: 14),
                      ),
                      subtitle: Obx(() => Row(
                        children: [
                          const Text("Price: "),
                          Text(
                            '৳ ${(price * cartController.quantities[index]).toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Decrement quantity button
                          IconButton(
                            onPressed: () {
                              cartController.decrementQuantity2(index);
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Obx(() => Text(cartController.quantities[index].toString())),
                          // Increment quantity button
                          IconButton(
                            onPressed: () {
                              cartController.incrementQuantity2(index);
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Order Summary and Delivery Charge Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Order Summary',
                        style: TextStyle(
                            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text('Subtotal:'),
                        const Spacer(),
                        Text(
                          '৳ ${cartController.totalPrice.value.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),



                    Row(
                      children: [
                        const Text(
                          'Delivery Charge:',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Obx(
                              () => Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center, // Centers the items closely together
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center, // Centers each item within its row
                                    children: [
                                      Transform.scale(
                                        scale: 0.6, // Reduce radio button size
                                        child: Radio<String>(
                                          value: "Inside Dhaka",
                                          groupValue: cartController.deliveryLocation.value,
                                          onChanged: (value) {
                                            if (value != null) {
                                              cartController.updateDeliveryCharge(value);
                                            }
                                          },
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(-4, 0), // Closer to the radio button
                                        child: const Text(
                                          'Inside',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center, // Centers each item within its row
                                    children: [
                                      Transform.scale(
                                        scale: 0.6,
                                        child: Radio<String>(
                                          value: "Outside Dhaka",
                                          groupValue: cartController.deliveryLocation.value,
                                          onChanged: (value) {
                                            if (value != null) {
                                              cartController.updateDeliveryCharge(value);
                                            }
                                          },
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(-4, 0),
                                        child: const Text(
                                          'Outside',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),





                        Obx(
                              () => Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '৳ ${cartController.deliveryCharge.value.toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),


                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => ReviewScreen());
                      },
                      child: const Text('Proceed to Checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
