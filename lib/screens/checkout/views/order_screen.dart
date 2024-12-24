import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../add_to_cart_controller.dart';
import 'order_detalis.dart';

class OrderScreen extends StatelessWidget {
  final AddToCartController cartController = Get.find<AddToCartController>();

  String formatOrderDate(String orderDate) {
    try {
      // Replace the " – " with "T" for proper parsing
      DateTime parsedDate = DateTime.parse(orderDate.replaceAll(' – ', 'T'));
      // Format the date to include AM/PM
      return DateFormat('yyyy-MM-dd – hh:mm a').format(parsedDate);
    } catch (e) {
      return "Invalid date format"; // Fallback in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        centerTitle: true,
        //backgroundColor: Colors.teal,
      ),
      body: Obx(() {
        if (cartController.orders.isEmpty) {
          return const Center(
            child: Text(
              "No orders yet.",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 4,right: 4,top: 4),
          itemCount: cartController.orders.length,
          itemBuilder: (context, index) {
            final order = cartController.orders[index];

            // Use the formatOrderDate function
            String formattedDate = formatOrderDate(order.orderDate);

            return InkWell(
              onTap: () {
                Get.to(() => OrderDetailsScreen(order));
              },
              child: Card(
                elevation: 4,
                color:Colors.white ,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order ID and Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order ID: ${order.orderId}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: order.orderStatus == "Pending"
                                  ? Colors.orange.shade100
                                  : Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              order.orderStatus,
                              style: TextStyle(
                                color: order.orderStatus == "Pending"
                                    ? Colors.orange
                                    : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Order Date
                      Text(
                        "Order Date: $formattedDate", // Use formatted date
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 12),

                      // Total Quantity and Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Quantity: ${order.totalQuantity}",
                            style: const TextStyle(fontSize: 16,color:Colors.black),
                          ),
                          Text(
                            "Total: ৳ ${order.totalPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Delivery Address
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Delivery Address",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order.address != null
                                ? '${order.address!.name}, ${order.address!.city}, ${order.address!.zipCode}\n${order.address!.street}'
                                : 'Not provided',
                            style: const TextStyle(fontSize: 14,color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
