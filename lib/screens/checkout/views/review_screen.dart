import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_to_cart_controller.dart';
import 'change_address_screen.dart';
import 'order_screen.dart';

class ReviewScreen extends StatelessWidget {
  final AddToCartController cartController = Get.find<AddToCartController>();

  ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Review Order"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Shipping Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    Get.to(() => ChangeAddressScreen());
                  },
                  child: cartController.address.value == null ? Text('Add Address') : Text('Change Address'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Obx(() {
              if (cartController.address.value == null) {
                return const Text("No address saved.");
              } else {
                final address = cartController.address.value!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${address.name}, ${address.city}, ${address.zipCode}'),
                    Text("${address.street},"),
                  ],
                );
              }
            }),
            const SizedBox(height: 30),

            // Order Summary Section
            const Text("Order Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Subtotal:', style: TextStyle(fontSize: 16)),
                const Spacer(),
                Obx(() => Text(
                  '৳ ${cartController.totalPrice.value.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text('Delivery Charge:', style: TextStyle(fontSize: 16)),
                const Spacer(),
                Text(
                  '৳ ${cartController.deliveryCharge.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Divider(height: 30, thickness: 1.5),

            // Total Price Section
            Row(
              children: [
                const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                Obx(() => Text(
                  '৳ ${(cartController.totalPrice.value).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                )),
              ],
            ),
            const SizedBox(height: 30),

            // Payment Method Section
            const Text("Payment Method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Obx(() {
              return Column(
                children: [
                  RadioListTile<String>(
                    title: const Text("Cash on Delivery"),
                    value: 'Cash on Delivery',
                    groupValue: cartController.paymentMethod.value,
                    onChanged: (value) {
                      cartController.paymentMethod.value = value!;
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text("Online Payment"),
                    value: 'Online Payment',
                    groupValue: cartController.paymentMethod.value,
                    onChanged: (value) {
                      cartController.paymentMethod.value = value!;
                    },
                  ),
                ],
              );
            }),

            // Pay Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Show appropriate message based on selected payment method
                    final paymentMessage = cartController.paymentMethod.value == 'Cash on Delivery'
                        ? 'You will pay with Cash on Delivery.'
                        : 'You will pay via Online Payment.';
                    Get.snackbar('Payment', paymentMessage);

                    cartController.completeOrder();
                    Get.snackbar('Payment Successful', 'Your order has been placed');
                    Get.off(() => OrderScreen());
                  },
                  child: Obx(() => Text(
                    '৳ ${(cartController.totalPrice.value).toStringAsFixed(2)}   Pay',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
