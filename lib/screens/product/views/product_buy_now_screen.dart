import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/cart_button.dart';
import '../../../entry_point.dart';
import '../../../models/product_model.dart';
import '../../checkout/add_to_cart_controller.dart';
import '../../checkout/cart_controller.dart';
import '../../checkout/views/cart_screen.dart';
import 'components/product_quantity.dart';
import 'components/selected_colors.dart';
import 'components/selected_size.dart';
import 'components/unit_price.dart';

class ProductBuyNowScreen extends StatelessWidget {
  ProductBuyNowScreen({super.key, this.product});
  final ProductModel? product;
  final AddToCartController addToCartController = Get.put(AddToCartController());

  @override
  Widget build(BuildContext context) {
    // Set the unit price for the product when the screen is loaded
    addToCartController.setUnitPrice(product!.priceAfetDiscount?.toDouble() ?? product!.price.toDouble());
   // final CartController cartController = Get.find<CartController>(); // Use the CartController

    return Scaffold(
      bottomNavigationBar: Obx(() {
        // Use total price from the controller
        return CartButton(
          price: addToCartController.totalPrice.value,  // Use dynamic total price
          title: "Add to cart",
          subTitle: "Total price",
          press: () {
            if (product != null && product!.id != null) {
              addToCartController.addToCart(product!); // Call add to cart only if valid
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EntryPoint(),));
              Get.snackbar("Success", "Successfully product add to cart");
            } else {
              // Handle the error case (e.g., show a message)
              print('Product is null or has no valid ID.');
            }
          },

        );
      }),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                Text(
                  product!.title ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_outline),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: AspectRatio(
                      aspectRatio: 1.05,
                      child: Image.network(product!.image.toString()),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: UnitPrice(
                            price: product!.price.toDouble(),
                            priceAfterDiscount: product!.priceAfetDiscount?.toDouble(),
                          ),
                        ),
                        Obx(() {
                          return ProductQuantity(
                            numOfItem: addToCartController.quantity.value,
                            onIncrement: addToCartController.incrementQuantity,
                            onDecrement: addToCartController.decrementQuantity,
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Divider()),
                SliverToBoxAdapter(
                  child: Obx(() {
                    return SelectedColors(
                      colors: const [
                        Color(0xFFEA6262),
                        Color(0xFFB1CC63),
                        Color(0xFFFFBF5F),
                        Color(0xFF9FE1DD),
                        Color(0xFFC482DB),
                      ],
                      selectedColorIndex: addToCartController.selectedColor.value,
                      press: (index) {
                        addToCartController.selectColor(index);
                      },
                    );
                  }),
                ),
                SliverToBoxAdapter(
                  child: Obx(() {
                    return SelectedSize(
                      sizes: const ["S", "M", "L", "XL", "XXL"],
                      selectedIndex: addToCartController.selectedSize.value,
                      press: (index) {
                        addToCartController.selectSize(index);
                      },
                    );
                  }),
                ),
                const SliverToBoxAdapter(child: Divider()),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16.0),
                      Text(
                        "Store pickup availability",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 16.0),
                      const Text("Select a size to check store availability and In-Store pickup options."),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
