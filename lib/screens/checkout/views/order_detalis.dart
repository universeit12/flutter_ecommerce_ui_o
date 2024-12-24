import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/order_model.dart';
import '../add_to_cart_controller.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel? order;

  OrderDetailsScreen(this.order);

  @override
  Widget build(BuildContext context) {
    final AddToCartController cartController = Get.find<AddToCartController>();
    final orderStatus = order?.orderStatus ?? "Pending"; // Use the order status or default to Pending


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
    String formattedDate = formatOrderDate(order!.orderDate);

    return Scaffold(
      appBar: AppBar(title: const Text("Order Details"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order ID and Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order ID: ${order?.orderId}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,color: Colors.black
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: _getStatusColor(order?.orderStatus),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            order?.orderStatus ?? '',
                            style: TextStyle(
                              color: _getTextColor(order?.orderStatus),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Order Date
                    Text(
                      "Order Date:  $formattedDate",
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 12),

                    // Total Quantity and Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Quantity: ${order?.totalQuantity}",
                          style: const TextStyle(fontSize: 16,color: Colors.black),
                        ),
                        Text(
                          "Total: ৳ ${order?.totalPrice.toStringAsFixed(2)}",
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
                          order?.address != null
                              ? '${order?.address!.name}, ${order?.address!.city}, ${order?.address!.zipCode}\n${order?.address!.street}'
                              : 'Not provided',
                          style: const TextStyle(fontSize: 14,color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),

                    // Ordered Items
                    const Text(
                      "Items Ordered",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...order?.items.map((item) {
                      final price = item.priceAfetDiscount?.toDouble() ?? item.price.toDouble();
                      final itemIndex = cartController.cartItems.indexWhere((p) => p.id == item.id);
                      final quantity = itemIndex != -1 ? cartController.quantities[itemIndex] : 1;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.image,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Quantity: $quantity",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "৳${(price * quantity).toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList() ?? [],
                    SizedBox(height: 30,),

                    // Tracking Section
                    const Text(
                      'Track Order',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 20),
                    ..._buildTimelineItems(orderStatus,formattedDate),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to get the status color
  Color _getStatusColor(String? status) {
    switch (status) {
      case "Pending":
        return Colors.orange.shade100;
      case "Confirmed":
        return Colors.green.shade100;
      case "Processed":
        return Colors.blue.shade100;
      case "Out for Delivery":
        return Colors.purple.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  // Helper to get the text color
  Color _getTextColor(String? status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "Confirmed":
        return Colors.green;
      case "Processed":
        return Colors.blue;
      case "Out for Delivery":
        return Colors.purple;
      default:
        return Colors.black;
    }
  }

  List<Widget> _buildTimelineItems(String orderStatus, String formattedDate) {
    List<Map<dynamic, dynamic>> timelineData = [
      {
        'icon': Icons.shopping_cart,
        'title': 'Order Placed',
        'description': 'We have received your order on $formattedDate',
        'status': 'Completed',
      },
      {
        'icon': Icons.check_circle,
        'title': 'Order Confirmed',
        'description': 'We have confirmed your order',
        'status': orderStatus == 'Confirmed' || orderStatus == 'Processed' || orderStatus == 'Out for Delivery' ? 'Completed' : 'Hidden',
      },
      {
        'icon': Icons.shopping_basket,
        'title': 'Order Processed',
        'description': 'We are preparing your order',
        'status': orderStatus == 'Processed' || orderStatus == 'Out for Delivery' ? 'In Progress' : 'Hidden',
      },
      {
        'icon': Icons.delivery_dining,
        'title': 'Out for Delivery',
        'description': 'Your order is out for delivery',
        'status': orderStatus == 'Out for Delivery' ? 'In Progress' : 'Hidden',
      },
    ];

    return timelineData.map((data) {
      if (data['status'] == 'Hidden') {
        return const SizedBox.shrink(); // Skip this item
      } else {
        return _buildTimelineItem(
          icon: data['icon'] as IconData,
          title: data['title'] as String,
          description: data['description'] as String,
          status: data['status'] as String,
        );
      }
    }).toList();
  }

  Widget _buildTimelineItem({
    required IconData icon,
    required String title,
    required String description,
    required String status,
  }) {
    final statusColor = status == 'Completed' ? Colors.green : Colors.orange;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusColor.withOpacity(0.2),
            ),
            child: Icon(
              icon,
              color: statusColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
                const SizedBox(height: 8),
                Text(description,style: const TextStyle(color: Colors.black),),
              ],
            ),
          ),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}
