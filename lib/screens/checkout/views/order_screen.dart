import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_to_cart_controller.dart';


class OrderScreen extends StatelessWidget {
  final AddToCartController cartController = Get.find<AddToCartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: Obx(() {
        if (cartController.orders.isEmpty) {
          return const Center(child: Text("No orders yet."));
        }
        return ListView.builder(
          itemCount: cartController.orders.length,
          itemBuilder: (context, index) {
            final product = cartController.orders[index];
            final price = product.priceAfetDiscount?.toDouble() ?? product.price.toDouble();
            final quantity = cartController.quantities[index];
            final totalPrice = price * quantity;

            return ListTile(
              leading: Image.network(product.image),
              title: Text(product.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quantity: $quantity'),
                  Text('Total: ৳ ${totalPrice.toStringAsFixed(2)}'),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
