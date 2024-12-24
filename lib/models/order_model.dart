import 'package:flutter_ecommerce_ui_o/models/product_model.dart';

import 'address_model.dart';

class OrderModel {
  final String orderId;
  final int totalQuantity;
  final double totalPrice;
  final String orderStatus;
  final String orderDate;
  final Address? address;
  final List<ProductModel> items;

  OrderModel({
    required this.orderId,
    required this.totalQuantity,
    required this.totalPrice,
    required this.orderStatus,
    required this.orderDate,
    required this.address,
    required this.items,
  });
}